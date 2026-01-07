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

## Critical Memory Locations

| Address | Purpose |
|---------|---------|
| $A130EC | MARS signature ('MARS' ASCII) |
| $A15100 | MARS_SYS_INTCTL (ADEN, REN bits) |
| $A15120 | COMM0 (Master SH2 'M_OK' signature) |
| $A15124 | COMM2 (Slave SH2 'S_OK' signature) |
| $A1512C | COMM6 ('VRES' signature) |
| $FF0000 | Work RAM (initialization code copied here) |

---

## References

- 68K_MEMORY_MAP.md - Register addresses
- 68K_INTERRUPT_HANDLERS.md - Exception handlers
- docs/32x-hardware-manual.md - MARS initialization protocol
- docs/32x-technical-info.md - VRES/RV bit handling
