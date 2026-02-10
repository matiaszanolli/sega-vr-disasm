# IC BD 32M SRAM + 256K BUP 32X R/D User's Manual

> **Converted from PDF**: `IC_BD_32M_SRAM_256K_BUP_32X_RD_User's_Manual.pdf`
>
> **Product Number**: 837-11068
> **Document Number**: MAR-46-081594
> **Publisher**: SEGA of America, Inc. -- Consumer Products Division
> **Copyright**: 1994 SEGA. All Rights Reserved.
> **Classification**: CONFIDENTIAL -- PROPERTY OF SEGA

---

## 1.0 Overview

This is one of the cards used in developing software for the Mega Drive / 32X. Below is a list of its main features.

1. 32 Mbit (4 Mbyte) of SRAM mounted on the card.
   The SRAM chip used by this card uses a Hitachi HM628128ALFP series or equivalent product. Access time uses a device of 100 ns or less. The SRAM is backed up by a battery.

2. SRAM with a 1-Mbyte (maximum) battery backup function mounted for data memory. Select from 256 Kbit, 512 Kbit, and 1 Mbit settings. Factory setting at shipment is 256 Kbits.

3. Using the bank select function, memory can be selected arbitrarily and accessed in 4 Mbit units. Bank numbers are valid from 0H to 7H.

4. Power Supply DC +5V is supplied from the main unit.

5. Designed memory write protect/write enable registers. Memory content is protected from unnecessary memory write access to the program area. The initial status immediately after the power on is the write protect status.

6. Includes LED status indicator function.
   Has a function to indicate low battery warning and data retention voltage abnormalities via LEDs. The battery is used in memory write enable and backup.

7. Includes memory mode switching function.
   Can handle the conventional Mega Drive 16 Mbit mode through a switch.

---

## 2.0 Main Specifications

| Parameter | Value |
|-----------|-------|
| Product Number | 837-11068 |
| Print Circuit Number | 171-6865 |
| Memory Capacity | SRAM 32 Mbit (program area), SRAM 1 Mbit (data area) -- 256 Kbits when shipped from factory (512 Kbit / 1 Mbit switch setting is possible) |
| Word Length | 1 word = 16 bits |
| Memory Expandability | Format: Bank Select |
| I/O Specifications | Conforms to Mega Drive, cartridge, connector specifications |
| Card Dimensions | 95.5 (W) x 165 (H) mm |
| Pins Used | General logic pins: TTL, LSI, IC |
| SRAM | HM628128ALFP-10 (Hitachi) equivalent product |
| Custom IC | 315-5709 (Sega) |
| Battery | CR2032 (Sony) equivalent product, ML-2016 (Sanyo) equivalent product |
| Other | Electrolytic capacitor, chip capacitor, battery socket, DIP switch, etc. |
| Power supply | DC +5V |
| Temperature Range | 5 C - 40 C |
| Relative Humidity | 80% RH or less |

---

## 3.0 Description of Functions

The SRAM card is managed by partitioning the memory address in 4 Mbits (bank 0 - bank 7, 32 Mbits). The Mega Drive cartridge area is partitioned into eight areas, each having 4 Mbits. Only area 0 with vector is fixed, and to the remaining seven areas, any bank can be allocated. Banks are specified by the bank setting registers (Mega Drive A130F1H - A130FFH odd addresses).

**Register 0 details:**
- Bit 0 of register 0 is the address following 200000H used in switching the ROM side / backup RAM side.
- Bit 1 of register 0 is used in setting the backup RAM write protect.
- Because there is no bank for the backup RAM, addresses after 200000H become directly backup RAM area.

**Bank number assignment:**
- Bank numbers written in register 1 through register 7 correspond to their respective areas 1 through 7.
- Bank numbers can be set from 0 to 63; however, with the RAM card, only the RAM installed bank numbers are effective.
- When 32 Mbits are loaded, only bank numbers from 0 to 7 are effective. The area will not function properly for any other setting.

**Power-on/Reset behavior:**
When the power is turned on or reset, the cartridge area becomes 32 Mbit ROM mode (area 1 - area 7: bank 1 - bank 7) space and write protect for the backup RAM is turned off. In this way allocating all 32 Mbit address space to the MD cartridge area is called the 32M mode.

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
- `*2`: Can write at 0, not at 1
- BN0 - BN5 are bank numbers

### ROM Area Write Enable Register

```
                           D15  D14  D13  D12  D11  D10  D9  D8

ROM area write enable      [ EB | 0  | 0  | 0  | 0  | 0  | 0 | 0 ]
register (A130F0H)
```

| EB Value | Function |
|----------|----------|
| EB = 0 (ROM) | Area write disable (cannot write). Status when power is turned on or reset. |
| EB = 1 (ROM) | Area write enable (can write). LED 1 flashing status. |

**Notes:**
- This register is write only.
- The operation of this register differs from the operation of the conventional 32M SRAM card 837-9951.

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

**Note:** Write not allowed to areas 0 through 7.

---

### 3.1 Using the 16 Mbit ROM Mode + Backup RAM

The SRAM card accommodates bank switching at shipment; therefore, it is 32 Mbit ROM space when initialized. As a result, the SRAM card is not compatible with a cartridge with 16 Mbit or less + backup RAM (existing memory map).

Changing DIP switch settings allows the use of 16 Mbit ROM + backup RAM. Because changing the DIP switch settings automatically results in the 16 Mbit ROM + backup RAM when the power is turned on or reset, changing the bank setting register is not necessary.

This applies to 000000H - 1FFFFFH ROM area, backup RAM area from 200000H. This type of memory allocation is called the 16M mode. Improper operation occurs if a bank register is changed in this mode.

---

## 3.2 Card Switch Settings

DIP switches are designed on the card, and 32 Mbit and 16 Mbit memory modes can be selected by setting switches.

### Configuration: 32 Mode (Factory setting)

**SW0138:**

| 1 | 2 | 3 | 4 | 5 | 6 | 7 | 8 |
|---|---|---|---|---|---|---|---|
| -- | ON | ON | -- | -- | -- | ON | ON |
| OFF | -- | -- | OFF | OFF | OFF | -- | -- |

### Configuration: 16 Mode (User setting)

**SW0138:**

| 1 | 2 | 3 | 4 | 5 | 6 | 7 | 8 |
|---|---|---|---|---|---|---|---|
| -- | ON | -- | ON | -- | -- | ON | ON |
| OFF | -- | OFF | -- | OFF | OFF | -- | -- |

---

## 3.3 Switch Descriptions

Switches 1 to 4 are used in SRAM chip select signal switching. The backup RAM capacity is determined via switches 5 and 6. The standard is 256 Kbits.

### Backup RAM Capacity (Switches 5 and 6)

| Switch 5 | Switch 6 | Capacity |
|----------|----------|----------|
| OFF | OFF | 256 Kbits |
| ON | OFF | 512 Kbits |
| ON | ON | 1 M |

### Individual Switch Functions

| Switch | Function |
|--------|----------|
| Switch 7 | Bank Register operation allowed/not allowed. **ON** = Bank Register operation allowed. **OFF** = Bank Register operation not allowed. |
| Switch 8 | Option -- Signal connectivity switching with device consideration. **ON** = -CART signal connected. **OFF** = -CART signal not connected. |

---

## 3.4 Status Display Function Using LEDs

This card includes functionality that displays card status using three LEDs: LED1, LED2, and LED3.

| LED | ON State | OFF State |
|-----|----------|-----------|
| LED1 | Allows write to the ROM area. | Disallows write to the ROM area (write protect). |
| LED2 | Replace the battery CR2032 (BATT0248). | The battery still has ample power. |
| LED3 | Voltage is abnormal, please replace battery CR2032 (BATT0248). | Memory data protect voltage is normal. |

---

## 4.0 View

**Board**: 171-6865 (Front View -- Component Side Silk)

The board layout shows a large grid of SRAM IC sockets arranged in a 4-wide by 4-tall matrix across the upper portion of the board. Below the SRAM sockets are the Sega custom IC (315-5709), additional support circuitry, DIP switches, LEDs, battery holder, and the cartridge edge connector at the bottom. The board identification "837-11068" and "IC BD 32M SRAM+256K BUP R/D" are printed on the PCB. "MADE IN JAPAN" is noted, dated 1994.
