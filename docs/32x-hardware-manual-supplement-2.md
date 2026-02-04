# 32X Hardware Manual Supplement 2

**Document:** MAR-32-R4-SP2-072694
**Date:** July 26, 1994
**Source:** SEGA of America, Inc. Consumer Products Division
**Classification:** CONFIDENTIAL - PROPERTY OF SEGA

---

## Limitations Concerning the SH2 Interrupt

Poor performance occurs in the SH2 concerning the following interrupts:

1. If an external interrupt (VRES, V, H, CMD, PWM) input is in the acknowledge period for interrupt inputs, or external interrupt of lower levels, SH2 will not recognize the external interrupt.

2. When multiple interrupt inputs are entered, there may be branching to the interrupt process routine of a vector number that differs from the interrupt vector originally received. Nevertheless, an accurate value is entered in the SR mask level.

---

## Corrective Action

1. Corrective action is taken by controlling the free-run-timer output of SH2 by software. The corrective process must be done within the external interrupt process routine. A pipeline operation must be considered to prevent the same interrupt from being duplicated.

2. The jump destination of all interrupts, internal and external, are set to the same address and can be avoided by jumping to the original jump destination through the SR value.

---

## Precautions

a) The SR mask should be set to level 1; normal operation will not occur if set at 0.

b) Interrupt of the SH2 internal peripheral module should use levels 2 ~ 5.

c) With the EVA chip cut 2.5, operation is normal although no corrective action is taken since the trouble above is corrected, but because an unmodified chip is used in the initial version of the actual device, corrective action must be taken.

When clearing the external interrupt factor by the program, the pipeline operation must be considered in order that the same interrupt is not applied again. When interrupt factor clear is written to the I/O address, the next instruction is executed before the write operation is completed through the effect of the write buffer. In order to execute the next command after completing the write operation, and if write continues and read is performed from the same address, synchronization is completely done.

---

## Pipeline Operation Timing

### Figure 1: Pipeline Operation When Returning by RTE (External Interrupt)

When returning from the interrupt process through RTE, a 1 cycle interval is required between the read command for synchronization and the RTE command.

```
                                    Completion of Write
                                           |
                                           v     Next Interrupt can be Received
                                                          |
Interrupt Clear Command    [F][D][E][M]........ external write    v
  ex. mov r0,@r1                               min 2 cycle
                                                    |
Synchronous Command        [F][D][E][M]........[W]  external read
  ex. mov @r1, r0              :                    min 2 cycle
                               : 1 cycle
                               v
RTE Command                      [F][D]........[E][M][M]
                                                   :
Delay Slot Command                    [F]         [D][E]
                                                   :
Return Destination Command                       [F][X][E]
  from Interrupt                                   :
                                              5 cycles
                                                   :
IRL3 ~ IRL0                    ____________________v
```

### Figure 2: Pipeline Operation when Authorizing Interrupt by Change of SR (External)

When changing SR value through the LDC command and allowing other interrupts to apply in multiples, a minimum 4 cycle interval is required in between synchronous command and LDC command.

```
                                    Completion of Write
                                           |
                                           v     Next Interrupt can be Received
                                                          |
Interrupt Clear Command    [F][D][E][M]........ external write    v
  ex. mov r0,@r1                               min 2 cycle
                                                    |
Synchronous Command        [F][D][E][M]........[W]  external read
  ex. mov @r1, r0              :                    min 2 cycle
                               :
                               |<-- 4 cycle -->|
                                               v
LDC Command                                  [F][D][E]

Interrupt Forbidden Command                  [F][D][E]

Normal Command                               [F][X][E]
                                                :
                                           5 cycles
                                                :
IRL3 ~ IRL0                    _________________v
```

### Figure 3: Pipeline Operation When Returning by RTE (Internal Peripheral)

The pipeline operation must be considered in keeping the same interrupt from reoccurring (reapplying) when the interrupt factor is from the internal peripheral module. Two cycles are needed until the interrupt from the internal peripheral module is recognized by the CPU, and to transmit interrupt requests that no longer exist.

When returning from the interrupt process through RTE, there is a 1 cycle margin until interrupt is received, even if the RTE command is executed immediately after the read command for synchronization.

```
                                    Completion of Write
                                           |       Next Interrupt can be Received
                                           v                |
Interrupt Clear Command    [F][D][E][M]....   internal peripheral write
  ex. mov r0,@r1                              min 1 cycle   v
                                                    |
Synchronous Command        [F][D][E][M]........[W]  internal peripheral read
  ex. mov @r1, r0                                   min 1 cycle

RTE Command                      [F][D][E]........[M][M]
                                                   :
Delay Slot Command                    [F]         [D][E]
                                                   :
Return Destination Command                       [F][X][E]
  from Interrupt                                   :
                                              2 cycles
                                                   :
Internal Peripheral Interrupt  ____________________v
```

### Figure 4: Pipeline Operation when Authorizing Interrupt by Change of SR (Internal)

When authorizing the change of the SR value through the LDC command and other multiple interrupts, a minimum 2 cycle interval is required in between synchronous command and LDC command.

```
                                    Completion of Write
                                           |       Next Interrupt can be Received
                                           v                |
Interrupt Clear Command    [F][D][E][M]....   internal peripheral write
  ex. mov r0,@r1                              min 1 cycle   v
                                                    |
Synchronous Command        [F][D][E][M]........[W]  internal peripheral read
  ex. mov @r1, r0              :                    min 1 cycle
                               :
                               |<- 2 cycles ->|
                                              v
LDC Command                                 [F][D][E]

Interrupt Command Forbidden                 [F][D][E]

Normal Command                              [F][X][E]
                                                :
                                           2 cycles
                                                :
Internal Peripheral Interrupt  _________________v
```

**Pipeline Stage Legend:**
- **F** = Fetch
- **D** = Decode
- **E** = Execute
- **M** = Memory access
- **W** = Write-back / Wait
- **X** = Stall/bubble

---

## Interrupt Correction Sample Program (July 6, 1994)

### Memory Map Constants

```asm
; Chip Select Base Addresses
CS0             .equ    h'00000000      ; Boot ROM, Register
CS1             .equ    h'02000000      ; Cartridge ROM
CS2             .equ    h'04000000      ; Frame buffer
CS3             .equ    h'06000000      ; SDRAM

; Cache Through Addresses (add h'20000000 to bypass cache)
TH              .equ    h'20000000      ; Cache through
CS0TH           .equ    h'20000000      ; Boot ROM, Register (Cache through)
CS1TH           .equ    h'22000000      ; Cartridge ROM (Cache through)
CS2TH           .equ    h'24000000      ; Frame Buffer (Cache through)
CS3TH           .equ    h'26000000      ; SDRAM (Cache through)
```

### SH2 Internal Peripheral Registers

```asm
; Serial Mode Register
_SERIALMODE     .equ    h'fffffe00      ; Serial Mode Register

; Free Run Timer (FRT)
_FRT            .equ    h'fffffe10      ; Free Run Timer
_TIRE           .equ    h'00            ; Timer Interrupt Enable Register
_TCSR           .equ    h'01            ; Timer Control & Status Register
_FRC_H          .equ    h'02            ; Free Running Counter High
_FRC_L          .equ    h'03            ; Free Running Counter Low
_OCR_H          .equ    h'04            ; Output Compare Register High
_OCR_L          .equ    h'05            ; Output Compare Register Low
_TCR            .equ    h'06            ; Timer Control Register
_TOCR           .equ    h'07            ; Timer Output Compare Control Register

; Cache Control
_CCRREG         .equ    h'fffffe92      ; Cache Control Register

; Division Unit
_JR             .equ    h'ffffff00      ; DIVU
_HRL32          .equ    h'ffffff04      ; DIVU
_HRH            .equ    h'ffffff10      ; DIVU
_HRL            .equ    h'ffffff14      ; DIVU

; DMA Controller
_DMASOURCE0     .equ    h'ffffff80      ; DMA Source Address 0
_DMADEST0       .equ    h'ffffff84      ; DMA Destination Address 0
_DMACOUNT0      .equ    h'ffffff88      ; DMA Transfer Count 0
_DMACHANNEL0    .equ    h'ffffff8c      ; DMA Channel Control 0
_DMASOURCE1     .equ    h'ffffff90      ; DMA Source Address 1
_DMADEST1       .equ    h'ffffff94      ; DMA Destination Address 1
_DMACOUNT1      .equ    h'ffffff98      ; DMA Transfer Count 1
_DMACHANNEL1    .equ    h'ffffff9c      ; DMA Channel Control 1
_DMAVECTORN0    .equ    h'ffffffa0      ; DMA Vector No. N0
_DMAVECTORE0    .equ    h'ffffffa4      ; DMA Vector No. E0
_DMAVECTORN1    .equ    h'ffffffa8      ; DMA Vector No. N1
_DMAVECTORE1    .equ    h'ffffffac      ; DMA Vector No. E1
_DMAOPERATION   .equ    h'ffffffb0      ; DMA Operation
_DMAREQACK0     .equ    h'ffffffb4      ; DMA Request / Ack Select Control 0
_DMAREQACK1     .equ    h'ffffffb8      ; DMA Request / Ack Select Control 1
```

### 32X System Registers (SYSREG)

```asm
; SYSREG Base
_sysreg         .equ    h'00004000+TH   ; SYSREG (cache-through)

; Register Offsets
adapter         .equ    h'00            ; Adapter Control Register
intmask         .equ    h'01            ; Interrupt Mask
standby         .equ    h'02            ; Standby Mode Shift
hcount          .equ    h'05            ; H Interrupt Counter Register
vdpfifo         .equ    h'06            ; Frame Buffer FIFO Condition
dreqctl         .equ    h'07            ; DREQ Control
dreqsource      .equ    h'08            ; DREQ Source Address
dreqdest        .equ    h'0c            ; DREQ Destination Address
dreqlen         .equ    h'10            ; DREQ Length
fifo            .equ    h'12            ; FIFO
vresintclr      .equ    h'14            ; VRES Interrupt Clear
vintclr         .equ    h'16            ; V Interrupt Clear
hintclr         .equ    h'18            ; H Interrupt Clear
cmdintclr       .equ    h'1a            ; CMD Interrupt Clear
pwmintclr       .equ    h'1c            ; PWM Interrupt Clear
comm0           .equ    h'20            ; Communication Port 0
comm2           .equ    h'22            ; Communication Port 2
comm4           .equ    h'24            ; Communication Port 4
comm6           .equ    h'26            ; Communication Port 6
comm8           .equ    h'28            ; Communication Port 8
comm9           .equ    h'29            ; Communication Port 9
comm10          .equ    h'2a            ; Communication Port 10
comm12          .equ    h'2c            ; Communication Port 12
comm14          .equ    h'2e            ; PWM Timer Control
timerctl        .equ    h'30            ; PWM Control
pwmctl          .equ    h'31            ; PWM
cycle           .equ    h'32            ; PWM Cycle
lchwidth        .equ    h'34            ; PWM Left Channel Width
rchwidth        .equ    h'36            ; PWM Right Channel Width
monowidth       .equ    h'38            ; PWM Mono Width
```

### 32X VDP Registers (VDPREG)

```asm
; VDPREG Base
_vdpreg         .equ    h'00004100+TH   ; VDPREG (cache-through)

; Register Offsets
tvmode          .equ    h'00            ; TV Mode Register
bitmapmd        .equ    h'01            ; Bitmap Mode Register
shift           .equ    h'03            ; Shift Control Register
filllength      .equ    h'05            ; Auto Fill Length Register
fillstart       .equ    h'06            ; Auto Fill Start Address Register
filldata        .equ    h'08            ; Auto Fill Data Register
vdpsts          .equ    h'0a            ; VDP Status Register
framectl        .equ    h'0b            ; Frame Buffer Control Register

; Additional VDP Addresses
_palette        .equ    h'00004200+TH   ; Palette RAM (cache-through)
_framebuffer    .equ    CS2TH           ; Frame Buffer
_overwrite      .equ    CS2TH+h'20000   ; Over Write Image
```

### SH2 Exception Vector Table

```asm
; SH2 Vector Table
vector:
        .data.l start                   ; Power On Reset PC
_stack:
        .data.l CS3+h'3ff00             ; Power On Reset SP
        .data.l start                   ; Manual Reset PC
        .data.l CS3+h'3ff00             ; Manual Reset SP
        .data.l error0                  ; General Invalid Command
        .data.l h'00000000              ; System Reserve
        .data.l error0                  ; Slot Invalid Command
        .data.l h'20100400              ; System Reserve (ICE Vector)
        .data.l h'20100420              ; System Reserve (ICE Vector)
        .data.l error0                  ; CPU Address Error
        .data.l error0                  ; DMA Address Error
        .data.l error0                  ; NMI
        .data.l error0                  ; User Break
        .datab.l 19, h'00000000         ; System Reserve
        .datab.l 32, error0             ; Trap Command
        .data.l m_int                   ; Interrupt 1
```

### Interrupt Jump Table

```asm
        .align  4
inttable:
        .data.l noret                           ; Illegal Interrupt
        .data.l noret, noret, noret, noret, noret  ; Level 1 ~ 5
        .data.l pwmint, pwmint, cmdint, cmdint     ; Level 6 ~ 9
        .data.l hint, hint, vint, vint, vresint, vresint  ; Level 10 ~ 15
;
; Odd and even levels for external interrupt vectors should be the same address, as above.
```

### Interrupt Handlers

#### No-Return Handler (Ignore)

```asm
noret:
        rts
        nop
```

#### VRES Interrupt Handler

```asm
vresint:
        mov.l   #_sysreg, r0
        ldc     r0, gbr

        mov.w   r0, @ (vresintclr, gbr)         ; V Interrupt Clear

        mov.l   #_stack, r1                     ; Stack Pointer Change
        mov.l   @r1, r15

        mov.l   #_hotstart, r0                  ; PC Change
        mov     r0, @r15
        mov.l   #h'f0, r0
        mov     r0, @ (4, r15)                  ; SR Mask

        rte
        nop
```

#### V Interrupt Handler (with External Interrupt Corrective Action)

```asm
vint:
        stc.l   gbr, @-r15

        mov.l   #_sysreg, r0
        ldc     r0, gbr

        mov.l   #h'f0, r0                       ; Interrupt Mask
        ldc     r0, sr

        ; External Interrupt Corrective Action
        mov.l   #_FRT, r1
        mov.b   @ (_TOCR, r1), r0
        xor     #h'02, r0
        mov.b   r0, @ (_TOCR, r1)

        mov.w   r0, @ (vintclr, gbr)            ; V Interrupt clear

;       Other processes (5 clock or more required)
;               |
;               |

        ldc.l   @r15+, gbr
        rts
        nop

; The above should be done the same for H, CMD, PWM also.
```

---

## Key Takeaways

### The SH2 Interrupt Bug

The original SH2 silicon has a bug where:
1. External interrupts can be missed during the acknowledge period of other interrupts
2. The wrong interrupt vector can be jumped to when multiple interrupts arrive simultaneously

### The Corrective Action

The workaround involves:
1. **Toggling the FRT (Free Run Timer) output** - XORing bit 1 of TOCR register
2. **Proper pipeline synchronization** - ensuring write completion before RTE
3. **Setting SR mask to level 1 minimum** - level 0 causes issues
4. **Using same jump destination** for odd/even interrupt levels

### Critical Timing Requirements

| Scenario | Required Cycles |
|----------|-----------------|
| External interrupt → RTE | 1 cycle between sync read and RTE |
| External interrupt → LDC SR | 4 cycles between sync read and LDC |
| Internal interrupt → RTE | 1 cycle margin (automatic) |
| Internal interrupt → LDC SR | 2 cycles between sync read and LDC |

### Memory Access Pattern for Synchronization

```asm
; Write to clear interrupt
mov.w   r0, @(intclr, gbr)      ; Write interrupt clear

; Read back from same address to synchronize
mov.w   @(intclr, gbr), r0      ; Read for synchronization (wait for write completion)

; Now safe to return or change SR
rte
nop
```

---

## Cross-Reference

- **Main Hardware Manual:** [32x-hardware-manual.md](32x-hardware-manual.md)
- **Known Hardware Bugs:** [32x-technical-info.md](32x-technical-info.md)
- **Development Guide:** [development-guide.md](development-guide.md)
