# Genesis Technical Bulletins

Official Sega of America technical bulletins for Genesis/Mega Drive developers. Contains errata, workarounds, software guidelines, and hardware documentation.

**Publisher:** Sega of America, Inc. -- Consumer Products Division
**Address:** 125 Shoreway Road, San Carlos, CA 94070 (later: 130 Shoreline Drive, Redwood City, CA 94065)

---

## Table of Contents

- [Bulletin #1 -- Errors Within the Microtec Examples](#bulletin-1----errors-within-the-microtec-examples)
- [Bulletin #2 -- Genesis Loader Board](#bulletin-2----genesis-loader-board)
- [Bulletin #3 -- Precaution When Accessing the Z80 Bus From a 68000 Main (Non-Interrupt) Routine](#bulletin-3----precaution-when-accessing-the-z80-bus-from-a-68000-main-non-interrupt-routine)
- [Bulletin #4 -- Reading the Controller Pads](#bulletin-4----reading-the-controller-pads)
- [Bulletin #5 -- Cartridge Identification](#bulletin-5----cartridge-identification)
- [Bulletin #6 -- Impossible Values Read From the Controller Pad](#bulletin-6----impossible-values-read-from-the-controller-pad)
- [Bulletin #7 -- Software Guidelines (Addenda)](#bulletin-7----software-guidelines-addenda)
- [Bulletin #8 -- Sega Software Development and Game Standards](#bulletin-8----sega-software-development-and-game-standards)
- [Bulletin #9 -- Genesis Software Development Standards](#bulletin-9----genesis-software-development-standards)
- [Bulletin #11 -- Problems During Sound Access](#bulletin-11----problems-during-sound-access)
- [Bulletin #12 -- Problems With Repeated Resets](#bulletin-12----problems-with-repeated-resets)
- [Bulletin #13 -- Corrections to the Genesis Software Manual](#bulletin-13----corrections-to-the-genesis-software-manual)
- [Bulletin #14 -- ROM Splitting](#bulletin-14----rom-splitting)
- [Bulletin #15 -- Genesis Technical Information (VRAM Read Wait / Super Target IC 19)](#bulletin-15----genesis-technical-information-vram-read-wait--super-target-ic-19)
- [Bulletin #16 -- Genesis Technical Information (New Peripherals)](#bulletin-16----genesis-technical-information-new-peripherals)
- [Bulletin #17 -- Genesis Technical Information (EPROMs)](#bulletin-17----genesis-technical-information-eproms)
- [Bulletin #18 -- Lockout Code Reminder](#bulletin-18----lockout-code-reminder)
- [Bulletin #19 -- Mega CD Technical Information (Non-US Market)](#bulletin-19----mega-cd-technical-information-non-us-market)
- [Bulletin #20 -- Genesis Technical Information (Games Over 16 Mbits)](#bulletin-20----genesis-technical-information-games-over-16-mbits)
- [Mega Drive Technical Info #9 -- Cartridge Data (ID) Specification Changes](#mega-drive-technical-info-9----cartridge-data-id-specification-changes)
- [Mega Drive/32X Address Checker Specification](#mega-drive32x-address-checker-specification)

---

## Bulletin #1 -- Errors Within the Microtec Examples

| | |
|---|---|
| **To:** | Developers and Third Parties |
| **From:** | Technical Support |
| **Date:** | March 13, 1991 |
| **Subject:** | Errors Within the Microtec Examples |

There are three errors in examples that are provided. Please make the changes as noted.

In `TESTC68K.bat`:

1. The `asm68k` commands end with a semicolon; remove it and the file will assemble correctly.

2. The link command is incorrect. It should be:
   ```
   LNK68K -c sieve.cmd -o sieve sieve
   ```

3. The C compiler documentation refers to a command line option of `'STRINGSINTEXT'` for allocating string in code segment rather than data segment. The correct spelling for this option is `'STRINTEXT'`.

---

## Bulletin #2 -- Genesis Loader Board

| | |
|---|---|
| **To:** | Developers and Third Parties |
| **From:** | Technical Support |
| **Date:** | June 19, 1990 |
| **Subject:** | Genesis Loader Board |

In order to prevent loading errors, please have the following modification on the Genesis Loader Board. You need to have:

- 2 Resistors 4.7k ohm 1/8W
- 1 Jumper Wire

**Remove the solder resistor before soldering.**

1. Place 4.7k resistor between Centronics Connector Pin #32 and +5V.
2. Place 4.7k resistor between Centronics Connector Pin #13 and +5V.
3. Place jumper wire between Centronics Connector Pin #12 and IC1 74HC74 Pin #7 (GND).

---

## Bulletin #3 -- Precaution When Accessing the Z80 Bus From a 68000 Main (Non-Interrupt) Routine

| | |
|---|---|
| **To:** | Developers and Third Parties |
| **From:** | Technical Support |
| **Date:** | August 2, 1990 |
| **Subject:** | Precaution When Accessing the Z80 Bus From a 68000 Main (Non-Interrupt) Routine |

If the following routine was executed and an interrupt occurred between Step 2 and 3, a data error would occur IF the interrupt also access the Z80 bus.

1. Send Z80 bus request
2. Check acknowledge
3. Writing data to Z80 bus
4. Release Z80 bus

Essentially, the main routine sends a bus request, but before it can conduct its data transfer, the interrupt sends its own bus request. When the interrupt completes, it releases the Z80 bus, as it should. Unfortunately, the main routine expects the bus to be available; thus, an error occurs. When this error occurs, the Z80 RAM is corrupted. One symptom of this error is a sound is SOMETIMES interrupted.

**Solution:** Before Step 1 above, disable interrupts and re-enable when done.

### Controller Pad Read Routine

```asm
;sw_data1+1 is the address for edge data of port_1

read_sw:
            z80_diw                 ; set busreq
            bsr.b       rs_sub
            z80_ei
            rts

rs_sub:
            lea         sw_data1,a5     ;switch data store address
            lea         port_1,a6       ;port for p1
            bsr         ??rs_0
            addq.w      #2,a6           ;a6 = port_2

??rs_0:
            move.b      #$0,(a6)        ;set TH = 0
            nop                         ;wait
            nop
            move.b      (a6),d7         ;input data when TH = 0
            asl.b       #2,d7           ;change data when TH = 0 & wait
            move.b      #$40,(a6)       ;set TH = 1
            andi.w      #11000000b,d7   ;change data when TH = 0 & wait
            move.b      (a6),d6         ;input data when TH = 1
            andi.w      #00111111b,d6
            or.b        d6,d7
            not.b       d7              ;push -> 1
            move.b      (a5),d6         ;copy
            eor.b       d7,d6
            move.b      d7,(a5)+        ; switch data
            and.b       d7,d6
            move.b      d6,(a5)+        ;switch edge data
            rts
```

### Port Initialization

```asm
;******* port initial *******
sw_init:
                                        ;port initial
            moveq       #$40,d7         ;set TH out
            move.b      d7,cont_1
            move.b      d7,cont_2
            move.b      d7,cont_3
            rst
```

### Peripheral ID Codes

```
; input     a6.1 = controller port address
; output    d7.b == $00    Modem
;                  $0d    Mega Drive Joy Stick
;                  $0e    Ram Disk
;                  $0f    ETC. or None
; use       d0,a0
```

### C-callable Port Read Routine

```asm
c:  _port:
            movem.l     d1-d2/a5,-(sp)  ;register push
            dis
            z80_diw
            lea         ??and_data(pc),a5   ;data table address set
            move.b      (a5),cont(a6)   ;Th bit set output
            moveq.l     #0,d7           ;return register initial
            moveq.l     #$08,d1         ;counter set
```

---

## Bulletin #4 -- Reading the Controller Pads

| | |
|---|---|
| **To:** | Developers and Third Parties |
| **From:** | Technical Support |
| **Date:** | September 7, 1990 |
| **Subject:** | Reading the Controller Pads |

When reading a location within the range of `$A10000`-`$A100FF`, which includes the controller pads, the Z80 must have a bus request. If not, the wait state will change from 250ns to 110ns. The shorter time will cause the Z80 to misread ALL further data. Once the ports have been read, the Z80 may be released.

Included with this bulletin is a reprint of the routine that reads the control pads in the Logo Demo program. As you can see, this routine sends a bus request, reads the pads, and then, releases the Z80.

---

## Bulletin #5 -- Cartridge Identification

| | |
|---|---|
| **To:** | Developers and Third Parties |
| **From:** | Technical Support |
| **Date:** | November 26, 1990 |
| **Subject:** | Cartridge Identification |

Every product must have, at location `100h`, an IDTABLE. The table is slightly different for each type of developer. The difference is small, affecting the product code and the copyright, both important for product approval. Please replace the following pages in your Sega Software Manual.

### Standard Format for Sega of America

```asm
;*  SEGA GENESIS CARTRIDGE ID TABLE
;*  STANDARD FORMAT FOR SEGA OF AMERICA
;*  NOV 26 1990 SEGA OF AMERICA

check_sum equ  $0000
      ORG $0100
;-----------------------------------------------------------------------
      dc.b 'SEGA GENESIS    '     ;100
      dc.b '(C)SEGA 199X.XXX'    ;110 release year.month
      dc.b 'your game tile   '   ;120 Japan title
      dc.b '                 '   ;130
      dc.b '                 '   ;140
      dc.b 'your game title  '   ;150 US title
      dc.b '                 '   ;160
      dc.b '                 '   ;170
      dc.b 'GM MK-XXXX -XX'      ;180 product #, version
      dc.w check_sum              ;18E check sum
      dc.b 'J               '    ;190 controller
      dc.l $00000000,$0007ffff,$00ff0000,$00ffffff  ;1a0
      dc.b '                 '   ;1B0
      dc.b '                 '   ;1C0
      dc.b '                 '   ;1D0
      dc.b '                 '   ;1E0
      dc.b 'U               '    ;1F0
```

### Standard Format for Third Parties

```asm
;*  SEGA GENESIS CARTRIDGE ID TABLE
;*  STANDARD FORMAT FOR THIRD PARTIES
;*  NOV 26 1990 SEGA OF AMERICA

check_sum equ  $0000
      ORG $0100
;-----------------------------------------------------------------------
      dc.b 'SEGA GENESIS    '     ;100
      dc.b '(C)T-XX 199X.XXX'    ;110 release year.month
      dc.b 'your game tile   '   ;120 title
      dc.b '                 '   ;130
      dc.b '                 '   ;140
      dc.b 'your game title  '   ;150 title
      dc.b '                 '   ;160
      dc.b '                 '   ;170
      dc.b 'GM T-XXXXXX XX'      ;180 product #, version
      dc.w check_sum              ;18E check sum
      dc.b 'J               '    ;190 controller
      dc.l $00000000,$0007ffff,$00ff0000,$00ffffff  ;1a0
      dc.b '                 '   ;1B0
      dc.b '                 '   ;1C0
      dc.b '                 '   ;1D0
      dc.b '                 '   ;1E0
      dc.b 'U               '    ;1F0
```

### Addendum 1 -- Joysticks/Peripherals

It is possible to connect various peripherals to the I/O Port other than joysticks. Each peripheral has its own ID Code and it is possible for the CPU to check the code to identify what is connected. Be aware that there are some Master System peripherals, which cannot be identified by this method.

#### S1 -- ID Code

The ID Code for the external ports, CTRL1, CTRL2, and EXT., which correspond to the I/O Port's DATA1, 2, 3 (PD3, PD2, PD0) are shown by a logical "or" operation. In concrete terms, setting the TH Pin to output mode and outputting either 1 or 0 as data will yield the following:

```
ID3 = (PD6 = 1) AND (PD3 OR PD2)
ID2 = (PD6 = 1) AND (PD1 OR PD0)
ID1 = (PD6 = 0) AND (PD3 OR PD2)
ID0 = (PD6 = 0) AND (PD1 OR PD0)
```

| Device Name | ID3 | ID2 | ID1 | ID0 | Code |
|---|---|---|---|---|---|
| Old Style Joystick (2 trig) | 1 | 1 | 1 | 1 | ($F) If no joystick |
| Undefined | 1 | 1 | 1 | 0 | ($E) |
| New Style Joystick (3 trig) | 1 | 1 | 0 | 1 | ($D) Power stick |
| Sega Reserved | 1 | 1 | 0 | 0 | ($C) |
| Undefined | 1 | 0 | 1 | 1 | ($B) |
| Sega Reserved | 1 | 0 | 1 | 0 | ($A) |
| Undefined | 1 | 0 | 0 | 1 | ($9) |
| Undefined | 1 | 0 | 0 | 0 | ($8) |
| Undefined | 0 | 1 | 1 | 1 | ($7) |
| Undefined | 0 | 1 | 1 | 0 | ($6) |
| Sega Reserved | 0 | 1 | 0 | 1 | ($5) |
| Undefined | 0 | 1 | 0 | 0 | ($4) |
| Undefined | 0 | 0 | 1 | 1 | ($3) |
| Undefined | 0 | 0 | 1 | 0 | ($2) |
| Undefined | 0 | 0 | 0 | 1 | ($1) |
| Sega Reserved | 0 | 0 | 0 | 0 | ($0) |

### Addendum 2

No Addendum 2.

### Addendum 3 -- Z80/68000 Bus Access Issues

#### 1. When The Z80 Cannot Do A 68000 Bus Access

There are times when the Z80 cannot read or write good data in the 68000's addresses. If the 68000's bus cycle accesses `$100XX` prior to the Z80's interrupt, the bus cycle for the Z80 interrupt is shortened. When this occurs, the Z80 cannot read or write good data.

**When The 68000 Is Accessing $A100XX:**

1. A BUSREQ is sent to the Z80 (Stops the Z80 bus access -- `$A11100=0100H`)
2. `$A100XX` is accessed.
3. The BUSREQ from the Z80 is cleared (The Z80 begins bus access -- `$A11100=0000H`)

Change the 68000's programs to follow the steps shown above.

**Miscellaneous:** If the program structure uses something like V_INT for sync, there should be no problems as long as it is set up so that unfavorable bus access patterns are not created.

#### 2. When Using H_INT And V_INT With A Genesis Program

When the VDP register #0's IE1=1 and register #10=00H, H_INT and V_INT are created with the timing scheme described below. However, a problem occurs during No.224 H_INT's timing. Since the amount of time which is available before V_INT is only 14.7 us, the acceptance of the No.224 H_INT means that the V_INT will miss the V_INT occurrence period. As a result, V_INT is cancelled. Moreover, when the V_INT is cancelled, the No.225 H_INT occurs instead of the V_INT.

**Solution A:**

1. Set register #0's IE1=0 before No.223 H_INT ends in order to prevent No.224 from occurring.
2. Set register #0's IE1=1 before V_INT is accepted in order to make H_INT valid (i.e., No.224 also becomes valid).
3. Process No.224 H_INT.

**Solution B:**

1. Set the 68000's SR=25XX before No.223 H_INT ends in order to prevent No.224 from being processed.
   > **Warning:** When manipulating SR, make sure not to destroy the flag.
2. Restore the 68000's SR prior to the end of V_INT processing (Enables No.224 processing).
3. Process No.224 H_INT.

#### Diagram Of The Problem Caused By A Multiplication Command

1. The MOVE command given after multiplication readies the 68000 to process H_INT.
2. The 68000 creates a VPA (INT_ACK). Since the VDP (for processing No.224) does not see a VPA after H_INT occurs, H_INT is not processed. After V_INT occurs, the 68000 receives a VPA and mistakes this for V_INT processing. H_INT is stored.
3. Processing is executed since H_INT (No.224) was received in Part 1.
4. Given a RTE after processing H_INT, the 68000 readies to process H_INT again.
5. The 68000 creates a VPA (INT_ACK). The VDP (equivalent to No.225) processes the stored H_INT.
6. Receiving H_INT (No.225) in Part 4, processing occurs again.

#### 4. The Interrupt Problem During Data Transfer

Part 2 discussed the problems encountered when using H_INT and V_INT in a program. The same kinds of problems occur during a) an INT involving H_INT data reception and b) an INT involving V_INT and data reception. (Refer back to Part 2 for details)

The "INT during data reception" does not occur in sync in relation to V_INT and H_INT; therefore, the solutions to the problem are different.

**Solution In The Case of a):**

During data reception, the receive flag is set at the same time of the INT. The receive flag is cleared when the data is read by the "INT during data reception," which does not overlap with H_INT. When H_INT occurs again, it overlaps and passes as the second "INT during data reception." After this occurs, the receive flag is left in clear status.

Solve the problem by discriminating between the "INT during data reception" and the H_INT, which passes as the "INT during data reception." This can be determined by checking on the status of the receive flag.

**Solution In The Case of b):**

Set the mode, which prevents the occurrence of V_INT's, and then, use the VDP's V_BLK status bit to detect V-timing. Use this method to perform the same type of processing as V_INT.

**Miscellaneous:**

- It is possible to differentiate H_INT and V_INT timing by using H_BLK, V_BLK, and the HV_counter.
- It is possible to distinguish between the "INT during data reception" and the "H and V that pass as the INT during data reception" by analyzing the receive flag.
- Try to think of other solutions by using IE0, IE1, and IE2 settings within the VDP register.

### Addendum 4

#### 1. Regarding The DMA

When using DMA's other than *FILL VRAM* and *VRAM COPY*, use the following method to program:

1. Send a bus request to the Z80.
2. Base the DMA destination address set section in RAM.
3. Rewrite the one leading word of data after the end of the DMA.

Steps 1 and 2 are used in all cases, except FILL VRAM and VRAM COPY. Step 3 is used for WRAM to VRAM, WRAM to COLOR RAM, and WRAM to VSRAM.

#### 2. Compatibility With The MKIII Mode

VDP Registers #11 through #23 cannot be written over, unless bit 2 of Register #1 is not set to "1."

**Reasons:**

- Registers #11 through #23 are masked for MKIII mode's error trapping purposes.
- MKIII uses Registers #0 through #10.
- The Genesis mode is active when Register #1's bit 2=1.
- The registers are set to 0 on power up.

#### 3. Warnings Regarding Use Of Back-Up RAM

- The back-up RAM data is unformatted when the cartridge (product) is shipped. Always make sure to initialize during power up. (In most cases, the back-up RAM data is cleared with $FF at the factory; however, don't count on this as a matter of fact.)
- Although this does not occur frequently, there may be occasions when the data becomes garbled. Because of this possibility, make sure to check the back-up data and perform reproduction/retrieval processing. Moreover, do not place critical data at leading and ending RAM addresses, since one word in both addresses have a high probability of becoming garbled.

---

## Bulletin #6 -- Impossible Values Read From the Controller Pad

| | |
|---|---|
| **To:** | Developers and Third Parties |
| **From:** | Technical Support |
| **Date:** | April 2, 1991 |
| **Subject:** | Impossible Values Read From the Controller Pad |

It is possible for a well used controller pad to yield incorrect values, specifically: up AND down, left AND right. This is due to the small piece of rubber wearing out inside the pad.

Your routine that handles the values read should be written, so that if the number is NOT one of the expected values, it should re-read the pad to obtain a correct value.

---

## Bulletin #7 -- Software Guidelines (Addenda)

### I. Software Guidelines

#### 1. Z80 Bus Access from 68000 Main Routine

When accessing the Z80 area from within the 68000's main routine, beware of the following:

1. Execute a bus request to the Z80.
2. Confirm execution.
3. An interrupt occurs.
4. A Z80 bus request is executed within the interrupt routine. (Execute for the purpose of reading the controller pad)
5. The bus request is cleared within the interrupt.
6. Return to main routine.
7. Write data to Z80 area.

In principle, the Z80 is left with the Z80 bus request in effect; however, in this example, it is cleared in Step 5.

When this occurs, the following things occur:

- The RAM of the Z80 gets damaged.
- Incorrect data is read during Z80 bank access.

**A Fix For The Problem:** Disable interrupts prior to Step 1.

#### 2. Problems During Sound Access

**Symptom:** Sound output stops during the game.

**Diagnosis Of The Problem:**

The busy flag was read in the FM sound generator YM2612 like this (address 4001H was accessed in the Mega Drive):

```
(CS,RD,WR,A1,A0) = (0,0,1,0,1)
```

However, in the case of the YM2612, its output is not regulated according to the conditions set up above. This results in the device being read as "not busy," and as a consequence, ends up outputting sound.

**A Fix For The Problem:**

When the FM sound generator's busy flag is read, do not access anything else other than:

```
(A1,A0) = (0,0)       (Mega Drive address 4000H)
```

#### 3. Repeated Resets

**Symptom:** The software goes out of control when resets are repeated.

**Diagnosis Of The Problem:**

- When the reset occurs, the CPU is reset; however, the VDP is not reset.
- When the reset occurs during DMA, the VDP continues the DMA.
- The VDP is accessed right after the reset. If this is done while the VDP is executing a DMA, then this access becomes ineffective.

**A Fix For The Problem:**

Before accessing the VDP after the initialization program (ICD_BLK4), check the DMA BUSY status register. If a DMA is being executed, do not attempt to access.

If the problem still persists even after the precautions above are taken: The problem will occur when the reset takes place between the period of time when the CPU has finished setting the parameters to execute the DMA and the actual execution of the DMA itself.

On top of the precautions taken in 1), as an example, make sure not to execute a DMA right after a reset.

### II. Corrections To The Manual

When discussing VRAM, CRAM, VSRAM access, the manual states in Pages 22-27 that byte access is possible; however, in reality, this is false. The reason for this is that after the VDP address register is set, an instruction for a CPU word access (ex. a fetch operation) causes the VDP to think during the next access that it is still a word access.

**From now on, please consider the text regarding byte access in Pages 22-27 as being null and void.**

### III. About Control Pads

Although the control pad is designed and produced so that simultaneous up/down or left/right input is impossible, there are times when simultaneous input occurs due to fatigue of the internal rubber parts or force on the pads, which exceed design specs. **Because of this, from now on, all software should have switch read routines that can process simultaneous directional input.**

Corrections to Mega Drive Addendum 6, Page 3.

### IV. Bank Switching

Although the manual states that the 68000 may set the bank registers; however, in reality, this is not the case. **Please execute bank switching in the Z80 from the Z80.**

---

## Bulletin #8 -- Sega Software Development and Game Standards

### Sega Software Development and Game Standards

The following Sega of America Game Standards Policy should serve as a guideline for the development of Sega-licensed cartridges by defining the types of content and themes inconsistent with Sega's Corporate, Marketing, and Product Development philosophy. SOA will not approve cartridges (i.e., audio visual work, packaging, and instruction manuals):

- with sexually suggestive or explicit content;
- which reflect ethnic, racial, religious, nationalistic, or sexual stereotypes or language;
- which depict excessive graphic violence;
- which use profanity in any form or which incorporate language that could be offensive by prevailing public standards and tastes;
- which encourage or glamorize the use of drugs, alcohol, or tobacco;
- which make an overt political statement;
- which contain depictions of symbols or groups which are an anathema to racial, religious, or ethnic groups;
- which is a potential infringement of a legally protected copyright or trademark.

It is not possible for a single document to cover every possible eventuality in an area as broad and subjective as thematic content. For this reason, these standards of guidance should be one of common sense, practicality, and prevailing public taste.

---

## Bulletin #9 -- Genesis Software Development Standards

**(Revised 01/03/91)**

### I. Initial Display

**A.** The trademark, "SEGA TM", shall be displayed in the center of the screen. Logo code will be provided by SEGA.

**B.** Check the control pad(s) while SEGA logo is displayed. If no control pad is connected or only the 2P control pad is connected, make the loop as follows:

```
SEGA Logo - Title - Demo - Sega Logo
(While no button is pressed.)
```

If the START button on either controller is pressed, the game title should be displayed. If the Player 1 controller is connected, a button press will exit from the Logo to the title. Another press should exit the title.

### II. Title Display

**A.** Display the title sequence and the text, "PUSH START BUTTON." If any button on either controller is pressed at this point, the Start/Option Select screen shall appear.

**B.** Copyright marking (user can exit via any button, but cannot bypass altogether).

1. Original software: (c), the year of publication, copyright holder, e.g., (c)1990 SEGA
2. Licensed software: e.g., (c)1987 TEKKON, PROGRAMMED GAME (c)1990 SEGA (or as required by contract)

**C.** After the title sequence, the screen automatically proceeds to the demonstration mode within 5-10 seconds.

### III. Demonstration

**A.** If the player does not start the game during the title screen (5-10 seconds), the screen shall proceed to the demonstration.

**B.** Turn on the sound. (If not already on)

**C.** If the START button is pressed during the demo, the Logo screen shall appear again.

**D.** If the START button is not pressed during the demo, the SEGA logo shall appear after a certain time.

**Screen flow:**

```
POWER ON
  -> SEGA              (SEGA logo screen)
  -> GAME TITLE         (When START Button is pushed or after ~2 seconds)
  -> PUSH START BUTTON
  -> (c) notice          (If START pressed, go to game screens.
                          Otherwise, in approximately 5-10 seconds...)
  -> DEMONSTRATION       (10-20 seconds, Return to SEGA logo screen.
                          If START button is pushed, go to Logo screen.)
```

### IV. Start/Option Screen

**A.** The Start/Option screen is required with the exception of transferred games and games which might lose their game play characteristics by having the screen.

**B.** Control pad maneuvers and screen display.

Selection shall be made by moving the D-button upward or downward or left and right and pressing the START button.

**One Player:** 1 PLAYER START, OPTIONS

**Two player simultaneous play:**

- **1P Control Pad Only:** 1 PLAYER START, 2 PLAYER START, OPTIONS -- Although the screen indicates 2 PLAYER START, the cursor shall be controlled so that the player cannot select it. Use different colors to indicate selectable/non-selectable items.
- **1P and 2P Control Pads:** Both pads can select. 1P START = play alone with 1P side. 2 PLAYER START = simultaneous play (1P pad = Player 1, 2P pad = Player 2).

**Two player alternate play (if applicable):**

- 1P control pad only: 1 PLAYER START, 2 PLAYER START, OPTIONS -- both selectable. 1 PLAYER START = play along with 1P side. 2 PLAYER START = alternate with 1P side control pad.

**Option Screen:**

| Option | Description |
|---|---|
| LEVEL | Difficulty setting |
| PLAYER | Number of players |
| SOUND TEST | Sound test |
| CONTROL | Control setting |
| RAPID | Continuous shooting setting |

When the player selects OPTIONS on the Start/Option screen, the option screen shall appear. Items selected by D-Button up/down, changed by D-Button sideways. Exit by selecting EXIT and pressing A, B, C, or START.

### V. Password/Name Entry Screen

**A.** Select a clear font (avoid confusion between O/0, 1/l, etc.). Passwords should be 12 characters or less. Subgroup them with different colors. Do not use punctuation marks or BOTH upper and lower case letters.

**B.** Maneuver:
1. Select letters by D-Button, enter by button C.
2. When finished, put cursor on END.
3. To delete letters, hold button C and move cursor, or use RTN and PCD functions.
4. Even if the password is wrong, the letters entered shall not be erased.
5. Movement of the cursor shall be a loop (up-down-left-right).

### VI. Reset/Pause

**A.** When the reset button is pressed during DEMO, the screen shall return to SEGA logo (high scores, option settings, and password should not be cleared).

**B.** During play, the start button shall work as the pause button. During 2 player simultaneous play, both control pads shall be able to pause and cancel.

**C.** During pause, the sound shall be silenced. Background music only shall continue immediately when the pause is released.

**D.** The pause function shall not work when the SEGA logo or the title logo are displayed or during the demonstration.

**E.** PAUSE shall be indicated on the screen during the pause.

> **NOTE:** Adventure and role-playing games may not require the pause mode.

### VII. Basic Maneuvers During The Game Play

**A. General Maneuvers:**

| Button | Function |
|---|---|
| START Button | Start/Pause |
| D-Button | Used to determine the directions |
| Button A | Special functions and rare maneuvers |
| Button B | Passive maneuvers, such as CANCEL |
| Button C | Active maneuvers, such as DECIDE |

**B. Sample Quick Maneuvers** (action and shooting games):

2 actions (e.g., Ghouls 'n Ghosts, Thunder Force II):

| Button | Action |
|---|---|
| Button A | Jump/Sub Shot |
| Button B | Shot/Main Shot |
| Button C | Jump/Sub Shot |

3 actions (e.g., Trojan, Altered Beast):

| Button | Action |
|---|---|
| Button A | Punch |
| Button B | Kick |
| Button C | Jump |

**C. Sample Slow Maneuvers** (RPG, simulation, adventure):

2 actions:

| Button | Action |
|---|---|
| Button A | Decide/Opening Windows |
| Button B | Cancel |
| Button C | Decide/Opening Windows |

3 actions:

| Button | Action |
|---|---|
| Button A | Check Special Functions |
| Button B | Cancel |
| Button C | Decide/Opening Windows |

**D.** Even if there are two actions for the game, all buttons should be utilized. It is convenient if maneuvers can be changed in the option mode.

### VIII. Continue/Ending

**A. CONTINUE:** Shall appear when the game is over, if appropriate (may not apply to sports or RPG's, etc.). Limited to a certain number of times. Screen returns to SEGA logo after 10-20 seconds.

**B.** The ending screen shall not be cancelled, but it can be exited via the START button. Screen returns to SEGA logo after the ending (after 10-20 seconds).

### IX. Game Over

**A.** Shall appear for 60 seconds, then display the SEGA logo.

**B.** Pressing the START button while GAME OVER is indicated shall cause the screen to change and show the Sega logo.

### X. Contents Of The Game

**A.** Important indications (score, etc.) should have a two cell margin on right and left sides and a one cell margin on top and bottom (some monitors do not show these areas well).

**B.** When background music composed by a Third Party is utilized, pay careful attention to the copyright. Copyrights shall be secured for all Third Party music when applicable.

**C.** Names closely related to any particular manufacturer, product, and character, shall not be used.

**D.** Buttons shall work as soon as they are pressed, not released, unless there is a specific approved reason.

**E.** The "Start Button" shall work separately from other buttons.

**F.** High scores and previous players shall be up-to-date scores shown on TITLE, DEMONSTRATION screens. If a 2-player game, both scores shall be displayed simultaneously.

**G.** Title music shall start when the title appears and finish before the demonstration starts.

**H.** The title of the game and names used within the game shall not infringe upon the trademarks of Third Parties.

**I.** At the end of the game, any words or expressions which imply "copyright," "patent," or "invention," shall not be made during credits.

**J.** Developer credits may be included at the end of the game, subject to approval by SEGA.

> **NOTE:** In the case where any question arises as regards the ITEMS set forth in the SEGA GAME SOFTWARE DEVELOPMENT STANDARDS or matters for which no stipulation is made, the developer shall, from time to time as required, consult with the SEGA Software Department and resolve said problem subject to the outcome of such consultation.

---

## Bulletin #11 -- Problems During Sound Access

| | |
|---|---|
| **To:** | Developers and Third Parties |
| **From:** | Technical Support |
| **Date:** | September 9, 1991 |
| **Subject:** | Problems During Sound Access |

Sound output stops during a game.

**Problem:**

The busy flag was read in the FM sound generator YM2616 like this (address 4001h):

```
(CS,RD,WR,A1,A0) = (0,0,1,0,1)
```

However, in the case of the YM2612, it's output is not regulated according to the conditions set up above. This results in the device being read as "not busy," and as a consequence, ends up outputting sound.

**Fix:**

When the FM sound generator's busy flag is read, do not access anything else other than:

```
(A1,A0) = (0,0)       (address 4000h)
```

---

## Bulletin #12 -- Problems With Repeated Resets

| | |
|---|---|
| **To:** | Developers and Third Parties |
| **From:** | Technical Support |
| **Date:** | September 9, 1991 |
| **Subject:** | Problems With Repeated Resets |

The software seems to go out of control when resets are repeated.

**Problem:**

When the reset occurs, the CPU is reset; however, the VDP is not. When the reset occurs during a DMA, the VDP continues the DMA. The VDP is accessed right after the reset. If this is done while the VDP is executing a DMA, then this access is ineffective.

**Fix:**

Before accessing the VDP after the initialization program (ICD_BLK4), check the DMA BUSY status register. If a DMA is being executed, do not attempt to access the VDP.

If the problem persists, ensure that you are not executing a DMA right after a reset.

---

## Bulletin #13 -- Corrections to the Genesis Software Manual

| | |
|---|---|
| **To:** | Developers and Third Parties |
| **From:** | Technical Support |
| **Date:** | September 9, 1991 |
| **Subject:** | Corrections to the Genesis Software Manual |

When discussing VRAM, CRAM, and VSRAM access, the manual states in Pages 22-27 that byte access is possible. **This is incorrect. Access is limited to word or long word.**

On Page 77, it implies that the 68000 may set the bank switches. **The bank switches MUST be set by the Z80.**

These changes affect Version 1.0 of the manual, later versions will reflect this correction.

---

## Bulletin #14 -- ROM Splitting

| | |
|---|---|
| **To:** | Developers and Third Parties |
| **From:** | Technical Support |
| **Date:** | September 5, 1991 |
| **Subject:** | ROM Splitting |

As we all know, Genesis products must be split into 128k odd and even pieces. Sega expects the ROM images to be in the following format:

| Even | Odd |
|---|---|
| 0:Even | 1:Odd |
| 2:Even | 3:Odd |
| ... | ... |

For larger products, continue the above pattern. We would appreciate it if all products would conform to this method of splitting. Please request the utility to split ROMs, M2B, or Split4, if your current tool can't output files in this manner.

---

## Bulletin #15 -- Genesis Technical Information (VRAM Read Wait / Super Target IC 19)

| | |
|---|---|
| **To:** | Sega Developers |
| **From:** | Dave Marshall, Technical Support |
| **Date:** | April 5, 1993 |
| **Re:** | Genesis Technical Information |

The attached document contains information on waiting during VRAM reading. The Super Target information applies to a CD development system.

### WAIT During Mega Drive VRAM READ

In the Mega Drive, during VRAM READ, when the following conditions are not met, data may not be read correctly.

**During display period and H-blank:**

```
VRAM Address Set
    |
    v
VRAM READ
    |
    WAIT exceeding 116 CPU clock cycles
    |
    v
Next VRAM Address Set
```

**During V-blank:**

```
VRAM Address Set
    |
    v
VRAM READ
    |
    Wait exceeding 12 CPU clock cycles
    |
    v
Next VRAM Address Set
```

As seen above, after the last VRAM READ is completed, WAIT is required before the next VRAM address is set. With respect to VRAM READ, it can be read continuously.

### SUPER TARGET IC 19

When 68000 CPU accesses an illegal area, "DATA ACKNOWLEDGE" signal may not be sent back -- causing "hang up" in the production unit. Depending on some ROM emulators or ICE (+SUPER TARGET), even the emulator may hang up. To avoid such hang ups, measures have been taken so that SUPER TARGET would return ACKNOWLEDGE signal to the CPU without system hang ups. This is done via IC 19.

As a result, due to this IC function, for SUPER TARGET to function normally, the hang up occurs in the production unit.

Please take the following steps to correct the problem:

1. Before checking the software through SUPER TARGET + CPU, remove IC 19 from the socket.
2. When using ICE (ROM emulator), IC19 may be removed. Reinstall the IC should ICE (ROM emulator) act abnormally.
3. The above measures are common with the MEGA DRIVE and the MEGA CD.

*Translated by Jay Tabrizi, April 5, 1993*

---

## Bulletin #16 -- Genesis Technical Information (New Peripherals)

| | |
|---|---|
| **To:** | Sega Developers |
| **From:** | Dave Marshall, Technical Support |
| **Date:** | April 5, 1993 |
| **Re:** | Genesis Technical Information |

The attached document contains information on new peripherals and their protocol. The source files that this note references are available on the BBS in the Genesis conference. The files apply mainly to the 4P adapter. There is already driver code available for all other peripherals in the Genesis conference. This driver code is in a file called `UNIVERS.ZIP`.

### MEGA DRIVE (January 7, 1993)

#### 1. Regarding Mega Drive Register #11 IE2 Bit

This bit is set to allow or inhibit the external interrupt. Set this bit to "0" when not using external interrupt (GUN, etc.). When this bit is "1," error occurs on the Sega-made address checker.

#### 2. Regarding Mega Drive Control Pad Access

When accessing control pad, please strictly observe the following items: (If not observed, the peripherals to be sold in the future may not operate properly.)

1. **Access Pad from within V-INT (routine).** Generally, pad should be accessed from within V-INT. The access period is approximately 16 ms for NTSC and 20 ms for PAL. The access interval should not exceed the above periods.

2. **Pad access through V-INT routine must be limited to one time only.** Reading pad data repeatedly via V-INT could cause malfunction.

3. **Check the peripherals.** Currently, the sale of 6-button pad, micro trackball, 4P adapter (all tentative names) is being planned. Therefore, even for Pad-exclusive software, peripherals other than the Pad may be used or those devices may be switched. So please diligently check peripheral devices currently used and make sure to input data that meet those devices. We will supply a sample program that checks the device ID at each V_INT and then executes controller input. Please use this program as your reference.

4. **Modify sample program only after understanding it completely.** Our sample program has been modified incorrectly into some software product that is for sale and suffer from erratic operation. Please modify the sample program after full understanding of its structure and operation.

*Translated by J. Tabrizi, April 5, 1993*

### How to Accommodate Peripherals

The 6-button pad, Mouse, and 4P TAP will soon go on sale. Whether or not each game will accommodate such peripherals, they must be made switchable once the game is in progress. 4P TAP has the selector function, therefore, it is very possible to be switched in mid-game. To this end, a sample program has been made to check the device ID at each V-INT and then execute the controller input. The file is `<IO.ASM>`. We also prepared a set of I/O check program.

#### Accommodating 4P TAP

**I/O data:**

| Offset | Size | Description | Label in MEM_MAP.ASS |
|---|---|---|---|
| +0 | 1 byte | Connector-1 device ID | port_id1 |
| +1 | 1 byte | Connector-2 device ID | port_id2 |
| +2 | 4 bytes | 4P tap connector info for Connector-1 | mlt_info1 |
| +6 | 4 bytes | 4P tap connector info for Connector-2 | mlt_info2 |

10 bytes of data must be secured for controller data WORK. An amount equal to 8 units is secured. Whether or not Connector-1 is 4P_TAP, Connector-2 data is stored in `iodata_5`.

| Offset | Description | Label |
|---|---|---|
| +10 | 1P data or 4P_TAP CN1 data | iodata_1 |
| +20 | CN2 data at 4P_TAP | iodata_2 |
| +30 | CN3 data at 4P_TAP | iodata_3 |
| +40 | CN4 data at 4P_TAP | iodata_4 |
| +50 | 2P data or 4P_TAP CN1 data | iodata_5 |
| +60 | CN2 data at 4P_TAP | iodata_6 |
| +70 | CN3 data at 4P_TAP | iodata_7 |
| +80 | CN4 data at 4P_TAP | iodata_8 |

iodata_x data varies by controller.

**Note:** ST=start button, A=A button, B=B button, C=C button, X=X button, Y=Y button, Z=Z button, MD=Mode button, [...] describes each bit.

#### 3-Button JOYPAD

| Offset | bit7 | bit6 | bit5 | bit4 | bit3 | bit2 | bit1 | bit0 |
|---|---|---|---|---|---|---|---|---|
| +0 | 0 | ... | JOYPAD 3-button Controller ID | | | | | |
| +2 | [ST | A | C | B | Right | Left | Down | Up] |
| +3 | +2 leading edge data | | | | | | | |
| +4 | Not used | | | | | | | |

#### 6-Button JOYPAD

| Offset | Description |
|---|---|
| +0 | 1...JOYPAD 3-button Controller ID |
| +2 | [ST, A, C, B, Right, Left, Down, Up] |
| +3 | +2 leading edge data |
| +4 | [0, 0, 0, 0, MD, X, Y, Z] |
| +5 | +4 leading edge data |
| +6 | Not used |

#### Mouse

| Offset | Description |
|---|---|
| +0 | 2...Mouse Controller ID |
| +2 | [Center, Middle, Right, Left, Yover, Xover, Ysign, Zsign] |
| +3 | +2 leading edge data |
| +4 | X data |
| +5 | Y data |
| +6 | X data sign |
| +8 | Y data sign |

#### Sample Program File Composition

| File | Description |
|---|---|
| IO_READ.ME | Readme file |
| MEM_MAP.ASS | Memory map assign |
| MACRO.MAC | Macro |
| MAIN.ASM | Processing from Vector, ID, power supply ON |
| ICD_BLK4.PRG | Included in Hard Initial Program `<MAIN.ASM>` |
| INT.ASM | Interrupt program |
| IO.ASM | This file is the center of I/O program |
| SUB.ASM | Subroutine |
| VDP.PRG | Subroutine for VDP related items |
| SPCNT.ASM | Sprite control |
| IO_CHK.ASM | Checking and displaying I/O data. Not to be minded |
| EQU_EV.ASM | For reflecting mem_map.ass into EVT file |
| ASCII.ASM | ASCII CG data |
| IOSAMP.MK | Make definition file |
| IOSAMP.LNK | Link definition file |
| I.CMD | ICE initial batch |
| MK.BAT | Batch file for MAKE |
| XREF.1 | File for Xref inclusion |

#### 3-Button Accommodation Reference

For those who say "ID does the check, but only JOYPAD can do the control."

Essential WORK is 1 Byte only (2 Bytes when making edge data).

For program see `<IO_JOY3.PRG>`. Make sure to call only once from V_INT routine. Used in both cases of making edge and otherwise.

```
MAKE_EDGE   set   1      ;if 1 then make edge, 0...only read
; If so: Making edge
MAKE_EDGE   set   0      ;if 1 then make edge, 0...only read
; If so: Not making edge
```

To distinguish between 3-button and 6-button: Please see `get_joy` routine within `<IO.ASM>`.

*Translated by J. Tabrizi, April 5, 1993*

---

## Bulletin #17 -- Genesis Technical Information (EPROMs)

| | |
|---|---|
| **To:** | Sega Developers |
| **From:** | Bert Mauricio, Technical Support |
| **Date:** | May 25, 1993 |
| **Re:** | Genesis Technical Information |

The attached document contains information on EPROMs for use in Sega development boards.

Listed are manufacturers and model numbers of EPROM chips that are recommended to use with the Genesis/Game Gear boards. Please note chips are non-JEDEC.

### Recommended EPROM Chips

| Capacity | Manufacturer | Model | Speed |
|---|---|---|---|
| 1 megabit | NEC | D27C1000A | 120ns or 150ns |
| 1 megabit | AMD | AM27C100 | 150ns |
| 1 megabit | Fujitsu | MBM27C1000 | 150ns |
| 1 megabit | Intel | D27C100 | 150ns |
| 2 megabit | NEC | D27C2001D | 150ns |
| 2 megabit | AMD | AM27C020 | 200ns |
| 4 megabit | NEC | D27C4001D | 150ns |
| 4 megabit | Toshiba | TC574000D | 150ns |

> **Note:** We have found the Intel 27C020 2 megabit chips to be unreliable.

There has also been problems when using 2 megabit chips on the standard 8M/16M EPROM board w/64k backup (171-5663 M5 Test MB).

**Dip switch settings:**

| Chip Type | SW1 | SW2 | SW3 | SW4 |
|---|---|---|---|---|
| 1 megabit chips | on | on | on | off |
| 2 megabit chips | on | on | off | on |

If there are recurring problems, it may be more reliable to use 2 megabit chips on the new SRAM/EE backup board which accepts 1, 2, and 4 megabit chips (GN 837-8093).

**EPROM source:** America II Electronics (Florida) -- (800) 767-2637

---

## Bulletin #18 -- Lockout Code Reminder

| | |
|---|---|
| **To:** | Sega Developers |
| **From:** | Dave Marshall, Technical Support |
| **Date:** | May 28, 1993 |
| **Re:** | Genesis Technical Information |

This is just a reminder that all Genesis carts must contain "lockout code". This code will prevent cartridges from being run on machines not listed in the Country Code field of the ID Block.

This lockout code is available on the Sega Technical Support BBS in a file called `LOCK.ZIP` in the Genesis and 3rdParty conferences. The zip file contains information on how and where to use the lockout code.

The test department does look for this feature and will bug any game that does not contain the lockout capability.

---

## Bulletin #19 -- Mega CD Technical Information (Non-US Market)

| | |
|---|---|
| **To:** | Sega Developers |
| **From:** | Dave Marshall, Technical Support |
| **Date:** | July 6, 1993 |
| **Re:** | Mega CD Technical Information |

This document contains requirements that must be followed when producing games for the non-U.S. market.

1. All software available in Japan should not contain a "TM" or "R" with the Sega Logo. All software available for the U.S. and European markets must have a "TM" on the right side of the Sega Logo.

2. Any SEGA games made available for the European market must be PAL compatible. The PAL version must be of the same graphic and sound quality as the NTSC version.

3. Any SEGA games made available in Japan must be compatible with both NTSC and PAL game systems.

---

## Bulletin #20 -- Genesis Technical Information (Games Over 16 Mbits)

| | |
|---|---|
| **To:** | Sega Developers |
| **From:** | Dave Marshall, Technical Support |
| **Date:** | July 8, 1993 |
| **Re:** | Genesis Technical Information |

The following tech note contains information for developing Genesis games that are larger than 16 Mbits.

### Mega Drive Technical Information

#### 1. Regarding the VDP Access

In cases that the transmission to VRAM within the main routine is interrupted while in progress and the VDP is being accessed during the interruption, the writing to VRAM that was taking place in the main routine cannot function properly, thereby becoming the cause of a bug. Accordingly, when accessing towards VDP in the main routine, it is necessary to deal with it by using either 1 or 2.

1. Allow the main routine and the interrupt routine to run at the same time.
2. Prohibit interrupt while transmitting in the main routine.

**Regarding 1:** When transmitting to VDP in the main routine, establish "a flag that says it is transmitting" and that flag must be confirmed in the interrupt routine. Access VDP only when VDP is not being accessed in the main.

**Regarding 2:** When transmitting to VDP in the main routine, prohibit interrupt before performing the address set for the transmission, and permit interrupt after the data transmission has ended.

#### 2. Regarding the Operation CHECK While Using EP-ROM

The enlarging of game capacity is anticipated hereafter as a trend, but in order to be certain that the accompanying EP-ROM operation is stabilized, be cautious of the following items.

1. Decrease the number of ROM that loads onto the ROM baseboard as much as possible by using large capacity devices. Because the electric power consumption of ROM increases when the number of loads on the ROM increases, it is burdened and can be the cause of an operation malfunction. The maximum number of possible loads varies according to the ROM, base board, and device being used, and cannot be specified but if kept about 4 will remain stabilized.

2. Because the electric power consumption is great, EP-ROM's whose maximum use should be avoided are:
   - AMD Company made products
   - INTEL Company made products

Specifically, the new product "Mega Drive 2" has a severe design on the electric power consumption. In the case that the worst operation malfunction occurs, check to see if 1 or 2 is relevant and can be applied. Furthermore, do all that can be done in the normal operation times to establish the operation circumstances referred to in the previous section.

#### 3. Regarding the Production of Games over 16 Mbits

By using the present cartridge software corresponding to MEGA DRIVE, the capacity where present development is possible is as follows:

- **16Mbit + 256Kbit (max):** `000000H`-`1FFFFFH` (ROM) + `200000H`-`20FFFFH` (BUP)

The methods corresponding to capacities larger than this are written on the last page. Development is in progress (release date pending).

If there is no backup, it is possible to develop up to the following capacity without using bank switch:

- **Up to 32Mbit:** `000000H`-`3FFFFFH` (ROM)

The S-RAM board is presently under development (release scheduled for summer of '93).

### Regarding MEGA DRIVE Bank Switching

Divide all 68000 (ROM) space, every 4 Mbit (Bank 0 - bank 63; MAX 256 Mbit).

Divide the MD cartridge also into 8 areas of 4 Mbit and fix only area 0 that has vectors and it is possible to assign option banks to the remaining 7 areas.

The bank should be designated by the bank establishing register (odd number place of MD's `$A130F1`-`$A130FF`).

Register 0's 0th bit switches ROM/RAM after the `$200000th` place, and the number 1 bit designates the RAM light protect.

Register 1 thru register 7 corresponds to area 1 thru area 7.

The initial that depends on the hardware at the time of reset turns the light protect OFF (write in possible), as the cartridge area becomes 32 Mbit ROM space.

#### Bank Setting Register Layout

**MD Cartridge Area:**

| Address Range | Area |
|---|---|
| `$000000`-`$07FFFF` | Area 0 (Fixed) |
| `$080000`-`$0FFFFF` | Area 1 |
| `$100000`-`$17FFFF` | Area 2 |
| `$180000`-`$1FFFFF` | Area 3 |
| `$200000`-`$27FFFF` | Area 4 |
| `$280000`-`$2FFFFF` | Area 5 |
| `$300000`-`$37FFFF` | Area 6 (ROM or RAM) |
| `$380000`-`$3FFFFF` | Area 7 |

**Bank Setting Registers:**

| Register | Address | Bits D7-D0 |
|---|---|---|
| REG. 0 | `$A130F1` | `0, 0, 0, 0, 0, 0, ?:W, ?:ROM` |
| REG. 1 | `$A130F3` | `0, 0, BN5, BN4, BN3, BN2, BN1, BN0` |
| REG. 2 | `$A130F5` | `0, 0, BN5, BN4, BN3, BN2, BN1, BN0` |
| REG. 3 | `$A130F7` | `0, 0, BN5, BN4, BN3, BN2, BN1, BN0` |
| REG. 4 | `$A130F9` | `0, 0, BN5, BN4, BN3, BN2, BN1, BN0` |
| REG. 5 | `$A130FB` | `0, 0, BN5, BN4, BN3, BN2, BN1, BN0` |
| REG. 6 | `$A130FD` | `0, 0, BN5, BN4, BN3, BN2, BN1, BN0` |
| REG. 7 | `$A130FF` | `0, 0, BN5, BN4, BN3, BN2, BN1, BN0` |

- BN0-BN5: Bank Number
- REG.0 D1 = 0: WRITE, D1 = 1: PROTECT
- REG.0 D0 = ROM/RAM select

*Translated by DDP, June 28, 1993*

---

## Mega Drive Technical Info #9 -- Cartridge Data (ID) Specification Changes

**Doc. # MD-TECH-09-100694**
**(c) 1994 SEGA. All Rights Reserved.**

### 1. Cartridge Data (ID) Specification Changes

Please note that the specifications below apply also to the 32X.

**The following changes have been made in the code entered in 1F0h.**

- **Old Specifications:** Entered data of corresponding countries.
- **New Specifications:** 1 byte of operation hardware code entered in 1F0h in ASCII code. 1FFh from 1F1h is buried in the space code (20h).

**Description:**

When making distinctions between application hardware information (`$A10001`) and thereby creating operation restrictions, the operation hardware code shows which hardware is being programmed to enable operation. This code is used as confirmation information when Sega checks the compatibility of the hardware and application.

#### Operation Hardware Code Table

| $A10001 | Bit 7 | Bit 6 | Hard Specs | Main Sales Region | Operation Hardware Code (0-F) |
|---|---|---|---|---|---|
| 0 | 0 | Japan, NTSC | Japan, S. Korea, Taiwan | See table below |
| 0 | 1 | Japan, PAL | | See table below |
| 1 | 0 | Overseas, NTSC | N. America, Brazil | See table below |
| 1 | 1 | Overseas, PAL | Europe, Hong Kong | See table below |

**Codes:**

| Code | Japan NTSC | Japan PAL | Overseas NTSC | Overseas PAL |
|---|---|---|---|---|
| 0 | x | x | x | x |
| 1 | O | x | x | x |
| 2 | x | x | x | x |
| 3 | O | O | x | x |
| 4 | x | x | O | x |
| 5 | O | x | O | x |
| 6 | x | x | x | x |
| 7 | O | O | x | x |
| 8 | x | x | x | x |
| 9 | O | x | x | x |
| A | x | x | x | x |
| B | x | x | x | x |
| C | x | x | O | O |
| D | O | x | O | O |
| E | x | x | O | O |
| F | O | O | O | O |

O: Operates, x: Does not operate

**Example 1)** When no application operation restriction are in force (common ROM), "F" which has all "O"s is entered.

**Example 2)** For applications operating only in Genesis which is sold in the U.S. `$A10001` is operated at: Bit 7 = 1 and Bit 6 = 0. Operation hardware code becomes "4" according to the table above when not being operated by other hardware.

Address layout at 1F0:

```
Address     1F0  1  2  3  4  5  6  7  8  9  A  B  C  D  E  F
Op. Code     4   (spaces)
ASCII Code  34  20 20 20 20 20 20 20 20 20 20 20 20 20 20 20
```

> **NOTE:** Please be aware that if there is an error in the code above, the application cannot perform master release.

---

## Mega Drive/32X Address Checker Specification

**Doc. # MAR-57-102894**
**(c) 1994 SEGA. All Rights Reserved.**
**(Not used with MEGA CD)**

### Caution

- **Objectives of the address checker:** Because the game malfunctions and does not operate if the MD function is expanded in the future, this prevents access to prohibited areas of the game program and illegal use of various registers. As a result, the address checker does not check for bugs in the program.

- Errors may not be detected by the address checker even when there is a bug in the program or if something not allowed by the manual is performed.

- The address checker can check only the part of the executed program.

### 1.0 Specifications

1. The Address Checker checks access to prohibited access areas by the 68000 CPU accompanying software development used with the Mega Drive (MD) and the 32X (S32X), and errors for data written to various registers.

2. The address, data, and program counter can be switched and displayed when an error occurs in combination with the R/W, UDS, and LDS conditions. (During a display, HALT is applied to the CPU.)

3. The Address Checker corresponds to the following specifications. Note that newer restrictions were also produced.

**Corresponding Specifications:**
- ROM 16 Mbits or less + Backup RAM
- ROM 16 Mbits or greater (bank switch used) + Backup RAM + S32X correspondent

**Precautions:**

Please note that the following items are not detected as errors:
- (a) When writing to the ROM area.
- (b) When accessing an address that is greater than the Backup RAM capacity of the mass production board.
- (c) When an even numbered address is accessed while accessing the Backup RAM.

### 2.0 Function and Uses of Each Part

#### 2.1 Part Names

- **DIP SW** -- Address Checker for Operation Mode Setting
- **SW 1** -- For Data Display
- **SW 2** -- For Program Counter Display
- **Display** -- Address, data, display of program counter
- **Power Switch** -- Switches both internal and external power (Left: AC adapter, Right: CPU)
- **EPM5128** -- Programmable logic
- **CPU 68000** -- Processor socket

> \* Halt is canceled if SW 1 and SW 2 are simultaneously pressed.

#### 2.2 DIP SW Initial Settings and Functions

| Switch | ON | OFF |
|---|---|---|
| No. 1 | When not operating as address checker (normal operation even if CPU socket is not replaced) | Operates as an address checker |
| No. 2 | Checks address when in the MD mode | Cannot be set |
| No. 3 | Not used | |
| No. 4 | Not used | |

#### 2.3 Usage Method

1. The address checker is attached to the CPU socket of the MD.
2. Set and execute the software. (Confirm that the power lamp is on.)
3. After running all routines of a program and HALT is not turned on, the program is judged as not performing various prohibited items.
4. When HALT is on, look at the display and LED and decide the condition of the program.
5. By pressing switches 1 and 2 at the same time, the program restarts from the address following the spot where the error occurred.

> To display the address, data, and program counter by applying HALT to the CPU without relevancy to errors, start the address checker after turning DIP SW 1 to ON and press the SW 2 to an arbitrary location. Also, when cancelling HALT at this time, press SW 1 and SW 2 at the same time; when releasing, press SW2 first.

#### 2.4 How to View the Display and LED While in Use

1. If the power to the address checker and the MD are turned on, all lamps light up along with the display and LED during the CPU reset interval. Except for power lamp, all lamps turn off when reset ends.

2. If an error occurs, the error address is first displayed on the display screen (6 digits). Error data is displayed only while the SW 1 is pressed (Lower 4 digit). The value of the program counter in which an error occurred is displayed only while SW 2 is pressed (6 digit).

3. LED display (these are lamps that display CPU I/O conditions when an error occurs):
   - **R/W** -- ON: status has been Write; OFF: status has been Read
   - **LDS** -- ON: Shows the I/O status of low byte data; OFF: No input and output of data low bytes
   - **UDS** -- ON: Shows the status of low byte data; OFF: No input and output of data high bytes

> \* Both LDS and UDS are on during word access.
> \* For the 68000, because the next operating value is already entered in the executing program counter register, the error is suspected to have been caused before the PC value is actually displayed.
> \* Because the address checker only checks the mapping check and the value that is set in the register, it does not include any function that discovers bugs hidden in the program.

### 3.0 Checking Items with Address Checker

#### 3.1 Memory Mapping

**(1) MD+S32X Mode (68000 side):**

| Address Range | Region | Access | Size |
|---|---|---|---|
| `$000000`-`$000FFF` | Vector ROM | Read Only | Byte/Word |
| `$001000`-`$83FFFF` | SEGA Reserved | | |
| `$840000`-`$85FFFF` | DRAM | R/W | Byte/Word |
| `$860000`-`$87FFFF` | Over Write Image | R/W | Byte/Word |
| `$880000`-`$8FFFFF` | ROM Image (Fix) | Read Only | Byte/Word |
| `$900000`-`$9FFFFF` | ROM Image (Bank) | R/W | Byte/Word |
| `$A00000`-`$A0FFFF` | Z80 | | |
| `$A10000`-`$A10FFF` | I/O | | |
| `$A11000`-`$A11FFF` | Control | | |
| `$A12000`-`$A13FFF` | SEGA Reserved | | |
| `$A14000`-`$A1400F` | Security | Write Only | -/Word |
| `$A14010`-`$A150FF` | SEGA Reserved | | |
| `$A15100`-`$A1517F` | S32X Sys Reg. | | |
| `$A15180`-`$A151FF` | S32X VDP Reg. | | |
| `$A15200`-`$A153FF` | S32X Palette | R/W | -/Word |
| `$A15400`-`$BFFFFF` | SEGA Reserved | | |
| `$C00000`-`$C00011` | VDP Reg. | | |
| `$C00012`-`$FEFFFF` | SEGA Reserved | | |
| `$FF0000`-`$FFFFFF` | WORK RAM | R/W | -/Word |

**(2) Address Checker Memory Mapping (Bank Switch mode):**

| Address Range | Region | Access | Size |
|---|---|---|---|
| `$000000`-`$3FFFFF` | ROM | R/W | Byte/Word |
| `$400000`-`$9FFFFF` | SEGA Reserved | | |
| `$A00000`-`$A0FFFF` | Z80 | | |
| `$A10000`-`$A10FFF` | I/O | | |
| `$A11000`-`$A11FFF` | ControlS | | |
| `$A12000`-`$A130EB` | SEGA Reserved | | |
| `$A130EC`-`$A130EF` | S32X ID | Read Only | Byte/Word |
| `$A130F0`-`$A12FFF` | Bank | R/W | Byte/- |
| `$A13000`-`$A13FFF` | SEGA Reserved | | |
| `$A14000`-`$A1400F` | Security | Write Only | -/Word |
| `$A14010`-`$A150FF` | SEGA Reserved | | |
| `$A15100`-`$A1517F` | S32X Sys Reg. | | |
| `$A15180`-`$A151FF` | SEGA Reserved | | |
| `$C00000`-`$C00011` | VDP Reg. | | |
| `$C00012`-`$FEFFFF` | SEGA Reserved | | |
| `$FF0000`-`$FFFFFF` | WORK RAM | R/W | Byte/Word |

#### 3.2 Register Mapping

**(1) S32X System Register (68000 side):**

| Address | Register | Access | Size |
|---|---|---|---|
| `$A15100` | Adapter Control | R/W | Byte/Word |
| `$A15102` | Interrupt Control | R/W | Byte/Word |
| `$A15104` | Bank | R/W | Byte/Word |
| `$A15106` | Dreq Control | R/W | Byte/Word |
| `$A15108` | 68 to SH Source | R/W | -/Word |
| `$A1510C` | 68 to SH Destination | R/W | -/Word |
| `$A15110` | 68 to SH Length | R/W | -/Word |
| `$A15112` | FIFO | Write Only | -/Word |
| `$A15114`-`$A15119` | SEGA Reserved | | |
| `$A1511A`-`$A1511B` | SEGA Channel | R/W | Byte/Word |
| `$A1511C`-`$A1511F` | SEGA Reserved | | |
| `$A15120`-`$A1512F` | Communication Port | R/W | Byte/Word |
| `$A15130` | PWM Control | R/W | Byte/Word |
| `$A15132` | Cycle | R/W | -/Word |
| `$A15134` | L ch Pulse | R/W | -/Word |
| `$A15136` | R ch Pulse | R/W | -/Word |
| `$A15138` | MONO Pulse | R/W | -/Word |
| `$A1513A`-`$A1517F` | SEGA Reserved | | |

**(2) S32X VDP Register (68000 side):**

| Address | Register | Access | Size |
|---|---|---|---|
| `$A15180` | Bit Map Mode | R/W | Byte/Word |
| `$A15182` | Screen Shift Control | R/W | Byte/Word |
| `$A15184` | Auto Fill Length | R/W | Byte/Word |
| `$A15186` | Auto Fill Address | R/W | -/Word |
| `$A15188` | Auto Fill Data | R/W | -/Word |
| `$A1518A` | Frame Buffer Control | R/W | -/Word |
| `$A1518C`-`$A151FF` | SEGA Reserved | | |

#### 3.3 All Register Set Values

When data other than values that can be set for all registers is written, HALT is applied to the main CPU together with the display of an error. See the Register Set Value Table of section 5.0 "Supplement" for the values set in the VDP register and the main CPU register.

### 4.0 Analysis Examples When Using ICE

> **Caution!** When analyzing with the ICE, a HALT could apply when an error occurs and the address checker operates. To view the history, make sure to stop the program and press SW1 and SW2 at the same time, then release HALT.

#### 4.1 Analysis Example (1) -- Register Set Error

1. Access Address: C00004
2. Data (when SW 1 is pressed): 8008
3. PC (when SW 2 is pressed): 0601A8
4. ON Lamps: UDS, LDS, R/W

**Cause:** Writing use-prohibited register data. 8008H is written to address $C00004 at the locations of points 1 and 2. 8008H data is not permitted in the MD Register Set Table. Therefore, errors occur in the address checker.

#### 4.2 Analysis Example (2) -- Address Set Error

1. Access Address: C00004
2. Address Set Data (before pressing SW 2): 4010
3. PC (when SW 2 is pressed): 0614A8
4. ON Lamps: UDS, LDS, R/W, 2ND

**Cause:** Writing use-prohibited register data. $4010 is written to address $C00004 at the locations of points 1 and 2. $4010 data is prohibited in the MD address set table. Therefore, an error occurs in the address checker.

### 5.0 Supplement

> **Caution!** Sections 5.1 and 5.2 are the same set value table during the MD and S32X modes.

#### 5.1 Table of VDP Register Set Values

All VDP registers are accessed at address `$C00004`.

**VDP REGISTER #0:** IE0, M4, M3 bits configurable.

**VDP REGISTER #1:** BLNK, IE0, M1, M2, M5 bits configurable.

**VDP REGISTER #2:** SA15, SA14, SA13 bits configurable (scroll A name table).

**VDP REGISTER #3:** WD15-WD11 bits configurable (window name table).

**VDP REGISTER #4:** WD15-WD13 bits configurable (scroll B name table).

**VDP REGISTER #5:** AT15-AT9 bits configurable (sprite attribute table).

**VDP REGISTER #6:** Fixed value.

**VDP REGISTER #7:** OPT1, OPT0, COL3-COL0 bits configurable (backdrop color).

**VDP REGISTER #8:** Fixed value.

**VDP REGISTER #9:** Fixed value.

**VDP REGISTER #10:** HT7-HT0 bits configurable (H interrupt timing).

**VDP REGISTER #11:** IE2, VPSC, HPSC, LSCR bits configurable (mode set #3).

**VDP REGISTER #12:** PCH2, S/TE, LSM1, LSM0, RS40 bits configurable. Note: Bit pattern must be PCH2 = RS40.

**VDP REGISTER #13:** HS15-HS10 bits configurable (H scroll data table).

**VDP REGISTER #14:** Fixed value.

**VDP REGISTER #15:** INC7-INC0 bits configurable (auto increment).

**VDP REGISTER #16:** VSZ1, VSZ0, HSZ1, HSZ0 bits configurable (scroll size).

**VDP REGISTER #17:** RGT, WHP4-WHP0 bits configurable (window H position).

**VDP REGISTER #18:** DOWN, WVP4-WVP0 bits configurable (window V position).

**VDP REGISTER #19:** LG7-LG0 bits configurable (DMA length low).

**VDP REGISTER #20:** LG15-LG8 bits configurable (DMA length high, OLG14).

**VDP REGISTER #21:** SA8-SA1 bits configurable (DMA source low).

**VDP REGISTER #22:** SA16-SA9 bits configurable (DMA source high).

**VDP REGISTER #23 -- DMA ROM to VRAM:** DMD1, DMD0, BA22-BA17 bits configurable. HEXA = 9, 7, values 0 or 1, 0toF.

**VDP REGISTER #23 -- DMA WORK-RAM to VRAM:** DMD0 = 1, BA22-BA17 all 1. HEXA = 9, 7, 7, F.

**VDP REGISTER #23 -- DMA FILL VRAM/VRAM COPY:** DMD0 = 1, DMD1 = variable. HEXA = 9, 7, 8 or C, 0toF.

#### 5.2 VDP Address Set Value Table

**CRAM READ ($C00004):**
- Upper Word: `00`, `0X` (0to7), `XX` (0toF)
- Lower Word: `00`, `02`, `00`

**CRAM WRITE ($C00004):**
- Upper Word: `C0`, `0X` (0to7), `XX` (0toF)
- Lower Word: `00`, `00`, `00`

**CRAM DMA ADDRESS SET ($C00004):**
- Upper Word: `C0`, `0X` (0to7), `XX` (0toF)
- Lower Word: `00`, `08`, `00`

**VRAM READ ($C00004):**
- Upper Word: `0X` (0to3), `XX` (0toF), `XX` (0toF)
- Lower Word: `00`, `00`, `XX` (0to3)

**VRAM WRITE ($C00004):**
- Upper Word: `0X` (0to3), `XX` (0toF), `XX` (0toF)
- Lower Word: `00`, `01`, `XX` (0toX)

**VRAM DMA ADDRESS SET ($C00004):**
- Upper Word: `4,5,6,7` (X), `XX` (0toF), `XX` (0toF)
- Lower Word: `00`, `08`, `XX` (0to3)

**VSRAM READ ($C00004):**
- Upper Word: `00`, `0X` (0to7), `XX` (0toF)
- Lower Word: `00`, `01`, `00`

**VSRAM WRITE ($C00004):**
- Upper Word: `40`, `0X` (0to7), `XX` (0toF)
- Lower Word: `00`, `01`, `00`

**VSRAM DMA ADDRESS SET ($C00004):**
- Upper Word: `40`, `0X` (0to7), `XX` (0toF)
- Lower Word: `00`, `09`, `00`

**VSRAM COPY ($C00004):**
- Lower Word: `0X` (0to3), `XX` (0toF), `XX` (0toF)
- Lower Word: `00`, `0C`, `XX` (0to3)

### Addendum

#### 1. P2 1-(3) Precautions Supplement of (b)

Two memory mappings exist when bank switching is used:
- (a) Without bank switching: Full `$000000`-`$3FFFFF` is ROM
- (b) With bank switching: `$000000`-`$1FFFFF` is ROM, `$200000`+ includes Backup RAM and SEGA Reserved

However, the address checker is not able to distinguish between (a) and (b). Thus, even if the area shown by the slanted lines (b) is accessed, it is not shown as an error because it is recognized equally with the ROM area in (a).

#### 2. Additional Functions

**When all dots in the lower area of the display are lit:**

There are two methods for access to the VDP control port (`$C00004`): register set (1 word access) and address set (2 word access). When all display dots are lit, it shows abnormal access by address set access.

**Types of abnormal access:**

1. **The access modes of the 1st word and 2nd word do not match.** Although an address set in the control port must be accessed by 2 word set, set of the access mode in which 1st and 2nd word are each different is performed.

   **Example:** In the case when VRAM READ is set in the 1st word and VRAM WRITE is set in the 2nd word.

2. **Only the 1st Word is set.** Among 2 word set of the address set, 2nd word set is not performed and register set is performed in control port after the 1st word is set.

> **Note:** When an address set error occurs, check is not possible in address checker units. Errors should be analyzed with the ICE history function.
