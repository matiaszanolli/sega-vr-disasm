# 32X H/W Information

**SEGA OF AMERICA, INC.**
Consumer Products Division

**Doc. #-MAR-25-R5/R6-060694**

Copyright 1994 SEGA. All Rights Reserved.

CONFIDENTIAL - PROPERTY OF SEGA

---

## 32X H/W Information (1)

### General Target Items

**April 28, 1994**

1. **SDRAM (8 burst read / single write)**
   - Read: 12 Clock / 8 word
   - Write: 2 Clock / 1 word

2. **32X Mode, cartridge access, wait count (R/W common)**
   - SH2: 6 wait (min.) ~ 15 wait (max.)
   - 68K: 0 wait (min.) ~ 5 wait (max.)

3. **68K system register access, wait count (R/W common)**
   - 0 wait

4. **68K VDP access, wait count**

   | Access Type | Wait Count |
   |-------------|------------|
   | Frame buffer (Read) | 2 wait (min.) ~ 4 wait (max.) |
   | Frame buffer (Write) | 0 wait |
   | Register (Read) | 2 wait |
   | Register (Write) | 0 wait |
   | Palette (Read) | 2 wait (min.) ~ 64 usec |
   | Palette (Write) | 3 wait (min.) ~ 64 usec |

   **Note:** The wait count is a conversion of each CPU operation clock. A wait count at 64 usec means that a wait of 1 line on the display screen is required.

5. **Frame Buffer Layout**

   When 320 dots of pixel data cannot be reserved within the frame buffer, caution must be used because the image data is displayed. (Line table is drawn)

   ```
   $00000 +-----------------+
          |   Line Table    |
   $00200 +-----------------+  <-- Frame Buffer
          |                 |
          |   320 dot       |
   $1FFFF +-----------------+
   $20000 |                 |
          |                 |  <-- Frame Buffer Image
          |                 |
   $3FFFF +-----------------+
   ```

6. **0 byte cannot be written to the frame buffer but 1 ~ FF can. 0 word write is possible.**

---

## 32X H/W Information (2)

### Target Ver. 1.0 Items (and differences with Ver. 2.0)

**April 28, 1994**

#### 1. Target Dip Switches

**Saturn Board (171-6797)**

| Switch | Default |
|--------|---------|
| 1-1 JAP/EXT * | ON |
| 1-2 NTSC/PAL | OFF |
| 1-3 N.C. * | OFF |
| 1-4 N.C. | OFF |

| Switch | Default |
|--------|---------|
| 2-1 SH2M-MD0 | OFF |
| 2-2 SH2M-MD1 | ON |
| 2-3 SH2M-MD2 * | OFF |
| 2-4 SH2M-MD3 * | OFF |
| 2-5 SH2M-MD4 * | ON |
| 2-6 SH2M-MD5 | ON |
| 2-7 N.C. | OFF |
| 2-8 N.C. | OFF |

| Switch | Default |
|--------|---------|
| 3-1 SH2S-MD0 | OFF |
| 3-2 SH2S-MD1 | ON |
| 3-3 SH2S-MD2 * | OFF |
| 3-4 SH2S-MD3 * | OFF |
| 3-5 SH2S-MD4 * | ON |
| 3-6 SH2S-MD5 | OFF |
| 3-7 N.C. | OFF |
| 3-8 N.C. | OFF |

\* Change not allowed

**VDP I/F Board (171-6815)**

| Switch | Default |
|--------|---------|
| 1-1 ROM15 * | ON |
| 1-2 ROM14 * | ON |
| 1-3 ROM13 * | ON |
| 1-4 G/A | ON |
| 1-5 N.C. | OFF |
| 1-6 N.C. | OFF |
| 1-7 N.C. | OFF |
| 1-8 N.C. | OFF |

**VDP Board (171-6816) - NTSC (default)/PAL**

| Switch | Default |
|--------|---------|
| JP1 | ON |
| JP2 * | ON |
| JP3 | ON |

**Clock Board (171-6828) - CPU (default)/PAL**

| Switch | Default |
|--------|---------|
| JP1 | OFF |
| JP2 | ON |
| JP3 | OFF |
| JP4 | OFF |
| JP5 | ON |

- When EVA board master is used, set main board DSW2-1 to ON and DSW2-2 to OFF.
- When EVA board slave is used, set main board DSW3-1 to ON and DSW3-2 to OFF.

(May 16, 1994 addition)

**Board Connection Diagram:**

```
Main Board (171-6797)          VDP I/F Board (171-6815)
+---------------+              +---------------+        Clock Board (171-6828)
|               |<----SW1----->|               |        JP SW
|   68K side    |              |               |<------>+---------+
|               |              |               |
|               |              |               |        VDP Board (171-6816)
|   SH2 side   |<--SW2------->|               |        JP SW
|               |<--SW3------->|   SW1         |<------>+---------+
| [    ] [    ] |              |      [      ] |
+---------------+              +---------------+
```

#### 2. 32X I/F Implementation Time

**SH-2 Access Destination**

| Destination | Target Ver. 1.0 | Target Ver. 2.0 |
|-------------|-----------------|-----------------|
| Boot ROM (RO) | 3 Clock | 3 Clock |
| System Register (R/W) | 3 Clock | 3 Clock |
| VDP Register (R/W) | 8 Clock (min.) | 7 Clock (min.) |
| Palette (R/W) | 8 Clock (min.) | 7 Clock (min.) |
| Frame Buffer (Read) | 9 Clock (min.) | 7 Clock (min.) |
| Frame Buffer (1st Write) | 3 Clock (min.) | 3 Clock (min.) |
| Frame Buffer (2nd Write) | 3 Clock (min.) | 3 Clock (min.) |
| Frame Buffer (3rd Write) | 3 Clock (min.) | 3 Clock (min.) |
| Frame Buffer (4th Write) | 7 Clock (min.) | 3 Clock (min.) |
| Frame Buffer (5th Write) | 7 Clock (min.) | 5 Clock (min.) |
| Frame Buffer (6th Write) | 7 Clock (min.) | 5 Clock (min.) |
| **Frame Buffer (nth Write)** | **7 Clock (min.)** | **5 Clock (min.)** |

**68000 Access Destination**

| Destination | Target Ver. 1.0 | Target Ver. 2.0 |
|-------------|-----------------|-----------------|
| System Register (R/W) | 4 Clock | 4 Clock |

**Note:** Write access to the SH-2 Frame Buffer assumes a continuous access with no Idle Cycle. When the Idle Cycle is entered between accessing, the next access time is shortened only by the number entered by the Idle Cycle (however, no shorter than a 3 Clock minimum cycle).

3. **SDRAM configuration:** The boot ROM used for Ver. 1.0 SH-2 can use SDRAM with 4 Mbits. Vers. 2.0 and after use a 4-Mbit SDRAM, but because the SH-2 setting is regarded as 2-Mbit, the setting with ICE should be changed to 4 Mbits. At volume production, 2-Mbit SDRAMs are used. While implementing a 4 Mbit setting during development, please delete the setting program.

4. **Display dot distortion with MD:**
   - Left 2/3 dot for Ver. 1.0; 1/2 dot left or right for Ver. 2.0.
   - Between 1/2 dot left to 1/2 dot right for mass production goods (undefined by MD version).

5. **Difference of brightness with MD:**
   Ver. 1.0 brightness is a slightly different; Ver. 2.0 brightness is identical. In Ver 1.x, the contour could be unstable due to color variation in the draw data border area.

6. **Ver. 1.0 cannot read the PWM register; Ver 2.0 can.**

**May 9, 1994**

7. **Ver. 1.0 cannot use the CD-ROM I/F; Ver 2.0 can.**
   Measures against Ver 1.x could be taken and released as Ver 1.x CD, but only in special cases. However, these measures are normally not applied.

8. **Region restrictions in Ver 1.x:** In Ver 1.x, anything other than "JAPAN" is not allowed. (Set DIP SW 171-6797 1-1 to ON.) CDI/F Boot ROM for the US becomes Boot ROM for Japan use. (Ver 1.x only) (May 31, 1994)

**May 24, 1994**

9. **PAL countermeasures:** The following countermeasures should be performed in response to PAL.

   **For Target Ver. 1.0:**

   (1) Dip switch changes of the main board: DIPSW1-2 is on

   (2) Crystal exchange of the main board:

   ```
   +------+--------+------+
   | IC9  | XTAL   | IC4  |   Change 53.693 MHz to 53.203 MHz
   +------+--------+------+
   ```

   (3) Crystal exchange of the I/F board:

   ```
   +------+--------+
   | IC23 | XTAL   |   Change 46.022 MHz to 45.6 MHz
   +------+--------+
   | IC25 | IC26   |
   +------+--------+
   ```

   (4) Change in VDP board jumper switch:

   ```
         P1  P2  P3
   Set JP1  [X][O][O]
            [X][X][X]
            [O][X][X]
   ```

   **For Target Ver. 1.1:**
   - (1) (2) are the same as in Target Ver. 1.0.
   - (3) Crystal exchange of the I/F board:

   ```
   +------+--------+
   | IC32 | XTAL   |   Change 46.022 MHz to 45.6 MHz
   +------+--------+
   |      | IC14   |
   +------+--------+
   ```

   (4) Change in VDP board Dip switch: DIPSW1-1 is on

   **Board combinations:**
   - Ver. 1.0: Main Board (171-6797B), I/F Board (171-6815A), VDP Board (171-6816A)
   - Ver. 1.1: Main Board (171-6797B), I/F Board (171-6815B), VDP Board (171-6816B)

10. **DMA (using FIFO) restrictions from 68000 to SH2:**
    Limit the amount of data sent per transfer in Ver. 1.x to under 100h words. Due to the characteristics of the ALTERA chip, countermeasures per Ver. 1.x are not possible.

    This restriction does not apply to Ver. 2.0.

---

## 32X H/W Information (3)

### Items Related to ICE and Peripherals Development Devices

**May 9, 1994**

1. **ICE CPU mode setting**
   - E7000: Set to 0E if using master per command MD:C; set to 2E if using slave.
   - EVA board: Set short pin 16 to ON if using master; set to OFF if using slave.

2. **SH2 socket Master/Slave position**

   ```
   Main Board
   +------------------+
   |                  |
   |       68K        |
   |                  |
   |                  |
   |       SH2        |
   | [Master] [Slave] |
   +------------------+
   ```

**May 27, 1994**

3. **Precautions when using a 32 Mbit SRAM board.**

   - The 32 Mbit SRAM W/BUP board mis-reads data on the SH2 RAM board when both 68000 and SH2 are running.
   - The modifications on the next page are required for 32X development.
   - There are no problems when running 68000 and SH2 independently.
   - There is no need for modifying MD development.

#### Modification Method of the 32 Mbit SRAM W/BUP Board

**Board Layout (Front and Back):**

```
Front:                    Back:
+--+--+--+--+            +--+--+--+--+
|  |  |  |  |            |  |  |  |  |
+--+--+--+--+            +--+--+--+--+
|  |  |  |  |            |  |  |  |  |
+--+--+--+--+            +--+--+--+--+
|  |  |  |  | IC3        |  |  |  |  |
+--+--+--+--+            +--+--+--+--+
|  |  |     | IC4              []  []
+--+--+     | IC5
[] [] |     |
+-----+-----+
  B28   B29       IC48
```

**Cut Method:** Remove pin from board (pin A). Cut between points B and A.

**Component values after modification:**
- IC4 -> 1
- IC5 -> 1
- IC48 -> 5.6

**Original circuit:**

```
B28 ---LWR---> IC4 (pin 1, DIR)     ALS245
B29 ---UWR---> IC5 (pin 1, DIR)     ALS245

IC48B (1/4 HC02):
  pin 5 ---|
  pin 6 ---+---> pin 4
```

**Modified circuit:**

```
B28 ----+--Jumper (lift pin)---> IC4 (pin 1, DIR)     ALS245
        |
B29 ----+--Jumper (lift pin)---> IC5 (pin 1, DIR)     ALS245
        |
        +---> IC48B pin 4
                1/4HC02
                pin 5 <--- B16 (CAS0)
                pin 6 <--- Cut (to GND)
                           Cut (to GND)
```

(Revised June 6, 1994)

#### Modification Method of the 16 Mbit SRAM W/BUP Board

**Board Layout (Front and Back):**

```
Front:                    Back:
[] [] []                  OO
+--+--+--+--+ U30        +--+--+--+--+
|  |  |  |  |            |  |  |  |  |
+--+--+--+--+ U31        +--+--+--+--+
|  |  |  |  |                []  []
+--+--+     + U32
[] []       |
+--+--+-----+------+
      U33   [      ]
            [||||||]
```

**Work Procedure:**

1. Lift pin 1 of U31 and U32.
2. Lift pins 13, 14, and 15 of U33.
3. Add jumper between pin 16 of U30 and pins 13 and 14 of U33.
4. Connect pin 15 of U33 to GND (pin 8).
5. Add jumper between pin 9 of U33 and pin 1 of each U31 and U32.

**After Modification:**

```
U30                U33              U31
+------+     +----------+     +------+
| OE0  |--16-|-13       |     |  DIR |-1---+
|      |     |-14       |     +------+     |
+------+     |          |                  |
             |-15-G  Y3-|---->pin 9--------+
             +----+-----+                  |
                  |                   U32  |
                 GND              +------+ |
                                  |  DIR |-1---+
                                  +------+
```
