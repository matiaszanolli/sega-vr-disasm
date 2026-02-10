# Genesis Software Development Manual <<Complement>>

**9 JUL 1991 REVISION**
**SEGA ENTERPRISES, LTD.**
**VER2.0**

CONFIDENTIAL - #218 - PROPERTY OF SEGA

---

## Contents

1. [Required Items to Set Up the Genesis](#1-required-items-to-set-up-the-genesis)
   - [S 1 - Cartridge](#s-1---cartridge)
   - [S 2 - Initial Program](#s-2---initial-program)
   - [S 3 - Indication of External RAM Information](#s-3---indication-of-external-ram-information)
   - [S 4 - Indication of ID Modem Information](#s-4---indication-of-id-modem-information)
   - [S 5 - Check Sum](#s-5---check-sum)
2. [VDP Setup Data](#2-vdp-setup-data)
3. [Settings to Preserve Compatibility During Genesis Development](#3-settings-to-preserve-compatibility-during-genesis-development)
4. [68000 Commands and Peripheral Devices](#4-68000-commands-and-peripheral-devices)
   - [S 1 - VDP and 68000 Commands](#s-1---vdp-and-68000-commands)
   - [S 2 - Joystick and Peripheral Devices](#s-2---joystick-and-peripheral-devices)
5. [Precautions for Software Development](#5-precautions-for-software-development)
   - [S 1 - Z80 Cannot Properly Access the Bus on the 68000](#s-1---z80-cannot-properly-access-the-bus-on-the-68000)
   - [S 2 - H_INT and V_INT Are Used in Genesis Programs](#s-2---h_int-and-v_int-are-used-in-genesis-programs)
   - [S 3 - Troubles Due to Interrupts During Communication](#s-3---troubles-due-to-interrupts-during-communication)
   - [S 4 - Precautions When the Control A and B Screens Are Used](#s-4---precautions-when-the-control-a-and-b-screens-are-used)
   - [S 5 - Other Precautions](#s-5---other-precautions)
6. [Notes on Mega Drive Europe Version](#6-notes-on-mega-drive-europe-version)
   - [S 1 - PAL](#s-1---pal)
   - [S 2 - Vertical 30-Cell Mode](#s-2---vertical-30-cell-mode)
7. [Notes on the Backup RAMs](#7-notes-on-the-backup-rams)

---

## 1. Required Items to Set Up the Genesis

### S 1 - Cartridge

The following data (hereafter ID) must always be entered from the address 100H.

| Offset | Contents                        | Item |
|--------|---------------------------------|------|
| 100H   | `'SEGA MEGA DRIVE'`            | 1    |
| 110H   | `'(C)SEGA 1991.MAR'`           | 2    |
| 120H   | `'GAME NAME FOR DOMESTIC USE'`  | 3    |
| 150H   | `'GAME NAME FOR OVERSEAS USE'`  | 4    |
| 180H   | `'GM XXXXXXXX-XX'`             | 5    |
| 18EH   | `$XXXX`                        | 6    |
| 190H   | CONTROL DATA                   | 7    |
| 1A0H   | `$000000,$XXXXXX`              | 8    |
| 1A8H   | `$FF0000,$FFFFFF`              | 9    |
| 1B0H   | EXTERNAL RAM INFORMATION       | 10   |
| 1BCH   | MODEM INFORMATION              | 11   |
| 1C8H   | INHIBITED TO BE USED           | 12   |
| 1F0H   | COUNTRY NAME                   | 13   |

#### Descriptions on the above items

**1. Hardware name**: `'SEGA MEGA DRIVE'` or `'SEGA GENESIS'`

**2.** A company name of four characters long or company code is entered after (C).
- `(C) SEGA` when made or ordered by SEGA.
- `(C) T-XX` (company code) when made by a third party.

**3.** A domestic game name is entered (shifted JIS kanji character codes can be used; however, the name should be entered with as many ASCII characters as possible).

**4.** A overseas game name is entered (shifted JIS kanji character codes can be used; however, the name should be entered with as many ASCII characters as possible).

**5.** Type of the cartridge, product number and version number.
- Cartridge type: `GM` for game, `AI` for education
- Product number: Unique number for each game
- Version: This number should be increased when the product is upgraded.

**6.** Check sum (see [Check Sum](#s-5---check-sum))

**7.** Information on supports for I/O:

| Device              | Code |
|---------------------|------|
| MARK III Joy Stick  | O    |
| GENESIS Joy Stick   | J    |
| Keyboard            | K    |
| Serial (RS232C)     | R    |
| Printer             | P    |
| Tablet              | T    |
| Track ball          | B    |
| Paddle controller   | V    |
| FDD                 | F    |
| CDROM               | C    |
| Analog Joy Stick    | A    |

**8.** ROM capacity: Start address, End address

| Size | Start Address | End Address |
|------|---------------|-------------|
| 2M   | $000000       | $03FFFF     |
| 4M   | $000000       | $07FFFF     |
| 8M   | $000000       | $0FFFFF     |

**9.** RAM capacity (fixed) from $FF0000 to $FFFFFF

**10.** External RAM information (see below)

**11.** Modem information (see below)

**12.** Inhibited to be used (filled with spaces)

**13.** Country name:

| Region | Code |
|--------|------|
| Japan  | J    |
| USA    | U    |
| Europe | E    |

> **Note:** Blank addresses must always be filled with spaces.

- The data must be entered carefully, since the ID data will be used when the product is checked.
- The ID data and the initial program must always be input during the check sample process (see "2 Initial program").

---

### S 2 - Initial Program

The initial program (see `ICD_BLK4.PRG` in the sample program disc) must always be stored in every product, in order to set every product to the same status when the GENESIS is powered on, and to execute the hardware security process and other required processes which must be performed at the resetting.

**This program must always be input as it is, starting with program start. Remember that any product cannot be released, if its initial program is modified, or if it is not input starting with program start.**

---

### S 3 - Indication of External RAM Information

```
1B0H :  dc.b    'RA',%1x1yz000,%abcdefgh
1B4H :  dc.l    Start address, End address
```

- **x** : Data preservation
  - `1` ... Non-volatile ... Backup, EEPROM, etc. where data will not be destroyed even if the power is turned off.
  - `0` ... Volatile ....... Data will be lost when the power is turned off.

- **yz** : Data size
  - `10` .... Even byte (D15 to D8)
  - `11` .... Odd byte (D7 to D0)
  - `00` .... Word
  - `01` .... Others (EEPROMs which are serially accessed, RAMs with 4-bit data bus, etc.)

- **abc** : Device type
  - `000`
  - `001` ... SRAM
  - `010` ... EEPROM
  - `011`
  - `100`
  - `101`
  - `110`
  - `111`

- **defgh** : Spare which is filled with 0s.

**Start address, End address**: Addresses where RAMs are installed or areas of the control ports.

#### Indication Examples

**8k byte backup RAM cartridge:**
- SRAM backup memory
- Odd bytes only
- 8k byte capacity
- Addresses $200001, $203FFF

```asm
    dc.b    'RA',%11111000,%00100000
    dc.l    $200001,$203FFF
```

**EEPROM cartridge (for modem):**

Since the EEPROM for modem is accessed serially, the data size fits into 'others.' Its data preservation fits into '1' since data in EEPROMs will not be destroyed when the power is turned off. The address is set to $200001 for the control ports.

- EEPROM memory
- Serial access
- 1k bit capacity (128 x 8)
- Addresses $200001, $200001

```asm
    dc.b    'RA',%11101000,%01000000
    dc.l    $200001,$200001
```

---

### S 4 - Indication of ID Modem Information

```
1BCH:    'MO','company name','xx,y','zz'
```

- **Company name** : Same as the company name or code which is entered from 110H.

- **xx** : Game number (if this number is the same, communication can be performed).
  - `00` - TELTEL stadium
  - `01` - TELTEL majong
  - `02` - MEGA answer
  - `03` - SEGA NET GAME
  - ...

- **y** : Version No.

- **zz** : Modem information
  - `00` - Japan only: No microphone installed
  - `10` - Japan only: Microphone installed
  - `20` - Overseas only: No microphone installed
  - `30` - Overseas only: Microphone installed
  - `40` - Common to Japan and overseas: No microphone installed
  - `50` - Common to Japan and overseas: Microphone installed
  - `60` - No microphone installed for Japan; microphone installed for overseas
  - `70` - Microphone installed for Japan; no microphone installed for overseas
  - `80`
  - `90`

#### Indication Examples

1) If SEGA released a base ball game 'abcde' with a microphone, then the modem information is like this:

```
1BCH :    'MO','SEGA','00,0','10'
```

2) After that, TOTO (third party with a company code of T-01) released the software 'xyz' with a microphone for Japan use only, which can communicate with (1) abcde. Then the modem information is like this:

```
1BCH :    'MO','T-01','00,1','10'
```

xx is common, but the version number in y is changed. Since xx is common, the information indicates that (1) and (2) can communicate each other.

Note that the game number and the version number are managed by SEGA of JAPAN.

---

### S 5 - Check Sum

The program to examine the check sum is given below. The program starts at 0FF8000H in the RAM space.

First fill the space to be used for this game with -1 (0FFH), and then load all the programs. After this, load this program (including the check sum program), and start it at 0FF8000H. Wait a while and stop the program. The check sum value is stored in the lower word of data register 0 (d0). It is a good idea to release the break points in the memory.

The space to be used for the game must also be filled with -1 (0FFH) before the programs are stored in the ROM.

```asm
end_addr    equ     $1a4
            org     -$8000

start:
            lea     end_addr,a0
            move.l  (a0),d1
            addq.l  #$1,d1
            movea.l #$200,a0
            sub.l   a0,d1
            asr.l   #1,d1           ; counter
            move    d1,d2
            subq.w  #$1,d2
            swap    d1
            moveq   #$0,d0
?12:
            add     (a0)+,d0
            dbra    d2,?12
            dbra    d1,?12
            nop
            nop
            nop
            nop
            nop
            nop
            nop
?1e:
            nop
            nop
            bra.b   ?1e
```

---

## 2. VDP Setup Data

The followings must always be fixed.

**(40-cell mode and NTSC mode)**

| Register | Bit 7 | Bit 6 | Bit 5 | Bit 4 | Bit 3 | Bit 2 | Bit 1 | Bit 0 |
|----------|-------|-------|-------|-------|-------|-------|-------|-------|
| R0       | 0     | 0     | 0     |       | 0     | 1     | 0     | 0     |
| R1       | 0     |       |       |       | 0     | 1     | 0     | 0     |
| R2       | 0     | 0     |       |       |       | 0     | 0     | 0     |
| R3       | 0     | 0     |       |       |       |       |       | 0     |
| R4       | 0     | 0     | 0     | 0     | 0     | 0     |       |       |
| R5       | 0     |       |       |       |       |       |       |       |
| R6       | 0     | 0     | 0     | 0     | 0     | 0     | 0     | 0     |
| R7       | 0     | 0     |       |       |       |       |       |       |
| R8       | 0     | 0     | 0     | 0     | 0     | 0     | 0     | 0     |
| R9       | 0     | 0     | 0     | 0     | 0     | 0     | 0     | 0     |
| R10      |       |       |       |       |       |       |       |       |
| R11      | 0     | 0     | 0     | 0     | 0     |       |       |       |
| R12      | 1     | 0     | 0     | 0     |       |       |       | 1     |
| R13      | 0     | 0     |       |       |       |       |       |       |
| R14      | 0     | 0     | 0     | 0     | 0     | 0     | 0     | 0     |
| R15      |       |       |       |       |       |       |       |       |
| R16      | 0     | 0     |       |       | 0     | 0     |       |       |
| R17      |       | 0     | 0     |       |       |       |       |       |
| R18      |       | 0     | 0     |       |       |       |       |       |
| R19      |       |       |       |       |       |       |       |       |
| R20      |       |       |       |       |       |       |       |       |
| R21      |       |       |       |       |       |       | *     |       |
| R22      |       |       |       |       |       |       |       |       |
| R23      |       |       |       |       |       |       |       |       |

> (*) The DMA registers should be set in such a way that only the actual memory is accessed. Don't attempt to use the techniques taking advantage of image, etc.

---

## 3. Settings to Preserve Compatibility During Genesis Development

### I1 mode on the 68000 side (also applies to ER-ICE, 178 and 378)

**1) Cartridge in use:**

```
MA 0000000,0FFFFFF=NO    (No Memory is assigned for all areas)
MA 0000000,007FFFF=US    (Only required portion of the DRAM area is assigned)
MA 0A00000,0A01FFF=US    (Z80 S-RAM area)
MA 0A04000,0A04FFF=US    (FM sound source area)
MA 0A10000,0A11FFF=US    (I/O and Z80 control)
MA 0C00000,0C00FFF=US    (VDP and sound control)
MA 0FF0000,0FFFFFF=US    (Work RAM area)
```

> **[Note]** When the write protect function is used on the DRAM board, the following steps need to be conducted.
>
> | Step | Action |
> |------|--------|
> | 1    | `MA 0A13000,0A13FFF=US` |
> | 2    | `E 0A130F0=XXXX` (Setting up or releasing) |
> | 3    | `MA 0A13000,0A13FFF=NO` |
>
> It is easier to define a macro by conducting the above steps.

### I2 mode on the Z80 side (also applies to 178, 278 and 378)

```
MA 00000,0FFFF=NO    (No memory is assigned for all area)
MA 00000,01FFF=US    (Z80 SRAM area)
MA 04000,043FF=US    (Ym2612 area)
MA 06000,063FF=US    (bank register area)
MA 07C00,07FFF=US    (PSG on the VDP side)
MA 08000,0FFFF=US    (68000 memory area)
```

---

## 4. 68000 Commands and Peripheral Devices

### S 1 - VDP and 68000 Commands

The TAS command is not supported on the GENESIS. The TAS command serves to test and set up the byte operands which are assigned by the effective address fields. If this command is issued, the test is executed and completed, but the setting will be ignored and not be written.

When VRAM access is made, reading in the write mode or writing in the read mode cannot be executed.

- If and attempt is made to read in the write mode when VRAM access is performed, the VDP suspends the 68000 (the VDP will not return DTACK to the 68000).

- If an attempt is made to write in the read mode when VRAM access is performed, the address for the VRAM access is only increased, but no data is written in the VRAM.

For these reasons, the following commands cannot be used to access the VRAM.

**Example: CLR command**
The CLR command attempts to write 0 after reading the target memory. The VDP suspends the 68000, since the read access occurs when the write access is made to the VRAM.

**Other restricted commands:**
- `CLR`, `NBCD`, `NEG`, `NEGX`, `NOT`, `Scc`, `TAS` (single operand commands)
- `BCHG`, `BSET`, `BCLR` (bit handling commands)
- `ASL`, `LSR`, `LSL`, `ROR`, `ROL`, `ROXR`, `ROXL` (shift and rotate commands)
- `ADDI`, `ADDQ`, `ANDI`, `CMPI`, `EORI`, `ORI`, `SUBI`, `SUBQ` (immediate commands)

The above commands cannot be used to access the VRAM, since read and write operations are made to a single destination in these commands.

---

### S 2 - Joystick and Peripheral Devices

In addition to the joy stick, various peripheral devices can be connected to the I/O port. Since such devices have their own ID codes, the CPU can judge which devices are connected to the I/O port by examining their ID codes. However, remember that some peripheral devices of the MARK III & MS cannot be known by this method.

#### ID Codes

The ID code is expressed by the OR sum logic of DATA 1, 2 and 3, PD3, PD2, PD1 and PD0 which correspond to the external pins, CTRL1, CTRL2 and EXT in the I/O port. The OR sum value is expressed in the following way by data when 1 is output and by data when 0 is output, provided that the TH pin is set in the output mode.

```
ID3 = (PD6 = 1) AND (PD3 OR PD2)
ID2 = (PD6 = 1) AND (PD1 OR PD0)
ID1 = (PD6 = 0) AND (PD3 OR PD2)
ID0 = (PD6 = 0) AND (PD1 OR PD0)
```

The relationships between the ID code and the peripheral device are given below.

| Device Name          | ID3 | ID2 | ID1 | ID0 | Hex  |
|----------------------|-----|-----|-----|-----|------|
| Old joy stick (2TRIG)| 1   | 1   | 1   | 1   | ($F) |
| Not defined          | 1   | 1   | 1   | 0   | ($E) |
| New joy stick (3TRIG)| 1   | 1   | 0   | 1   | ($D) |
| SEGA RESERVED        | 1   | 1   | 0   | 0   | ($C) |
| Not defined          | 1   | 1   | 0   | 1   | ($B) |
| SEGA RESERVED        | 1   | 0   | 1   | 1   | ($A) |
| Not defined          | 1   | 0   | 1   | 0   | ($9) |
| Not defined          | 1   | 0   | 0   | 1   | ($8) |
| Not defined          | 1   | 0   | 0   | 0   | ($7) |
| Not defined          | 0   | 1   | 1   | 1   | ($6) |
| SEGA RESERVED        | 0   | 1   | 1   | 0   | ($5) |
| Not defined          | 0   | 1   | 0   | 1   | ($4) |
| Not defined          | 0   | 1   | 0   | 0   | ($3) |
| Not defined          | 0   | 0   | 1   | 1   | ($2) |
| Not defined          | 0   | 0   | 1   | 0   | ($1) |
| SEGA RESERVED        | 0   | 0   | 0   | 1   | ($0) |

#### Peripheral Devices

**ID = $F : Old joy stick**

The standard joy stick of MARK III & MS contains the 4-direction switch and A and B triggers. Each switch is configured as shown below, which is set to 0 when it is pressed.

| Port  | CTRL1    | CTRL2    | EXT.     |
|-------|----------|----------|----------|
| CTRL  | $A10009  | $A1000B  | $A1000D  |
| DATA  | $A10003  | $A10005  | $A10007  |

**Data register layout (CTRL = all 0s):**

| PD7 | PD6 | PD5 | PD4 | PD3 | PD2 | PD1 | PD0 |
|-----|-----|-----|-----|-----|-----|-----|-----|
| *   | *   | TB  | TA  | R   | L   | D   | U   |

Buttons: U (Up), D (Down), L (Left), R (Right), TA (Trigger A), TB (Trigger B)

---

**ID = $D : New joy stick**

The joy stick of the GENESIS contains the 4-direction switch, A, B and C triggers and Start. The mode can be changed by setting 0 or 1 after the TH pin is set in the output mode. Each switch is configured as shown below, which is set to 0 when it is pressed.

| Port  | CTRL1    | CTRL2    | EXT.     |
|-------|----------|----------|----------|
| CTRL  | $A10009  | $A1000B  | $A1000D  |
| DATA  | $A10003  | $A10005  | $A10007  |

**CTRL register:** PD6 = 1 (output), all others = 0 (input)

| PD7 | PD6  | PD5 | PD4 | PD3 | PD2 | PD1 | PD0 |
|-----|------|-----|-----|-----|-----|-----|-----|
| 0   | 1    | 0   | 0   | 0   | 0   | 0   | 0   |

**Data when TH=1:**

| PD7 | PD6 | PD5 | PD4 | PD3 | PD2 | PD1 | PD0 |
|-----|-----|-----|-----|-----|-----|-----|-----|
| *   | 1   | TC  | TB  | R   | L   | D   | U   |

**Data when TH=0:**

| PD7 | PD6 | PD5 | PD4 | PD3 | PD2 | PD1 | PD0 |
|-----|-----|-----|-----|-----|-----|-----|-----|
| *   | 0   | ST  | TA  | 0   | 0   | D   | U   |

Buttons: U (Up), D (Down), L (Left), R (Right), TA (Trigger A), TB (Trigger B), TC (Trigger C), ST (Start)

It takes about 1 usec from the time the TH is changed until the data is fixed (corresponding to the elapse time of two NOP commands).

#### Joy Pad

Player's button operations are recognized by reading data in $A10003 and $A10005 of the I/O addresses via CONTROL1 and CONTROL2. 7 bits of D6 to D0 in the I/O are sent to CONTROL1 and CONTROL2, but there are eight buttons. So, the D6 bit is used as the select bit, and the button operation is read in two steps.

**Sample Program:**

```asm
    MOVE.B  #$40,$A10009        ; Enter D5 to D0 of CONTROL1.
                                ; D6 is set to output (select bit).
    MOVE.B  #$40,$A10003        ; 1 is output to D6 (C, B, right, left, down or up
                                ; is selected).
    NOP
    NOP
    MOVE.B  $A10003,D0          ; D5 to D0 values are read into register D0.
    MOVE.B  #$00,$A10003        ; 0 is output to D6 (start, A, down or up is
                                ; selected).
    NOP
    NOP
    MOVE.B  $A10003,D1          ; D5 to D0 values are read into register D1.
```

> Each button outputs 0 when it is pressed.

**Register values after the program is executed:**

| Data Reg | D7 | D6 | D5     | D4     | D3    | D2   | D1   | D0 |
|----------|----|----|--------|--------|-------|------|------|----|
| D0       | 0  | 1  | C btn  | B btn  | RIGHT | LEFT | DOWN | UP |
| D1       | 0  | 0  | START  | A btn  | 0     | 0    | DOWN | UP |

**HC 157 logic:**

| S | G | Output |
|---|---|--------|
| X | 1 | -Z-    |
| 0 | 0 | Ax     |
| 1 | 0 | Bx     |

---

## 5. Precautions for Software Development

### S 1 - Z80 Cannot Properly Access the Bus on the 68000

When the Z80 tries to enter the bus cycles of the 68000 to read/write a specific address on the 68000, and when the access to $A100xx is made in the 68000's bus cycle immediately before the bus cycle which the Z80 tries to enter, the cycle of the Z80's entry may become too short to read/write data properly.

**Measure:** When the 68000 accesses $A100xx:

1. Send BUSREQ to the Z80 (suspend the Z80's bus access... `$A11100 = 0100H`)
2. Access $A100xx.
3. Release the BUSREQ of the Z80 (the Z80 starts the bus access... `$A11100 = 0000H`).

Modify the program to execute the above steps.

> **Note:** It will be no problem if the program is designed to be synchronized with V_INT, etc. to eliminate a bad timing for the bus access.

---

### S 2 - H_INT and V_INT Are Used in Genesis Programs

When IE1 = 1 and #10 = 00H are set for VDP register #0, H_INT and V_INT occur at the timings below. Care is required for the timing of H_INT at No.224, in which case, the next V_INT occurs in only 14.7 usec. If the receipt of H_INT at No.224 is prolonged and the opportunity of the V_INT occurrence is missed, that V_INT is canceled. Once the V_INT is canceled, H_INT occurs at No.225 instead of V_INT.

**Timing diagram (NTSC):**

```
Line:     0    1    2    3   ...  222H(DEH)  223H(DFH)  224H
IPL1:     |    |    |    |   ...  |          |           |
IPL2:   H_INT H_INT H_INT  ...  H_INT               V_INT
                                              <---->
                                           63.7us  14.7us
```

**Measure A:**
1. Before H_INT at No.223 is completed, set IE0 = 0 for register #1 to suppress the next occurrence at No.224.
2. Before the receipt of V_INT is completed, set IE0 = 1 for register #1 to make H_INT effective (No.224 also becomes effective).
3. Receive H_INT at No.224.

**Measure B:**
1. Before H_INT at No.223 is completed, set SR = 25xx for the 68000 not to receive No.224.
2. Before the receipt of V_INT is completed, return SR of the 68000 to the previous value (so that No.224 can be received).
3. Receive H_INT at No.224.

> Don't give damages to the flag when you are handling SR.

**The case which was known to cause troubles (due to multiplication):**

```
IPL1:     |                                    | No.224
IPL2:     |  (1) (2) (3)                  | V_INT  (4) (5) (6)
MAIN:     MOVE MOVE M Multiplication  M   |   V   |    |  No.225
PROGRAM:              U is executed    O   |   P   |    |  H_INT is processed.
                      L                V   |   A   |    |
                      T                E   |   R   |    |
                                           |   T   |    |
                              H_INT is     |   I   |    |
                              effective    |   E   |
```

1. After the multiplication, the 68000 decides to receive H_INT by means of MOVE.
2. The 68000 generates VPA (INT-ACK). (No.224 is received.)
3. The VDP cannot find the H_INT after the H_INT occurrence, and so the H_INT is treated as 'un-processed.' The VPA is received after the occurrence of V_INT. This receipt is assumed that V_INT has been received and the H_INT is preserved.
4. Since H_INT at No.224 was received in (1), the processing is executed.
5. The 68000 decides to receive H_INT again after the processing of RTE.
6. The 68000 generates VPA (INT-ACK). The VDP assumes that the VPA is the preserved H_INT, and processes it (at No.225).
7. H_INT (at No.225) is received in (4), and the process is executed again.

---

### S 3 - Troubles Due to Interrupts During Communication

The similar troubles to 'H_INT and V_INT are used' (see section 2) occur in:
- a) 'H_INT and INT during data communication', and
- b) 'V_INT and INT during data communication'.

Since 'INT during data communication' occurs asynchronously with V_INT and H_INT, the measures differ from those described in section 2.

**Measure for a):**
INT and the receive flag are simultaneously set when data communication starts. The receive flag is cleared when received data is read by means of 'INT during data receipt' which does not overlap with H_INT. If it overlaps with H_INT and this H_INT is treated as the second 'INT during data receipt', the receive flag remains cleared. Hence, the proper measure should be selected by using the status of the receive flag to judge whether it is treated as 'INT during data receipt' or 'data receive INT'.

**Measure for b):**
Set the mode in which V_INT does not occur and execute the same treatment as that of V_INT by detecting the V timing using the V_BLK bit for VDP status.

**Others:**
The timing for H_INT or V_INT can be judged by using H_BLK, V_BLK, HV_counter, etc. The receive flag can be used to judge whether 'INT during data receipt' or 'INT during data receipt as which H or V is treated' occurs. Other items and measures should be judged by combing IE0, IE1 and IE2 in the VDP registers, etc.

---

### S 4 - Precautions When the Control A and B Screens Are Used

When vertical 2-cell-unit scroll and horizontal scroll are used together, remember that up to 15 dots at the left of the screen cannot be vertically scrolled if a number which is not a multiple of 16 (i.e., 1 to 15, 17 to 31, etc.) is assigned for the horizontal scroll quantity.

**Reason:** When the horizontal scroll quantity = 16n+m (1 <= m <= 15) is set on the A or B screen, 21 words need to be secured in the RAM for the vertical scroll setting. But the actual capacity of the RAM is only 20 words.

---

### S 5 - Other Precautions

#### Precautions for the main program and Z80 bus requests

Care is required for the following items in the main routine on the 68000 when the Z80 area is accessed.

**Main routine sequence:**
1. A bus request is sent to the Z80.
2. An acknowledgement signal is checked.
3. The interrupt is achieved.
4. A bus request is released within INT (for example, for reading the control pad, etc.).
5. The bus request is released within INT.
6. Operation returns to the main routine.
7. The data is written in the Z80 area. However, the Z80 is usually locked with a bus request, but it has been released in (5).

Hence, the following troubles may occur:
- RAMs of the Z80 may be broken.
- Wrong data may be read when a Z80 bank is accessed.

**Measure:** The interrupt is set to be disabled before step (1) is executed.

#### Precautions for sound access

**1) Sound stops during game play.**

**Cause and measure:**
When the busy flag of status data of the FM sound source (YM2612) is read, (CS,RD,WR,A1,A0)=(0,0,1,0,1) has been set (the address 4001H of the MEGA drive is accessed). However, no provisions are given to the output of the YM2612 under the above conditions. It happens that 'not busy' is set and data is successfully read.

**Measure:** When the busy flag of the FM sound is read, any address other than 4000H address in the MEGA drive must not be accessed.

#### When the reset button is pressed repeatedly

**1) Software runs away when the reset button is pressed repeatedly.**

**Cause and measure:**
- Pressing the reset button resets the CPU, but not the VDP.
- When the reset button is pressed while DMA is performed, the VDP continues the DMA.
- If the VDP is performing DMA when the VDP is accessed immediately after resetting, this access is ignored.

**Measure:** Before accessing the VDP after the initial program (ICD_BLK4), check 'DMA busy' in the status register. If DMA is underway, no access is made.

**2) The software still runs away in some cases even if the above measure is taken.**

**Cause and measure:**
Such troubles can occur, if resetting is made from the time when the parameter set for executing DMA by the CPU is terminated until the first DMA starts.

```
Command: WR VDP | Command: WR VDP | Command: WR VDP | Command: WR DMA | Command: WR DMA
         #21   |          #22    |          #23    |          ADD(L) |          ADD(H)
```

> Although it is very rare for such troubles to occur, take the measure of (1) and another appropriate measure of, for example, not executing DMA immediately after reset.

**Timing when trouble occurs (BR/BG/BGACK signals):**

```
BR    ________/--------\________
BG    ________/--------\________
BGACK ---------\_______/--------
      <-- Trouble occurs if the system is reset during this interval. -->
```

#### Notes on the control pad and read-programs

The control pad is designed and manufactured in such a way that the up and down signals or the left and right signals are entered simultaneously. However, they can rarely be entered simultaneously, when the internal rubber is aged too much or strong forces exceeding the designed tolerance level are applied. So, design the software not to accept such simultaneous signals.

#### Manual Revision Note

> Regarding the access to VRAM, SRAM, VSRAM, please disregard the statement in the manual that you can implement byte access. You can only implement word access and long-word access.

---

## 6. Notes on Mega Drive Europe Version

### S 1 - PAL

**PAL characteristics:**
- The vertical size is increased by two cells.
- Intervals between interrupts are increased (16msec to 20msec).

**Differences in development of MEGA DRIVE software and precautions:**
- The vertical 30-cell mode can be used.
- Since the color change appears at the bottom of the screen, wait about 3msec after entering the V-interrupt, and then change the color.
- Since every operation goes slow when synchronized in interrupts, adjust movements and rates so that motions on the screen appear naturally.
- When sounds are produced in synchronization with interrupts, the tempo needs to be increased. The PAL data table is required.
- When sounds are produced by the FM timer, no modifications for NTSC or PAL are required.

---

### S 2 - Vertical 30-Cell Mode

1. When the vertical 28-cell mode is changed to the vertical 30-cell mode on PAL, the 30-cell mode displays all the cells which have been displayed in the 28-cell mode and the two cells at the bottom which have not been displayed in the 28-cell modes.

2. The 28-cell mode does not display one cell each at the top and the bottom; the 30-cell mode displays the entire screen.

3. The V-blank period is about 5.6 msec in the 28-cell mode; it is about 4.6 msec (shorter) in the 30-cell mode 'approximately same as that on NTSC).

4. By developing software in awareness given to the PAL 30-cell mode, the software, which is common to NTSC and PAL and has minimized border part even in the PAL mode, can easily be developed.

**28-cell mode vs 30-cell mode display comparison:**

```
28-cell mode:                    30-cell mode:
+-------------------+            +-------------------+
| Un-displayed area |            |                   |
|  +-------------+  |            |  30               |
|28| Displayed   |  |            |  Displayed area   |
|  | area        |  |            |                   |
|  +-------------+  |            |                   |
| Un-displayed area |            +-------------------+
+-------------------+
```

**Scroll size 64 x 64 (V-scroll quantity = 0) in the horizontal 40-cell mode:**

```
         <---- 40 ---->
    +---+-------------+----+     Cell unit
    |   |             |    |
 30 | 28|Displayed    |    |
    |   |area         |    |
    |   |             |    |
    +---+-------------+----+
    |                       |
    |   32                  |     When 28-cell mode is changed
    +---+-------------------+     to 30-cell mode, characters
                          32      written in this table are
                                  displayed as they are.
```

When vertical scrolling is performed continuously (e.g., games played with vertical scrolling), it is believed that there will be no problem even if the 28-cell mode is changed to the 30-cell mode.

---

## 7. Notes on the Backup RAMs

There are two types of backup RAMs:
- Odd addresses in 200000H ~ 203FFFH ... 64k bits
- Odd addresses in 200000H ~ 20FFFFH ... 256k bits

The same access methods as those for the work RAMs are used. However, care is required for the following points.

- Data (initial values) in the backup RAMs is not known when the cartridge (product) is shipped. The initialization must always be executed when the power is turned on. (In many cases, they are cleared to $FF when shipped from the factory, but this cannot apply for all cases.)

- Data in the backup RAMs may rarely be destroyed. For this reason, the data must always be check and reproduced. Any important data must not be stored in the first word (in the first address) and last word (in the last address), since there is a high possibility that data in these words may be destroyed.
