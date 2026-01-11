# 68K Entry Point & Initialization - Virtua Racing Deluxe

**Project**: Virtua Racing Deluxe (USA).32x
**Date**: 2026-01-06

## Overview

The 68K initialization sequence handles:
1. MARS adapter detection
2. Security code execution
3. Z80 initialization
4. Work RAM setup
5. Jump to main code

## Entry Point ($008803F0)

The Initial PC vector at $000004 points to $008803F0.

```asm
; ═══════════════════════════════════════════════════════════════════════════
; EntryPoint: 68K Program Entry Point
; ═══════════════════════════════════════════════════════════════════════════
; Address: $008803F0 - $008804BE
; Size: ~207 bytes
; Called by: Hardware reset (vector table)
;
; Purpose: Main entry point after reset. Performs critical initialization:
;          1. Check for MARS adapter presence
;          2. Disable interrupts
;          3. Initialize Z80 and PSG
;          4. Clear work RAM
;          5. Jump to initialization code in RAM
;
; Input: None (fresh reset)
; Output: Never returns (jumps to RAM code)
; Modifies: All registers
; ═══════════════════════════════════════════════════════════════════════════

; --- Initial Setup ---
008803F0  287C FFFFFFC0       MOVEA.L #$FFFFFFC0,A4   ; A4 = -64 (relative offset)
008803F6  23FC 00000000 00A15128  MOVE.L #0,COMM4      ; Clear COMM4 (SH2 comm)
00880400  46FC 2700            MOVE.W  #$2700,SR       ; Disable all interrupts (IPL=7)
00880404  4BF9 00A10000        LEA     MD_IO_BASE,A5   ; A5 = I/O base address

; --- MARS Adapter Detection ---
0088040A  7001                 MOVEQ   #1,D0           ; D0 = 1 (MARS present flag)
0088040C  0CAD 4D415253 30EC  CMPI.L  #'MARS',$30EC(A5) ; Check for 'MARS' signature
00880414  6600 03E6            BNE     $008807FC       ; If not found, error handler

; --- MARS Status Check ---
00880418  082D 0007 5101       BTST    #7,$5101(A5)    ; Test MARS_SYS_INTCTL bit 7
0088041E  67F8                 BEQ     $00880418       ; Wait until set (MARS ready)

; --- Additional Hardware Checks ---
00880420  4AAD 0008            TST.L   $0008(A5)       ; Test I/O register
00880424  6710                 BEQ     $00880436       ; Skip if zero
00880426  4A6D 000C            TST.W   $000C(A5)       ; Test another register
0088042A  670A                 BEQ     $00880436       ; Skip if zero
0088042C  082D 0000 5101       BTST    #0,$5101(A5)    ; Test ADEN bit
00880432  6600 03B8            BNE     $008807EC       ; Branch if set

; --- Region Detection ---
00880436  102D 0001            MOVE.B  MD_VERSION,D0   ; Read version register
0088043A  0200 000F            ANDI.B  #$0F,D0         ; Mask region bits
0088043E  6706                 BEQ     $00880446       ; Skip if domestic (Japan)
00880440  2B78 055A 4000       MOVE.L  ($055A).W,$4000(A5) ; Copy region data

; --- Setup and BSR Calls ---
00880446  7200                 MOVEQ   #0,D1           ; Clear D1
00880448  2C41                 MOVEA.L D1,A6           ; A6 = 0
0088044C  41F9 000004D4        LEA     $004D4,A0       ; Load data table address
00880452  6100 0152            BSR     $008805A6       ; Call init function 1
00880456  6100 0176            BSR     $008805CE       ; Call init function 2

; --- Z80 Initialization ---
0088045A  47F9 000004E8        LEA     $004E8,A3       ; Z80 code source
00880460  43F9 00A00000        LEA     Z80_RAM,A1      ; Z80 RAM destination
00880466  45F9 00C00011        LEA     PSG,A2          ; PSG register

; --- Z80 Bus Request & Reset ---
0088046C  3E3C 0100            MOVE.W  #$0100,D7       ; D7 = $100 (counter)
00880470  7000                 MOVEQ   #0,D0           ; D0 = 0
00880472  3B47 1100            MOVE.W  D7,Z80_BUSREQ   ; Request Z80 bus
00880476  3B47 1200            MOVE.W  D7,Z80_RESET    ; Assert Z80 reset
0088047A  012D 1100            BTST    D0,Z80_BUSREQ   ; Test bus request
0088047E  66FA                 BNE     $0088047A       ; Wait for bus

; --- Copy Z80 Code ---
00880480  7425                 MOVEQ   #37,D2          ; Counter = 38 bytes
00880482  12DB                 MOVE.B  (A3)+,(A1)+     ; Copy byte
00880484  51CA FFFC            DBRA    D2,$00880482    ; Loop

; --- Release Z80 ---
00880488  3B40 1200            MOVE.W  D0,Z80_RESET    ; Release reset
0088048C  3B40 1100            MOVE.W  D0,Z80_BUSREQ   ; Release bus

; --- PSG Initialization ---
00880490  3B47 1200            MOVE.W  D7,Z80_RESET    ; Reset Z80 again
00880494  149B                 MOVE.B  (A3)+,(A2)      ; Init PSG channel 1
00880496  149B                 MOVE.B  (A3)+,(A2)      ; Init PSG channel 2
00880498  149B                 MOVE.B  (A3)+,(A2)      ; Init PSG channel 3
0088049A  149B                 MOVE.B  (A3)+,(A2)      ; Init PSG channel 4 (noise)

; --- Clear Work RAM ---
0088049C  41F9 000004C0        LEA     $004C0,A0       ; Load jump target
008804A2  43F9 00FF0000        LEA     WORK_RAM,A1     ; Work RAM start
008804A8  22D8                 MOVE.L  (A0)+,(A1)+     ; Copy 8 longs (32 bytes)
008804AA  22D8                 MOVE.L  (A0)+,(A1)+     ; of initialization code
008804AC  22D8                 MOVE.L  (A0)+,(A1)+     ; to work RAM
008804AE  22D8                 MOVE.L  (A0)+,(A1)+
008804B0  22D8                 MOVE.L  (A0)+,(A1)+
008804B2  22D8                 MOVE.L  (A0)+,(A1)+
008804B4  22D8                 MOVE.L  (A0)+,(A1)+
008804B6  22D8                 MOVE.L  (A0)+,(A1)+

; --- Jump to Work RAM Code ---
008804B8  41F9 00FF0000        LEA     WORK_RAM,A0     ; A0 = work RAM start
008804BE  4ED0                 JMP     (A0)            ; Jump to copied code
```

**Analysis**: Classic 32X boot sequence. The MARS signature check at $A130EC is the key adapter detection. The code then:
1. Waits for MARS ready (bit 7 of INTCTL)
2. Detects region (Japan vs overseas)
3. Initializes Z80 with 38 bytes of code
4. Copies 32 bytes to work RAM and jumps there

---

## MARS Adapter Initialization ($00880838)

```asm
; ═══════════════════════════════════════════════════════════════════════════
; MARSAdapterInit: 32X Adapter Initialization
; ═══════════════════════════════════════════════════════════════════════════
; Address: $00880838 - $00880893
; Size: ~92 bytes
; Called by: Vector table (various exception handlers redirect here)
;
; Purpose: Initialize the MARS (32X) adapter. This code checks the adapter
;          status and performs the security handshake with the SH2 CPUs.
;
; Input: None
; Output: Never returns (jumps to work RAM code)
; Modifies: All registers
; ═══════════════════════════════════════════════════════════════════════════

; --- Check Adapter Control Register ---
00880838  49F9 00A15100        LEA     MARS_SYS_BASE,A4 ; A4 = 32X register base
0088083E  082C 0000 0001       BTST    #0,$0001(A4)     ; Test ADEN bit (Adapter Enable)
00880844  6720                 BEQ     $00880866        ; Branch if disabled
00880846  082C 0001 0001       BTST    #1,$0001(A4)     ; Test REN bit (ROM Enable)
0088084C  665A                 BNE     $008808A8        ; Branch if enabled

; --- Setup Base Registers ---
0088084E  4BF9 00A10000        LEA     MD_IO_BASE,A5    ; A5 = I/O base
00880854  287C FFFFFFC0        MOVEA.L #$FFFFFFC0,A4    ; A4 = -64

; --- Prepare Jump to Security Code ---
0088085A  3E3C 0F3C            MOVE.W  #$0F3C,D7        ; D7 = $0F3C (counter?)
0088085E  43F9 008806E4        LEA     $008806E4,A1     ; Security code address
00880864  4ED1                 JMP     (A1)             ; Jump to security

; --- COMM Port Initialization ---
00880866  23FC 00000000 00A15128  MOVE.L #0,COMM4      ; Clear COMM4

; --- Copy Code to Work RAM ---
00880870  41F9 00880894        LEA     $00880894,A0     ; Source address
00880876  43F9 00FF0000        LEA     WORK_RAM,A1      ; Dest = work RAM
0088087C  22D8                 MOVE.L  (A0)+,(A1)+      ; Copy 32 bytes
0088087E  22D8                 MOVE.L  (A0)+,(A1)+
00880880  22D8                 MOVE.L  (A0)+,(A1)+
00880882  22D8                 MOVE.L  (A0)+,(A1)+
00880884  22D8                 MOVE.L  (A0)+,(A1)+
00880886  22D8                 MOVE.L  (A0)+,(A1)+
00880888  22D8                 MOVE.L  (A0)+,(A1)+
0088088A  22D8                 MOVE.L  (A0)+,(A1)+

; --- Jump to Work RAM ---
0088088C  41F9 00FF0000        LEA     WORK_RAM,A0      ; A0 = work RAM
00880892  4ED0                 JMP     (A0)             ; Execute from RAM
```

**Analysis**: This code is reached when the MARS adapter is detected but not yet fully initialized. It checks the ADEN and REN bits, then either jumps to security code or copies initialization code to work RAM.

---

## Security Code ($008806E4)

The security code at $6E4 is part of the MARS security protocol. This code:
1. Communicates with SH2 CPUs via COMM ports
2. Validates the cartridge
3. Enables the 32X hardware

---

## SH2 Handshake ($008808A8)

```asm
; ═══════════════════════════════════════════════════════════════════════════
; SH2Handshake: Wait for SH2 CPUs to Complete Initialization
; ═══════════════════════════════════════════════════════════════════════════
; Address: $008808A8 - $008808E8
; Size: 64 bytes
; Called by: MARS init
;
; Purpose: Wait for both SH2 CPUs (Master and Slave) to signal ready via
;          the COMM registers. This is the synchronization point where the
;          68K waits for the SH2s to complete their boot sequence.
;
; Input: None
; Output: None (waits indefinitely until SH2s ready)
; Modifies: D7
; ═══════════════════════════════════════════════════════════════════════════

; --- Wait for "VRES" Signature ---
008808A8  3E3C 1000            MOVE.W  #$1000,D7        ; Timeout counter
008808AC  0CB9 56524553 00A1512C  CMPI.L #'VRES',COMM6 ; Check for 'VRES' signature
008808B6  57CF FFF4            DBEQ    D7,$008808AC     ; Loop while not equal
008808BA  6700 00FA            BEQ     $008809B6        ; If timeout, error

; --- Call Setup Function ---
008808BE  4EBA 1D7E            JSR     $00882640(PC)    ; Call init function

; --- Clear MARS_SYS_INTCTL Bit ---
008808C2  0039 0003 00A15103   ORI.B   #3,MARS_SYS_INTMASK+1 ; Set interrupt bits

; --- Wait for Master SH2 "M_OK" ---
008808C8  41F9 00A15120        LEA     COMM0,A0         ; COMM0 base
008808CE  0C90 4D5F4F4B        CMPI.L  #'M_OK',(A0)     ; Check Master ready
008808D4  66F8                 BNE     $008808CE        ; Loop until ready

; --- Wait for Slave SH2 "S_OK" ---
008808D8  0CA8 535F4F4B 0004   CMPI.L  #'S_OK',COMM2    ; Check Slave ready
008808E0  66F6                 BNE     $008808D8        ; Loop until ready

; --- Clear COMM0 ---
008808E2  20BC 00000000        MOVE.L  #0,(A0)          ; Clear COMM0

; --- Enable Interrupts and Continue ---
008808E6  40E7                 MOVE    SR,-(SP)         ; Save status
008808E8  46FC 2700            MOVE.W  #$2700,SR        ; Disable interrupts
```

**Analysis**: Critical synchronization point. The 68K waits for:
1. 'VRES' signature in COMM6 (Video RESolution?)
2. 'M_OK' from Master SH2 in COMM0
3. 'S_OK' from Slave SH2 in COMM2

This ensures all three CPUs are ready before proceeding.

---

## Z80 Initialization Code

The 38 bytes copied to Z80 RAM at $A00000:

```asm
; Z80 code loaded at $A00000 (Z80 address space $0000)
; This code runs on the Z80 CPU after initialization

; The exact Z80 code would need to be disassembled with a Z80 disassembler
; But its purpose is to:
; - Initialize sound hardware
; - Set up communication with 68K
; - Enter main sound driver loop
```

---

## Work RAM Initialization

The code copied to $FF0000 (work RAM):

```asm
; Code copied to $FF0000 and executed
; This is the actual continuation of the boot sequence

008804C0  1B7C 0001 5101       MOVE.B  #$01,MARS_SYS_INTCTL+1 ; Enable MARS
008804C6  41F9 000006BC        LEA     $006BC,A0        ; Load next code addr
008804CC  D1FC 00880000        ADDA.L  #$00880000,A0    ; Add ROM base
008804D2  4ED0                 JMP     (A0)             ; Jump to next stage
```

**Analysis**: The work RAM code enables the MARS adapter and jumps to the next initialization stage at $8806BC.

---

## Initialization Call Graph

```
Reset Vector ($000004)
    │
    ▼
EntryPoint ($3F0)
    │
    ├── MARS Detection (check signature at $A130EC)
    │   └── "MARS" string must be present
    │
    ├── Region Detection (MD_VERSION register)
    │   ├── Japan (0x00)
    │   └── Overseas (0x01+)
    │
    ├── Init Functions
    │   ├── BSR $5A6 (init function 1)
    │   └── BSR $5CE (init function 2)
    │
    ├── Z80 Init
    │   ├── Request bus
    │   ├── Copy 38 bytes to Z80 RAM
    │   ├── Release Z80
    │   └── Init PSG (4 channels)
    │
    ├── Copy to Work RAM (32 bytes)
    │
    └── JMP (Work RAM) ──────► Continue boot
                                    │
                                    ▼
                              Enable MARS
                                    │
                                    ▼
                              JMP $8806BC ──► Next stage

Alternative Path (if ADEN/REN not set):
MARSAdapterInit ($838)
    │
    ├── Check ADEN/REN bits
    │
    ├── Jump to Security Code ($6E4)
    │   └── MARS security protocol
    │
    └── SH2 Handshake ($8A8)
        ├── Wait for 'VRES' in COMM6
        ├── Wait for 'M_OK' in COMM0 (Master SH2)
        ├── Wait for 'S_OK' in COMM2 (Slave SH2)
        └── Continue initialization
```

---

## Init Function 1 - func_05A6 ($008805A6)

```asm
; ═══════════════════════════════════════════════════════════════════════════
; func_05A6: VDP Initialization Helper
; ═══════════════════════════════════════════════════════════════════════════
; Address: $008805A6 - $008805CC
; Size: 38 bytes
; Called by: EntryPoint (BSR $5A6 at $880452)
;
; Purpose: Initialize VDP registers by copying data from table pointed by A0.
;          Performs 19 iterations ($12+1) of byte-read and word-write cycle
;          to VDP control port at $C00004.
;
; Input: A0 = Pointer to init data table (set to $4D4 by caller)
; Output: None
; Modifies: D0, D1, D7, A1
; ═══════════════════════════════════════════════════════════════════════════

008805A6  48E7 C040            MOVEM.L D0-D1/A1,-(SP)   ; Save registers
008805AA  43F9 00C0 0004       LEA     $C00004,A1       ; A1 = VDP control port
008805B0  3011                 MOVE.W  (A1),D0          ; Read VDP status (dummy)
008805B2  303C 8000            MOVE.W  #$8000,D0        ; VDP register write base
008805B6  323C 0100            MOVE.W  #$0100,D1        ; Increment value
008805BA  3E3C 0012            MOVE.W  #$0012,D7        ; Counter = 18 (19 iters)

.loop:
008805BE  1018                 MOVE.B  (A0)+,D0         ; Read table byte
008805C0  3280                 MOVE.W  D0,(A1)          ; Write to VDP control
008805C2  D041                 ADD.W   D1,D0            ; D0 += $100 (next reg)
008805C4  51CF FFF8            DBRA    D7,.loop         ; Loop 19 times

008805C8  4CDF 0203            MOVEM.L (SP)+,D0-D1/A1   ; Restore registers
008805CC  4E75                 RTS
```

**Analysis**: Classic MD VDP register initialization. Reads bytes from table and writes them as VDP register commands ($80xx format). The table at $4D4 contains 19 bytes of VDP register initial values.

---

## Init Function 2 - func_05CE ($008805CE)

```asm
; ═══════════════════════════════════════════════════════════════════════════
; func_05CE: Genesis VDP RAM Clear
; ═══════════════════════════════════════════════════════════════════════════
; Address: $008805CE - $0088063C
; Size: 110 bytes
; Called by: EntryPoint (BSR $5CE at $880456)
;
; Purpose: Clear Genesis VDP RAM (VRAM, CRAM, VSRAM) by writing zeros.
;          Waits for DMA completion between operations.
;
; Input: None
; Output: None (VDP RAM cleared)
; Modifies: D0, D7, A0, A1
; ═══════════════════════════════════════════════════════════════════════════

008805CE  48E7 81C0            MOVEM.L D7/A0-A1,-(SP)   ; Save registers
008805D2  41F9 0000 063E       LEA     $063E,A0         ; A0 = init data table
008805D8  43F9 00C0 0004       LEA     $C00004,A1       ; A1 = VDP control port

; Clear CRAM (Color RAM) - 64 words
008805DE  3298                 MOVE.W  (A0)+,(A1)       ; Set CRAM write address
008805E0  3298                 MOVE.W  (A0)+,(A1)       ; (2-word VDP command)
008805E2  3298                 MOVE.W  (A0)+,(A1)       ; Clear word 1
008805E4  3298                 MOVE.W  (A0)+,(A1)       ; Clear word 2
008805E6  3298                 MOVE.W  (A0)+,(A1)       ; Clear word 3
008805E8  3298                 MOVE.W  (A0)+,(A1)       ; Clear word 4
008805EA  3298                 MOVE.W  (A0)+,(A1)       ; Clear word 5
008805EC  2298                 MOVE.L  (A0)+,(A1)       ; Clear 2 words
008805EE  3341 FFFC            MOVE.W  D0,$FFFC(A1)     ; Write to VDP data port
008805F2  3011                 MOVE.W  (A1),D0          ; Read VDP status

; Wait for FIFO empty (DMA complete)
.wait_dma_1:
008805F4  0800 0001            BTST    #1,D0            ; Test FIFO empty bit
008805F8  66F8                 BNE     .wait_dma_1      ; Wait until empty

; Clear more VDP RAM
008805FA  3298                 MOVE.W  (A0)+,(A1)       ; Next command
008805FC  3298                 MOVE.W  (A0)+,(A1)

; Fill with zeros - Loop 1 (16 iterations)
008805FE  7000                 MOVEQ   #0,D0            ; D0 = 0 (fill value)
00880600  22BC C000 0000       MOVE.L  #$C0000000,(A1)  ; VRAM write command
00880606  7E0F                 MOVEQ   #15,D7           ; Counter = 15 (16 iters)

.loop_1:
00880608  3340 FFFC            MOVE.W  D0,$FFFC(A1)     ; Write zero to VDP data
0088060C  3340 FFFC            MOVE.W  D0,$FFFC(A1)
00880610  3340 FFFC            MOVE.W  D0,$FFFC(A1)
00880614  3340 FFFC            MOVE.W  D0,$FFFC(A1)
00880618  51CF FFEE            DBRA    D7,.loop_1       ; 16 * 4 = 64 words

; Fill with zeros - Loop 2 (10 iterations)
0088061C  22BC 4000 0010       MOVE.L  #$40000010,(A1)  ; VSRAM write command
00880622  7E09                 MOVEQ   #9,D7            ; Counter = 9 (10 iters)

.loop_2:
00880624  3340 FFFC            MOVE.W  D0,$FFFC(A1)     ; Write zero to VDP data
00880628  3340 FFFC            MOVE.W  D0,$FFFC(A1)
0088062C  3340 FFFC            MOVE.W  D0,$FFFC(A1)
00880630  3340 FFFC            MOVE.W  D0,$FFFC(A1)
00880634  51CF FFEE            DBRA    D7,.loop_2       ; 10 * 4 = 40 words

00880638  4CDF 0381            MOVEM.L (SP)+,D7/A0-A1   ; Restore registers
0088063C  4E75                 RTS
```

**Analysis**: Clears Genesis VDP memory (CRAM, VRAM, VSRAM) with zeros. Uses VDP write commands and waits for DMA/FIFO completion. Essential for clean video state before 32X takeover.

---

## func_0654 - 32X VDP Initialization ($00880654)

```asm
; ═══════════════════════════════════════════════════════════════════════════
; func_0654: 32X VDP Mode Setup
; ═══════════════════════════════════════════════════════════════════════════
; Address: $00880654 - $00880692
; Size: 62 bytes
; Called by: Boot sequence (2 calls)
;
; Purpose: Initialize 32X VDP registers for bitmap mode operation.
;          Waits for VDP ready, sets mode parameters, and performs
;          initialization loop with status polling.
;
; Input: None
; Output: None (32X VDP initialized)
; Modifies: D0, D1, D7, A1
; ═══════════════════════════════════════════════════════════════════════════

00880654  48E7 C140            MOVEM.L D0-D1/D7/A1,-(SP) ; Save registers
00880658  43F9 00A1 5180       LEA     MARS_VDP_MODE,A1 ; A1 = $A15180 (VDP base)

; Wait for VDP ready (FS bit clear)
.wait_ready:
0088065E  08A9 0007 FF80       BTST    #7,$FF80(A1)     ; Test FS bit at $A15200
00880664  66F8                 BNE     .wait_ready      ; Wait while busy

; Initialize VDP registers
00880666  3E3C 00FF            MOVE.W  #$00FF,D7        ; Counter = 255 (256 iters)
0088066A  7000                 MOVEQ   #0,D0            ; D0 = 0
0088066C  7200                 MOVEQ   #0,D1            ; D1 = 0

.loop:
0088066E  337C 00FF 0004       MOVE.W  #$00FF,$0004(A1) ; Write $FF to FILLEN
00880674  3341 0006            MOVE.W  D1,$0006(A1)     ; Write 0 to FILLADR
00880678  3340 0008            MOVE.W  D0,$0008(A1)     ; Write 0 to FILLDATA

; Wait for operation complete
0088067C  4E71                 NOP                      ; Delay
.wait_op:
0088067E  0829 0001 000B       BTST    #1,$000B(A1)     ; Test complete bit
00880684  66F8                 BNE     .wait_op         ; Wait for clear

00880686  0641 0100            ADDI.W  #$0100,D1        ; D1 += $100
0088068A  51CF FFE8            DBRA    D7,.loop         ; Loop 256 times

0088068E  4CDF 0283            MOVEM.L (SP)+,D0-D1/D7/A1 ; Restore
00880692  4E75                 RTS
```

**Analysis**: Initializes 32X VDP auto-fill registers. Loops 256 times writing fill patterns, likely clearing frame buffer or initializing palette/bitmap mode structures.

---

## func_0694 - Frame Buffer Clear ($00880694)

```asm
; ═══════════════════════════════════════════════════════════════════════════
; func_0694: Clear 32X Frame Buffer
; ═══════════════════════════════════════════════════════════════════════════
; Address: $00880694 - $008806C2
; Size: 46 bytes
; Called by: Boot sequence (1 call)
;
; Purpose: Clear one frame buffer by writing 32 iterations of 4 longwords.
;          Total: 32 * 16 bytes = 512 bytes cleared per call.
;
; Input: A0 = Source for fill value (D0)
; Output: None (frame buffer cleared)
; Modifies: D7, A0-A1
; ═══════════════════════════════════════════════════════════════════════════

00880694  48E7 8180            MOVEM.L D7/A0-A1,-(SP)   ; Save registers
00880698  41F9 00A1 5200       LEA     $A15200,A1       ; A1 = Frame buffer base

; Wait for frame buffer ready
.wait_ready:
0088069E  08A8 0007 FF00       BTST    #7,$FF00(A1)     ; Test FS bit
008806A4  66F8                 BNE     .wait_ready      ; Wait while busy

; Clear loop
008806A6  3E3C 001F            MOVE.W  #$001F,D7        ; Counter = 31 (32 iters)

.loop:
008806AA  20C0                 MOVE.L  D0,(A0)+         ; Write long 1
008806AC  20C0                 MOVE.L  D0,(A0)+         ; Write long 2
008806AE  20C0                 MOVE.L  D0,(A0)+         ; Write long 3
008806B0  20C0                 MOVE.L  D0,(A0)+         ; Write long 4
008806B2  51CF FFF6            DBRA    D7,.loop         ; 32 * 16 bytes

008806B6  4CDF 0181            MOVEM.L (SP)+,D7/A0-A1   ; Restore
008806BA  4E75                 RTS
```

**Analysis**: Clears 512 bytes of frame buffer memory with value in D0. Called during boot to ensure clean frame buffer state before rendering.

---

## func_0FBE - Work RAM Code Copy ($00880FBE)

```asm
; ═══════════════════════════════════════════════════════════════════════════
; func_0FBE: Copy Init Code to Work RAM
; ═══════════════════════════════════════════════════════════════════════════
; Address: $00880FBE - $0088101C
; Size: 94 bytes
; Called by: Boot sequence (1 call)
;
; Purpose: Copy initialization code from ROM to Work RAM ($FF0000) and
;          perform Z80 bus request/initialization. Two separate copy
;          operations with different source/dest pairs.
;
; Input: None
; Output: None (code copied to Work RAM)
; Modifies: D7, A0-A1
; ═══════════════════════════════════════════════════════════════════════════

00880FBE  7E0B                 MOVEQ   #11,D7           ; Counter 1 = 11 (12 words)
00880FC0  41FA FFD0            LEA     -$30(PC),A0      ; A0 = source (PC-rel)
00880FC4  43F9 00FF 0000       LEA     WORK_RAM,A1      ; A1 = $FF0000
00880FCA  4EFA 000E            JMP     $00880FDA(PC)    ; Jump to copy routine

; Second copy setup
00880FCE  7E09                 MOVEQ   #9,D7            ; Counter 2 = 9 (10 words)
00880FD0  41FA FFD8            LEA     -$28(PC),A0      ; Different source
00880FD4  43F9 00FF 0000       LEA     WORK_RAM,A1      ; Same dest
00880FDA  46FC 2700            MOVE.W  #$2700,SR        ; Disable interrupts

; Copy loop
.copy_loop:
00880FDE  32D8                 MOVE.W  (A0)+,(A1)+      ; Copy word
00880FE0  51CF FFFC            DBRA    D7,.copy_loop    ; Loop

00880FE4  46FC 2300            MOVE.W  #$2300,SR        ; Enable interrupts
00880FE8  4E75                 RTS

; Additional Z80 control section
00880FEA  40E7                 MOVE    SR,-(SP)         ; Save SR
00880FEC  46FC 2700            MOVE.W  #$2700,SR        ; Disable interrupts
00880FF0  33FC 0100 00A1 1100  MOVE.W  #$0100,Z80_BUSREQ ; Request Z80 bus

; Wait for Z80 bus
.wait_z80:
00880FF8  0839 0000 00A1 1100  BTST    #0,Z80_BUSREQ    ; Test bus grant
00881000  66F6                 BNE     .wait_z80        ; Wait until granted

00881002  4EBA 08D4            JSR     $008818D8(PC)    ; Call Z80 init routine
00881006  33FC 0000 00A1 1100  MOVE.W  #0,Z80_BUSREQ    ; Release Z80 bus
0088100E  46DF                 MOVE    (SP)+,SR         ; Restore SR

00881010  41FA 0022            LEA     $22(PC),A0       ; Load data address
00881014  11FC 0081 C874       MOVE.B  #$81,$FFC874     ; Write to RAM flag
0088101A  11E8 0001 C874       MOVE.B  1(A0),$FFC874    ; Copy byte
0088101C  ... (continues)
```

**Analysis**: Complex initialization function that:
1. Copies code from ROM to Work RAM in two phases
2. Requests Z80 bus and performs Z80 initialization
3. Writes configuration flags to Work RAM
4. Calls external init routine via JSR

---

## func_1140 - Data Decompressor ($00881140)

```asm
; ═══════════════════════════════════════════════════════════════════════════
; func_1140: RLE/Bit-Packed Data Decoder
; ═══════════════════════════════════════════════════════════════════════════
; Address: $00881140 - $008811E2
; Size: 162 bytes
; Called by: Boot sequence (1 call)
;
; Purpose: Decompress or decode bit-packed data. Uses complex bit shifting,
;          masking, and conditional logic to extract nibbles and bytes from
;          compressed format. Likely used for decompressing init data tables.
;
; Input: A0 = Source compressed data
;        A1 = Destination buffer
;        D6 = Size/control parameter
; Output: Decompressed data written to (A1)
; Modifies: D0-D3, D6-D7, A3
; ═══════════════════════════════════════════════════════════════════════════

00881140  3E06                 MOVE.W  D6,D7            ; D7 = size counter
00881142  5147                 SUBQ.W  #8,D7            ; Adjust counter
00881144  3205                 MOVE.W  D5,D1            ; Copy control value
00881146  EE69                 ROR.W   #7,D1            ; Rotate right 7 bits
00881148  0C01 00FC            CMPI.B  #$FC,D1          ; Check for special value
0088114C  643E                 BCC     .special_case    ; Branch if >= $FC

; Main decode loop
0088114E  0241 00FF            ANDI.W  #$00FF,D1        ; Mask to byte
00881152  D241                 ADD.W   D1,D1            ; D1 *= 2 (word index)
00881154  1031 1000            MOVE.B  0(A1,D1.W),D0    ; Read table byte
00881158  4880                 EXT.W   D0               ; Sign extend
0088115A  9C40                 SUB.W   D0,D6            ; Adjust size
0088115C  0C46 0009            CMPI.W  #9,D6            ; Check threshold
00881160  6406                 BCC     .continue        ; Branch if >= 9
00881162  5046                 ADDQ.W  #8,D6            ; Adjust back
00881164  E145                 ASL.W   #8,D5            ; Shift control left
00881166  1A18                 MOVE.B  (A0)+,D5         ; Read next byte

.continue:
00881168  1231 1001            MOVE.B  1(A1,D1.W),D1    ; Read second byte
0088116C  3001                 MOVE.W  D1,D0            ; Copy to D0
0088116E  0241 000F            ANDI.W  #$000F,D1        ; Mask low nibble
00881172  0240 00F0            ANDI.W  #$00F0,D0        ; Mask high nibble
00881176  E848                 LSR.W   #4,D0            ; Shift to low nibble

; Bit manipulation and output
00881178  E98C                 ROL.L   #4,D4            ; Rotate accumulator
0088117A  8801                 OR.B    D1,D4            ; Merge nibble
0088117C  5343                 SUBQ.W  #1,D3            ; Decrement pixel count
0088117E  6606                 BNE     .no_output       ; Skip if not ready

; Output byte
00881180  4ED3                 JMP     (A3)             ; Jump to output routine
00881182  7800                 MOVEQ   #0,D4            ; Clear accumulator
00881184  7608                 MOVEQ   #8,D3            ; Reset pixel count

.no_output:
00881186  51C8 FFF0            DBRA    D0,.bit_loop     ; Loop for bits
0088118A  60B4                 BRA     .main_loop       ; Continue main loop

.special_case:
0088118C  5D46                 SUBQ.W  #6,D6            ; Adjust for special
0088118E  0C46 0009            CMPI.W  #9,D6            ; Check threshold
00881192  6406                 BCC     .spec_continue   ; Branch if >= 9
00881194  5046                 ADDQ.W  #8,D6            ; Adjust back
00881196  E145                 ASL.W   #8,D5            ; Shift control
00881198  1A18                 MOVE.B  (A0)+,D5         ; Read byte

.spec_continue:
0088119A  5F46                 SUBQ.W  #7,D6            ; Adjust again
0088119C  3205                 MOVE.W  D5,D1            ; Copy control
0088119E  EC69                 ROR.W   #6,D1            ; Rotate right 6
008811A0  3001                 MOVE.W  D1,D0            ; Copy
008811A2  0241 000F            ANDI.W  #$000F,D1        ; Mask nibble
008811A6  0240 0070            ANDI.W  #$0070,D0        ; Mask bits
008811AA  0C46 0009            CMPI.W  #9,D6            ; Check threshold
008811AE  64C6                 BCC     .continue        ; Branch back
008811B0  5046                 ADDQ.W  #8,D6            ; Adjust
008811B2  E145                 ASL.W   #8,D5            ; Shift
008811B4  1A18                 MOVE.B  (A0)+,D5         ; Read
008811B6  60BE                 BRA     .continue        ; Continue

.done:
008811E0  28 84                MOVE.L  D4,(A4)          ; Store result
008811E2  4E75                 RTS
```

**Analysis**: Sophisticated bit-packed data decoder using nibble extraction, bit rotation, and accumulator-based reassembly. Processes compressed data with variable-length encoding, outputting decoded bytes through jump table at (A3).

---

## func_11E4 - Byte Stream Decoder ($008811E4)

```asm
; ═══════════════════════════════════════════════════════════════════════════
; func_11E4: Byte Stream Decoder with $FF Terminator
; ═══════════════════════════════════════════════════════════════════════════
; Address: $008811E4 - $00881242
; Size: 94 bytes
; Called by: Boot/init sequence (1 call)
;
; Purpose: Decode byte stream with special handling for control bytes.
;          Terminates on $FF byte. Processes $80+ bytes differently using
;          bit shifts and accumulation. Outputs decoded words to table.
;
; Input: A0 = Source byte stream pointer
;        A3 = Output table pointer
; Output: Decoded data written to table at (A3)
; Modifies: D0-D2, D5, D7
; ═══════════════════════════════════════════════════════════════════════════

008811E4  1018                 MOVE.B  (A0)+,D0         ; Read byte
008811E6  0C00 00FF            CMPI.B  #$FF,D0          ; Check terminator
008811EA  6602                 BNE     .not_end         ; Continue if not $FF
008811EC  4E75                 RTS                      ; Return if $FF

.not_end:
008811EE  3E00                 MOVE.W  D0,D7            ; Save byte in D7
008811F0  1018                 MOVE.B  (A0)+,D0         ; Read next byte
008811F2  0C00 0080            CMPI.B  #$80,D0          ; Check if >= $80
008811F6  64EE                 BCC     .loop_back       ; Branch back if < $80

; Process control byte >= $80
008811F8  1200                 MOVE.B  D0,D1            ; Copy to D1
008811FA  0247 000F            ANDI.W  #$000F,D7        ; Mask low nibble of D7
008811FE  0241 0070            ANDI.W  #$0070,D1        ; Mask bits 4-6 of D1
00881202  8E41                 OR.W    D1,D7            ; Combine nibbles
00881204  0240 000F            ANDI.W  #$000F,D0        ; Mask low nibble of D0

00881208  1200                 MOVE.B  D0,D1            ; Copy to D1
0088120A  E149                 ASL.W   #8,D1            ; Shift left 8 bits
0088120C  8E41                 OR.W    D1,D7            ; Combine with D7

0088120E  7208                 MOVEQ   #8,D1            ; Bit counter = 8
00881210  9240                 SUB.W   D0,D1            ; Calculate shift
00881212  660A                 BNE     .no_read         ; Skip if no read needed

; Read additional byte and combine
00881214  1018                 MOVE.B  (A0)+,D0         ; Read byte
00881216  D040                 ADD.W   D0,D0            ; D0 *= 2 (word offset)
00881218  3387 0000            MOVE.W  D7,0(A3,D0.W)    ; Write to table
0088121C  60D2                 BRA     .main_loop       ; Loop back

.no_read:
0088121E  1018                 MOVE.B  (A0)+,D0         ; Read byte
00881220  E368                 ROL.W   #1,D0            ; Rotate left 1
00881222  D040                 ADD.W   D0,D0            ; Double (word offset)

; Multi-byte accumulation
00881224  7A01                 MOVEQ   #1,D5            ; Counter = 1
00881226  E36D                 ROL.W   #1,D5            ; Shift left
00881228  5345                 SUBQ.W  #1,D5            ; Decrement
0088122A  3387 0000            MOVE.W  D7,0(A3,D0.W)    ; Write to table
0088122E  5440                 ADDQ.W  #2,D0            ; Next word offset
00881230  51CD FFF8            DBRA    D5,.write_loop   ; Loop for count

00881234  60BA                 BRA     .main_loop       ; Continue main loop

.complex_decode:
00881236  48E7 FF7C            MOVEM.L D0-D6/A0-A2,-(SP) ; Save many regs
0088123A  3640                 MOVE.W  D0,A3            ; Setup pointer
0088123C  1018                 MOVE.B  (A0)+,D0         ; Read byte
0088123E  4880                 EXT.W   D0               ; Sign extend
00881240  3A40                 MOVE.W  D0,A5            ; Store
00881242  ... (continues)
```

**Analysis**: Byte stream processor with terminator detection ($FF). Handles control bytes differently based on value ($80+ threshold), using bit shifts and word-table writes. Part of init data unpacking system.

---

## func_12F4 - Bit Extraction with Mask Table ($008812F4)

```asm
; ═══════════════════════════════════════════════════════════════════════════
; func_12F4: Bit Field Extraction via Lookup Table
; ═══════════════════════════════════════════════════════════════════════════
; Address: $008812F4 - $008813A2
; Size: 174 bytes (144 bytes code + 30 bytes data table)
; Called by: Data decompression routines (4 calls)
;
; Purpose: Extract variable-length bit fields from bit stream using lookup
;          table of bitmasks. Processes 5 different bit field sizes based on
;          control flags, accumulating bits into output register.
;
; Input: D1 = Control value
;        D3 = Bit field config (from A3)
;        D5 = Bit buffer
;        D6 = Bits available in buffer
;        A0 = Input stream pointer
; Output: D3 = Extracted value
;         D5 = Updated bit buffer
;         D6 = Updated bit count
; Modifies: D0-D7
; ═══════════════════════════════════════════════════════════════════════════

008812F4  360B                 MOVE.W  A3,D3            ; D3 = config value
008812F6  1204                 MOVE.B  D4,D1            ; D1 = control byte
008812F8  D201                 ADD.B   D1,D1            ; D1 *= 2 (shift left)
008812FA  640A                 BCC     .no_flag_1       ; Skip if no carry
008812FC  5346                 SUBQ.W  #1,D6            ; Consume 1 bit
008812FE  0D05                 BTST    #5,D5            ; Test bit 5
00881300  6704                 BEQ     .no_set_1        ; Skip if clear
00881302  0043 8000            ORI.W   #$8000,D3        ; Set bit 15 in D3

.no_set_1:
00881306  D201                 ADD.B   D1,D1            ; Test next flag bit
00881308  640A                 BCC     .no_flag_2
0088130A  5346                 SUBQ.W  #1,D6
0088130C  0D05                 BTST    #5,D5
0088130E  6704                 BEQ     .no_set_2
00881310  0643 4000            ORI.W   #$4000,D3        ; Set bit 14

.no_set_2:
00881314  D201                 ADD.B   D1,D1            ; Test flag 3
00881316  640A                 BCC     .no_flag_3
00881318  5346                 SUBQ.W  #1,D6
0088131A  0D05                 BTST    #5,D5
0088131C  6704                 BEQ     .no_set_3
0088131E  0643 2000            ORI.W   #$2000,D3        ; Set bit 13

.no_set_3:
00881322  D201                 ADD.B   D1,D1            ; Test flag 4
00881324  640A                 BCC     .no_flag_4
00881326  5346                 SUBQ.W  #1,D6
00881328  0D05                 BTST    #5,D5
0088132A  6704                 BEQ     .no_set_4
0088132C  0043 1000            ORI.W   #$1000,D3        ; Set bit 12

.no_set_4:
00881330  D201                 ADD.B   D1,D1            ; Test flag 5
00881332  640A                 BCC     .no_flag_5
00881334  5346                 SUBQ.W  #1,D6
00881336  0D05                 BTST    #5,D5
00881338  6704                 BEQ     .no_set_5
0088133A  0043 0800            ORI.W   #$0800,D3        ; Set bit 11

.no_set_5:
0088133E  3205                 MOVE.W  D5,D1            ; Copy bit buffer
00881340  3E06                 MOVE.W  D6,D7            ; Copy bit count
00881342  9E4D                 SUB.W   A5,D7            ; D7 = bits - field_width

00881344  6428                 BCC     .enough_bits     ; Branch if enough

; Need more bits - refill buffer from stream
00881346  3C07                 MOVE.W  D7,D6            ; Save deficit count
00881348  0646 0010            ADDI.W  #$0010,D6        ; D6 = 16 + deficit
0088134C  4447                 NEG.W   D7               ; D7 = abs(deficit)
0088134E  EF69                 ROL.W   D7,D1            ; Shift left by deficit
00881350  1A10                 MOVE.B  (A0),D5          ; Peek next byte
00881352  EF3D                 ROL.W   D7,D5            ; Rotate bits in
00881354  DE47                 ADD.W   D7,D7            ; D7 *= 2 (word index)
00881356  CA7B 702A            MULU.W  $702A(PC,D7.W),D5 ; Multiply by mask
0088135A  D245                 ADD.W   D5,D1            ; Merge bits
0088135C  300D                 MOVE.W  A5,D0            ; D0 = field width
0088135E  D040                 ADD.W   D0,D0            ; Word offset
00881360  C27B 0020            AND.W   $0020(PC,D0.W),D3 ; Apply mask to result
00881364  D243                 ADD.W   D3,D1            ; Add extracted value
00881366  1A18                 MOVE.B  (A0)+,D5         ; Consume byte
00881368  E14D                 ROL.W   #8,D5            ; Shift to high
0088136A  1A18                 MOVE.B  (A0)+,D5         ; Read low byte
0088136C  4E75                 RTS

.enough_bits:
0088136E  6710                 BEQ     .exact_match     ; Special case
00881370  EE69                 ROR.W   D7,D1            ; Shift right
00881372  300D                 MOVE.W  A5,D0            ; Field width
00881374  D040                 ADD.W   D0,D0            ; To word offset
00881376  C27B 000A            AND.W   $000A(PC,D0.W),D3 ; Mask value
0088137A  D243                 ADD.W   D3,D1            ; Combine
0088137C  300D                 MOVE.W  A5,D0
0088137E  60D8                 BRA     .return

.exact_match:
00881380  ; Bitmask lookup table (16 entries for 1-16 bit fields)
00881380  0001 0003 0007 000F  ; 1, 2, 3, 4 bits
00881388  001F 003F 007F 00FF  ; 5, 6, 7, 8 bits
00881390  01FF 03FF 07FF 0FFF  ; 9, 10, 11, 12 bits
00881398  1FFF 3FFF 7FFF FFFF  ; 13, 14, 15, 16 bits
```

**Analysis**: Sophisticated variable-length bit field extractor. Tests 5 control flags and conditionally sets high-order bits, then extracts n-bit field using bitmask table. Handles buffer refills when insufficient bits remain. Essential for compressed data decoding during initialization.

---

## func_13A4 - Bit Buffer Refill Helper ($008813A4)

```asm
; ═══════════════════════════════════════════════════════════════════════════
; func_13A4: Bit Stream Buffer Refill
; ═══════════════════════════════════════════════════════════════════════════
; Address: $008813A4 - $008813B3
; Size: 16 bytes
; Called by: Bit-stream decoders (multiple calls)
;
; Purpose: Refill bit buffer when it drops below 9 bits. Standard utility for
;          maintaining decode buffer depth. Reads next byte and shifts into
;          low bits while adjusting counter.
;
; Input: D0 = Bits consumed in last operation
;        D6 = Current bits available
;        D5 = Bit buffer
;        A0 = Input stream pointer
; Output: D6 = Updated bit count (may be +8 if refilled)
;         D5 = Refilled buffer (if needed)
;         A0 = Advanced pointer (if byte read)
; Modifies: D6, D5, A0
; ═══════════════════════════════════════════════════════════════════════════

008813A4  9C40                 SUB.W   D0,D6            ; D6 -= consumed bits
008813A6  0C46 0009            CMPI.W  #9,D6            ; Check if < 9 bits remain
008813AA  6406                 BCC     .enough          ; Skip refill if >= 9

; Refill buffer from stream
008813AC  5046                 ADDQ.W  #8,D6            ; Add 8 bits to count
008813AE  E145                 ASL.W   #8,D5            ; Shift buffer left 8 bits
008813B0  1A18                 MOVE.B  (A0)+,D5         ; Read byte into low 8 bits

.enough:
008813B2  4E75                 RTS
```

**Analysis**: Critical helper function called by all bit-stream decoders. Maintains minimum 9-bit lookahead buffer by checking depth after consuming bits and refilling when needed. Simple but essential for continuous decode operations.

---

## func_13B4 - Multi-Byte Bit Decoder ($008813B4)

```asm
; ═══════════════════════════════════════════════════════════════════════════
; func_13B4: Complex Bit Stream Decoder with Stack Buffer
; ═══════════════════════════════════════════════════════════════════════════
; Address: $008813B4 - $00881482
; Size: 206 bytes
; Called by: Data decompression (2 calls)
;
; Purpose: Advanced bit-stream decoder with 2-byte lookahead stored on stack.
;          Processes variable-length codes with multiple decode phases using
;          bit rotation and carry flag testing. Handles literal copies, RLE
;          sequences, and terminator detection.
;
; Input: A0 = Input stream pointer
;        A1 = Output buffer pointer
;        A7 = Stack pointer
; Output: Decoded data written to (A1)
;         Updated A0 pointer
;         D2 = Last decoded value
; Modifies: D2-D7, A0, A1, A7 (stack +/- 2 bytes)
; ═══════════════════════════════════════════════════════════════════════════

008813B4  558F                 SUBQ.L  #2,A7            ; Allocate 2 bytes on stack

; Initialize 2-byte lookahead buffer
008813B6  1F58 0001            MOVE.B  (A0)+,$0001(A7)  ; Read high byte to stack+1
008813BA  1E98                 MOVE.B  (A0)+,(A7)       ; Read low byte to stack
008813BC  3A17                 MOVE.W  (A7),D5          ; Load 16-bit word into D5
008813BE  780F                 MOVEQ   #15,D4           ; Counter = 15 iterations

; Phase 1: Bit-by-bit decode with ROR
.phase1_loop:
008813C0  E24D                 ROR.W   #1,D5            ; Rotate right 1 bit
008813C2  40C6                 MOVE    SR,D6            ; Save CCR (especially C flag)
008813C4  51CC 000C            DBRA    D4,.phase1_loop  ; Loop 15 times

; Reload lookahead buffer
008813C8  1F58 0001            MOVE.B  (A0)+,$0001(A7)  ; Refill high byte
008813CC  1E98                 MOVE.B  (A0)+,(A7)       ; Refill low byte
008813CE  3A17                 MOVE.W  (A7),D5          ; Reload D5
008813D0  780F                 MOVEQ   #15,D4           ; Reset counter

; Test carry from phase 1
008813D2  44C6                 MOVE    D6,CCR           ; Restore saved flags
008813D4  6404                 BCC     .no_literal      ; Branch if no carry

; Literal copy mode
008813D6  12D8                 MOVE.B  (A0)+,(A1)+      ; Copy byte directly
008813D8  60E6                 BRA     .continue        ; Loop back

.no_literal:
008813DA  7600                 MOVEQ   #0,D3            ; Clear accumulator

; Phase 2: Accumulate bit count
.phase2_loop:
008813DC  E24D                 ROR.W   #1,D5            ; Rotate
008813DE  40C6                 MOVE    SR,D6            ; Save CCR
008813E0  51CC 000C            DBRA    D4,.phase2_loop  ; 15 iterations

; Refill and test
008813E4  1F58 0001            MOVE.B  (A0)+,$0001(A7)
008813E8  1E98                 MOVE.B  (A0)+,(A7)
008813EA  3A17                 MOVE.W  (A7),D5
008813EC  780F                 MOVEQ   #15,D4
008813EE  44C6                 MOVE    D6,CCR
008813F0  652C                 BCS     .run_length      ; Branch if carry

; Phase 3: Additional bit extraction
.phase3_loop:
008813F2  E24D                 ROR.W   #1,D5
008813F4  51CC 000C            DBRA    D4,.phase3_loop

008813F8  1F58 0001            MOVE.B  (A0)+,$0001(A7)
008813FC  1E98                 MOVE.B  (A0)+,(A7)
008813FE  3A17                 MOVE.W  (A7),D5
00881400  780F                 MOVEQ   #15,D4
00881402  E353                 ROL.W   #1,D3            ; Accumulate bit into D3

; Phase 4: Final bit
.phase4_loop:
00881404  E24D                 ROR.W   #1,D5
00881406  51CC 000C            DBRA    D4,.phase4_loop

0088140A  1F58 0001            MOVE.B  (A0)+,$0001(A7)
0088140E  1E98                 MOVE.B  (A0)+,(A7)
00881410  3A17                 MOVE.W  (A7),D5
00881412  780F                 MOVEQ   #15,D4
00881414  E353                 ROL.W   #1,D3            ; Accumulate second bit

; Calculate length/offset
00881416  5243                 ADDQ.W  #1,D3            ; D3 = count + 1
00881418  74FF                 MOVEQ   #-1,D2           ; Initialize D2
0088141A  1418                 MOVE.B  (A0)+,D2         ; Read byte
0088141C  6016                 BRA     .finish

.run_length:
; RLE decode - read control byte and data
0088141E  1018                 MOVE.B  (A0)+,D0         ; Control byte
00881420  1218                 MOVE.B  (A0)+,D1         ; Data byte
00881422  74FF                 MOVEQ   #-1,D2           ; Clear high bits
00881424  1401                 MOVE.B  D1,D2            ; Copy data
00881426  EB4A                 ROL.W   #5,D2            ; Rotate left 5 bits
00881428  1400                 MOVE.B  D0,D2            ; Merge control
0088142A  0241 0007            ANDI.W  #$0007,D1        ; Extract 3-bit count
0088142E  6710                 BEQ     .special         ; Check for special case
00881430  1601                 MOVE.B  D1,D3            ; D3 = repeat count

; Copy loop
.copy_loop:
00881432  5243                 SUBQ.W  #1,D3            ; Decrement counter
00881434  ... (copy operations continue)

.special:
00881440  ... (special case handling)

.finish:
00881480  548F                 ADDQ.L  #2,A7            ; Deallocate stack (pop 2 bytes)
00881482  4E75                 RTS
```

**Analysis**: Most sophisticated decoder in Priority 3. Uses multi-phase bit extraction with stack-based lookahead buffer. Implements:
1. Literal byte copy mode (carry flag indicates)
2. Run-length encoding with variable counts
3. Multi-bit code accumulation across phases
4. Complex offset/length calculation
5. Likely LZ77 or similar dictionary-based compression

This is the final stage of the boot decompression pipeline.

---

## Critical Memory Locations

| Address | Purpose |
|---------|---------|
| $A130EC | MARS signature ('MARS' ASCII) |
| $A15100 | MARS_SYS_INTCTL (ADEN, REN bits) |
| $A15120 | COMM0 (Master SH2 'M_OK' signature) |
| $A15124 | COMM2 (Slave SH2 'S_OK' signature) |
| $A1512C | COMM6 ('VRES' signature) |
| $A15180 | MARS_VDP_MODE (32X VDP control) |
| $A15184 | MARS_VDP_FILLEN (Auto-fill length) |
| $A15186 | MARS_VDP_FILLADR (Auto-fill address) |
| $A15188 | MARS_VDP_FILLDATA (Auto-fill data) |
| $A15200 | Frame Buffer base address |
| $A11100 | Z80_BUSREQ (Z80 bus request) |
| $C00004 | MD VDP control port |
| $FF0000 | Work RAM (initialization code copied here) |
| $FFC874 | Init status flag |

---

## References

- [68K_MEMORY_MAP.md](68K_MEMORY_MAP.md) - Register addresses
- [68K_INTERRUPT_HANDLERS.md](68K_INTERRUPT_HANDLERS.md) - Exception handlers
- [docs/32x-hardware-manual.md](docs/32x-hardware-manual.md) - MARS initialization protocol
- [docs/32x-technical-info.md](docs/32x-technical-info.md) - VRES/RV bit handling
