# IC BD 16M 42 PIN x 4 EPROM 32X R/D User's Manual

> **Converted from PDF**: `IC_BD_16M_42PIN_x_4_EPROM_32X_RD_User's_Manual.pdf`
>
> **Product Number**: 837-11070
> **Document Number**: MAR-48-081594
> **Publisher**: SEGA of America, Inc. -- Consumer Products Division
> **Copyright**: 1994 SEGA. All Rights Reserved.
> **Classification**: CONFIDENTIAL -- PROPERTY OF SEGA

---

## 1.0 Overview

This is one of the cards used in developing software for the Mega Drive/32X. Below is a list of its main features.

1. Can install an EPROM of up to 64 Mb (8 MB) on the card.
   The EPROM used by this card uses the TC5716200D / TC578200D series or equivalent product. Access time uses a device of 150 ns or less. This EPROM is not attached.

2. An SRAM with a maximum of 256 KB and battery backup function is installed.

3. Using the bank select function, any EPROM can be selected and accessed in 4 Mbit units. Bank numbers are valid from 0 to 15.
   (When used in 8 Mbits x 4 format, the bank numbers are valid from 0 to 7.)

4. Power Supply: +5V DC is supplied from the main unit.

5. Has a memory mode change function.
   Able to handle the conventional Mega Drive 16 Mbit mode by changing switches. The mode at factory shipment is the 32 Mbit mode.

6. Can select the type of EPROM to be used.
   Either 16 Mbit- or 8 Mbit-type EPROM can be selected by changing DIP switches.

---

## 2.0 Main Specifications

| Parameter | Value |
|-----------|-------|
| Product Number | 837-11070 |
| Printed Circuit Board Number | 171-6867 |
| Memory Capacity | EPROM 64 M / 32 Mbit (program area), SRAM 256 Kbit (data area) |
| Word Length | 1 word = 16 bits |
| Memory Expandability | Format: Bank Select |
| I/O Specifications | Conforms to Mega Drive cartridge connector specifications |
| Card Dimensions | 95.5 (W) x 150 (H) mm |
| Pins Used | General logic pins: TTL, LSI, IC |
| EPROM | TC5716200D-150 / TC578200D-150 (Toshiba) equivalent product |
| SRAM | HM62256ALFP-12 (Hitachi) equivalent product |
| Custom IC | 315-5709 (Sega) |
| Battery | CR2032 (Sony) equivalent product |
| Other | Electrolytic capacitor, chip capacitor, battery socket, DIP switch, etc. |
| Power supply | DC +5V |
| Temperature Range | 5 C - 40 C |
| Relative Humidity | 80% RH or less |

---

## 3.0 Description of Functions

This ROM card is partitioned and managed in 4 Mbit memory addresses (bank 0 - bank 15, 64 Mbits). The Mega Drive cartridge area is partitioned into eight areas, each having 4 Mbits. Only area 0 with vectors is fixed; any bank can be allocated to the remaining seven areas. Banks are specified by the bank setting registers (A130F1H - A130FFH odd addresses of the Mega Drive).

**Register 0 details:**
- Bit 0 of register 0 is the address following 200000H used in switching the ROM/backup RAM.
- Bit 1 of register 0 is used in setting the backup RAM write protect.
- Because there is no bank for the backup RAM, addresses after 200000H become straight backup RAM area.

**Bank number assignment:**
- Bank numbers writing in register 1 through register 7 correspond to their respective areas: area 1 through area 7.
- Bank numbers can be set from 0 to 63; however, with this ROM card, only the EPROM-installed bank numbers are valid.

**EPROM size constraints:**
- When four 16 Mbit EPROMs are used and 64 Mbits are loaded, bank numbers from 0 to 15 are effective and the area will not function properly for any other setting.
- When four 8 Mbit EPROMs are used and 32 Mbits are loaded, bank numbers from 0 to 7 are effective and the area will not function properly for any other setting.

**Power-on/Reset behavior:**
When the power is turned on or reset, the cartridge area becomes 32 Mbit ROM mode (area 1 - area 7: bank 1 - bank 7) space, and write protect for the backup RAM is turned off. This condition, when the entire 32 Mbit address space is allocated to the MD cartridge area, is referred to as 32M mode.

### MD Cartridge Area and Bank Set Register Map

```
MD Cartridge Area          Bank Set Register

                           D7  D6  D5  D4  D3  D2  D1  D0

000000H  Area 0            Register 0 (A130F1H)
         (fixed)           [ 0 | 0 | 0 | 0 | 0 | 0 |*2 |*1 ]

080000H  Area 1            Register 1 (A130F3H)
                           [ 0 | 0 |BN5|BN4|BN3|BN2|BN1|BN0]

100000H  Area 2            Register 2 (A130F5H)
                           [ 0 | 0 |BN5|BN4|BN3|BN2|BN1|BN0]

180000H  Area 3            Register 3 (A130F7H)
                           [ 0 | 0 |BN5|BN4|BN3|BN2|BN1|BN0]

200000H  Area 4  \         Register 4 (A130F9H)
                  |        [ 0 | 0 |BN5|BN4|BN3|BN2|BN1|BN0]
280000H  Area 5  | ROM     Register 5 (A130FBH)
                  | area   [ 0 | 0 |BN5|BN4|BN3|BN2|BN1|BN0]
300000H  Area 6  | or      Register 6 (A130FDH)
                  | Backup [ 0 | 0 |BN5|BN4|BN3|BN2|BN1|BN0]
380000H  Area 7  | RAM     Register 7 (A130FFH)
                  /        [ 0 | 0 |BN5|BN4|BN3|BN2|BN1|BN0]
```

**Notes:**
- `*1`: ROM at 0, RAM at 1
- `*2`: 0 = Write allowed, 1 = Write not allowed
- BN0 - BN5 are bank numbers

### Default Bank Mapping (Power-On / Reset)

| ROM Bank | MD Cartridge Area | Address |
|----------|-------------------|---------|
| Bank 0 | Area 0 | 000000H |
| Bank 1 | Area 1 | 080000H |
| Bank 2 | Area 2 | 100000H |
| Bank 3 | Area 3 | 180000H |
| Bank 4 | Area 4 | 200000H |
| Bank 5 | Area 5 | 280000H |
| Bank 6 | Area 6 | 300000H |
| Bank 7 | Area 7 | 380000H |
| Bank 8 - 15 | (available via bank switching) | -- |

Default register values at power-on/reset:

| Register | Value |
|----------|-------|
| Reg. 0 | 00H |
| Reg. 1 | 01H |
| Reg. 2 | 02H |
| Reg. 3 | 03H |
| Reg. 4 | 04H |
| Reg. 5 | 05H |
| Reg. 6 | 06H |
| Reg. 7 | 07H |

**When using 16 Mbits x 4**, banks are effective from 0 to 15.

**When using 8 Mbits x 4**, banks are effective from 0 to 7.

**Note:** Do not mix and use the 8 Mbit-type EPROMs with the 16 Mbit-type EPROMs.

---

### 3.1 Using the 16 Mbit ROM Mode + Backup RAM

The ROM board accommodates bank switching at shipment; therefore, it is 32 Mbit ROM space when initialized. As a result, there is no compatibility in the case of 16 Mbit or less + backup RAM. (Memory map up to this time)

Changing DIP switches allows the use of 16 Mbit ROM mode + backup RAM. Because changing the DIP switch settings automatically results in the 16 Mbit + backup RAM when the power is turned on or reset, changing the bank setting register is not necessary.

This applies to 000000H - 1FFFFFH ROM area and 200000H to backup RAM area. This type of memory allocation is called the 16M mode. Improper operation occurs if a bank register is changed in this mode.

---

## 3.2 Switch Settings on the Card

Two DIP switches are designed on the card and can select the type of EPROM used for 32 Mbit or 16 Mbit memory mode. The factory setting is 32 M mode for 16 Mbit-type EPROM use.

### Configuration: 32M Mode + 16 Mbit EPROM (Factory Setting)

**SW141:**

| 1 | 2 | 3 | 4 | 5 | 6 |
|---|---|---|---|---|---|
| ON | -- | ON | -- | ON | ON |
| -- | OFF | -- | OFF | -- | -- |

**SW138:**

| 1 | 2 | 3 | 4 | 5 | 6 | 7 | 8 |
|---|---|---|---|---|---|---|---|
| ON | ON | ON | ON | -- | -- | -- | -- |
| -- | -- | -- | -- | OFF | OFF | OFF | OFF |

### Configuration: 32M Mode + 8 Mbit EPROM

**SW141:**

| 1 | 2 | 3 | 4 | 5 | 6 |
|---|---|---|---|---|---|
| ON | -- | -- | ON | ON | -- |
| -- | OFF | OFF | -- | -- | -- |

(Note: SW141 position 6 not explicitly marked in this configuration.)

**SW138:**

| 1 | 2 | 3 | 4 | 5 | 6 | 7 | 8 |
|---|---|---|---|---|---|---|---|
| -- | -- | -- | -- | ON | ON | ON | ON |
| OFF | OFF | OFF | OFF | -- | -- | -- | -- |

### Configuration: 16M Mode + 16 Mbit EPROM

**SW141:**

| 1 | 2 | 3 | 4 | 5 | 6 |
|---|---|---|---|---|---|
| ON | -- | ON | -- | ON | ON |
| -- | OFF | -- | OFF | -- | -- |

(Same as 32M mode for SW141; difference is in SW138.)

**SW138:**

| 1 | 2 | 3 | 4 | 5 | 6 | 7 | 8 |
|---|---|---|---|---|---|---|---|
| ON | ON | -- | -- | -- | -- | -- | -- |
| -- | -- | OFF | OFF | OFF | OFF | OFF | OFF |

### Configuration: 16M Mode + 8 Mbit EPROM

**SW141:**

| 1 | 2 | 3 | 4 | 5 | 6 |
|---|---|---|---|---|---|
| ON | -- | -- | ON | ON | -- |
| -- | OFF | OFF | -- | -- | -- |

(Note: SW141 position 6 not explicitly marked.)

**SW138:**

| 1 | 2 | 3 | 4 | 5 | 6 | 7 | 8 |
|---|---|---|---|---|---|---|---|
| -- | -- | -- | -- | ON | ON | -- | ON |
| OFF | OFF | OFF | OFF | -- | -- | OFF | -- |

---

## 3.3 Description of Each Switch

Two DIP switches, SW141 and SW138, are designed on the card. The function of these switches are explained below.

### SW141 (Memory mode setting switch)

| Switch | Function |
|--------|----------|
| Switches 1 to 3 | Used in the chip select signal switch of SRAM/EPROM. |
| Switch 4 | Not in use. Normally turned OFF. |
| Switch 5 | Select whether to allow/disallow operation of the bank register. **ON** = Bank register operation allowed. **OFF** = Bank register operation not allowed. |
| Switch 6 | Signal connection change with consideration to option devices. **ON** = -CART signal connected. **OFF** = -CART signal not connected. |

### SW138 (EPROM type setting switch)

| Switch | Function |
|--------|----------|
| Switches 1 to 4 | Used in the 16 Mbit type EPROM chip select signal switch. Correspond respectively to IC1 through IC4. |
| Switches 5 to 8 | Used in the 8 Mbit type EPROM chip select signal switch. Correspond respectively to IC1 through IC4. |

---

## 4.0 EPROM Mounting

This EPROM card includes IC sockets IC 1 through IC 4. Programmed EPROMs are inserted in IC sockets and used. Because EPROMs used on this EPROM card are 16 Mbit / 8 Mbit (2 Mbyte / 1 Mbyte), a minimum of one chip should be mounted in IC1.

ROM banks and their corresponding chips are shown below:

### 8 Mbit type (TC578200D)

| IC Socket | Board Location | Bank Mapping |
|-----------|----------------|--------------|
| IC1 mount | U025 | Accommodates bank 0 and bank 1 |
| IC2 mount | U026 | Accommodates bank 2 and bank 3 |
| IC3 mount | U027 | Accommodates bank 4 and bank 5 |
| IC4 mount | U028 | Accommodates bank 6 and bank 7 |

### 16 Mbit type (TC5716200D)

| IC Socket | Board Location | Bank Mapping |
|-----------|----------------|--------------|
| IC1 mount | U025 | Accommodates bank 0 to bank 3 |
| IC2 mount | U026 | Accommodates bank 4 to bank 7 |
| IC3 mount | U027 | Accommodates bank 8 to bank 11 |
| IC4 mount | U028 | Accommodates bank 12 to bank 15 |

**Note:** Before mounting an EPROM, make sure to check the position of pin no. 1.

---

## 5.0 View

**Board**: SEGA 171-6867 (Front View)

The board layout shows four 42-pin EPROM sockets (IC1, IC2, IC3, IC4) arranged horizontally across the top of the board. Below the sockets are the Sega custom IC (315-5709), DIP switches, support circuitry, and the cartridge edge connector at the bottom. The board identification "837-11070" is printed on the PCB.
