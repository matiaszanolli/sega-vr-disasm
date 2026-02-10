# IC BD 4M 32 PIN x 8 EPROM 32X R/D User's Manual

> **Converted from PDF**: `IC_BD_4M_32PIN_x_8_EPROM_32X_RD_User's_Manual.pdf`
>
> **Product Number**: 837-11069
> **Document Number**: MAR-47-081594
> **Publisher**: SEGA of America, Inc. -- Consumer Products Division
> **Copyright**: 1994 SEGA. All Rights Reserved.
> **Classification**: CONFIDENTIAL -- PROPERTY OF SEGA

---

## 1.0 Overview

This is one of the cards used in developing software for the Mega Drive / 32X. Below is a list of its main features.

1. Can mount EPROM of up to 32 Mbit (4 Mbyte) on the card.
   The EPROM used by this card uses a Toshiba TC574000AD series or equivalent product. Access time uses a device of 150 ns or less. This EPROM is not included.

2. An SRAM with a maximum 256 Kbit and battery backup function is installed.

3. Using the bank select function, any EPROM can be selected and accessed in 4-Mbit units. Bank numbers are valid from 0H to 7H.

4. Power Supply DC +5V is supplied from the main unit.

5. Has a memory mode switch function.
   Can handle the conventional Mega Drive 16-Mbit mode via switches. Mode at factory shipment is the 32-Mbit mode.

---

## 2.0 Main Specifications

| Parameter | Value |
|-----------|-------|
| Product Number | 837-11069 |
| Print Circuit Board Number | 171-6866 |
| Memory Capacity | SRAM 32 Mbit (program area), SRAM 1 Mbit (data area) |
| Word Length | 1 word = 16 bits |
| Memory Expandability | Format: Bank Selector |
| I/O Specifications | Conforms to Mega Drive, cartridge, connector specifications |
| Card Dimensions | 95.5 (W) x 150 (H) mm |
| Pins Used | General logic pins: TTL, LSI, IC |
| EPROM | TC574000AD-150 (Toshiba) equivalent product |
| SRAM | HM62256ALFP-12 (Hitachi) equivalent product |
| Custom IC | 315-5709 (Sega) |
| Battery | CR2032 (Sony) equivalent product |
| Other | Electrolytic capacitor, chip capacitor, battery socket, DIP switch, etc. |
| Power supply | +5V |
| Temperature Range | 5 C - 40 C |
| Relative Humidity | 80% RH or less |

---

## 3.0 Description of Functions

The SRAM card is managed by partitioning the memory address in 4 Mbits (bank 0 - bank 7, 32 Mbits). The Mega Drive cartridge area is partitioned into eight areas, each having 4 Mbits. Only area 0 with vector is fixed, and to the remaining seven areas, any bank can be allocated. Banks are specified by the bank setting register (Mega Drive A130F1H - A130FFH odd addresses).

**Register 0 details:**
- Bit 0 of register 0 is the address following 200000H used in switching the ROM side / backup RAM side.
- Bit 1 of register 0 is used in setting the backup RAM write protect.
- Because there is no bank for the backup RAM, addresses after 200000H become directly backup RAM area.

**Bank number assignment:**
- Bank numbers written in register 1 through register 7 correspond to their respective areas 1 through 7.
- Bank numbers can be set from 0 to 63; however with the RAM card, only the RAM installed bank numbers are effective.
- When 32 Mbits are loaded, only bank numbers from 0 to 7 are effective. The area will not function properly for any other setting.

**Power-on/Reset behavior:**
When the power is turned on or reset, the cartridge area becomes 32 Mbit ROM mode (area 1 - area 7: bank 1 - bank 7) space and write protect for the backup RAM is turned off. In this way, allocating all 32 Mbit address space to the MD cartridge area is called the 32M mode.

### MD Cartridge Area and Bank Set Register Map

```
MD Cartridge Area          Bank Set Register

                           D7  D6  D5  D4  D3  D2  D1  D0

000000H  Area 0            Register 0 (A130F1H)
         (permanent)       [ 0 | 0 | 0 | 0 | 0 | 0 |*2 |*1 ]

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
- `*2`: Writable at 0, not writable at 1
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

---

### 3.1 Using the 16 Mbit ROM Mode + Backup RAM

The SRAM card accommodates bank switching at shipment; therefore, it is 32 Mbit ROM space when initialized. As a result, the SRAM card is not compatible with a cartridge with 16 Mbit or less + backup RAM. (Existing memory map)

Changing DIP switch settings allows the use of 16 Mbit ROM + backup RAM. Because changing the DIP switch settings automatically results in the 16 Mbit ROM + backup RAM when the power is turned on or reset, changing the bank setting register is not necessary.

This applies to 000000H - 1FFFFFH ROM area, backup RAM area from 200000H. This type of memory allocation is called the 16M mode. Improper operation occurs if a bank register is changed in this mode.

---

## 3.2 Setting Switches with the Card

DIP switches are designed on the card, and 32 Mbit and 16 Mbit memory modes can be selected by setting these switches.

### Configuration: 32 Mode (Factory settings)

**SW135:**

| 1 | 2 | 3 | 4 | 5 | 6 |
|---|---|---|---|---|---|
| ON | -- | ON | -- | ON | ON |
| -- | OFF | -- | OFF | -- | -- |

### Configuration: 16 Mode (User settings)

**SW135:**

| 1 | 2 | 3 | 4 | 5 | 6 |
|---|---|---|---|---|---|
| -- | ON | -- | -- | ON | ON |
| OFF | -- | OFF | OFF | -- | -- |

---

## 3.3 Switch Descriptions

Switches 1 to 3 are used in chip select signal switching per each device.

| Switch | Function |
|--------|----------|
| Switch 4 | Not used. Normally turned OFF. |
| Switch 5 | Bank Register operation allowed/not allowed. **ON** = Bank Register operation allowed. **OFF** = Bank Register operation not allowed. |
| Switch 6 | Option -- Signal connectivity switching with device consideration. **ON** = -CART signal connected. **OFF** = -CART signal not connected. |

---

## 4.0 EPROM Mounting

This EPROM card has IC socket installed for IC 1 through IC 8. Programmed EPROM is used by being inserted in IC socket. Because the EPROM used by EPROM card is 512 Kbytes, use a minimum of two per word (EPROM is installed in IC1 and IC2).

### Byte Lane Assignment

- **IC1, IC3, IC5, IC7** correspond to lower bytes (odd address, D0 - D7).
- **IC2, IC4, IC6, IC8** correspond to upper bytes (even address, D8 - D15).

### Correlation with ROM Banks

| IC Sockets | Bank Mapping |
|------------|--------------|
| IC1 and IC2 mount | Corresponds to bank 0 and bank 1 |
| Mounted IC3 and IC4 | Corresponds to bank 2 and bank 3 |
| Mounted IC5 and IC6 | Corresponds to bank 4 and bank 5 |
| Mounted IC7 and IC8 | Corresponds to bank 6 and bank 7 |

**Note:** When installing the EPROM, do so after checking the position of pin no. 1.

---

## 5.0 View

**Board**: 171-6866 (Front View)

The board layout shows eight 32-pin EPROM sockets arranged in a 2-wide by 4-tall grid across the upper portion of the board. The left column contains IC1 (bottom), IC3, IC5, and IC7 (top). The right column contains IC2 (bottom), IC4, IC6, and IC8 (top). Below the EPROM sockets are the Sega custom IC (315-5709), DIP switches, battery holder (CR2032), support circuitry, and the cartridge edge connector at the bottom. The board identification "837-11069" is printed on the PCB.
