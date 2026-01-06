# 2M SRAM + 256K BUP 32X R/D User's Manual

**Product Number:** 837-11068
**Document Number:** MAR-46-081594

**CONFIDENTIAL - PROPERTY OF SEGA**

© 1994 SEGA. All Rights Reserved.

---

## 1.0 Overview

This is one of the cards used in developing software for the Mega Drive / 32X. Below is a list of its main features:

### Key Features

1. **32 Mbit (4 Mbyte) of SRAM** mounted on the card
   - SRAM chip: Hitachi HM62S128ALFP series or equivalent
   - Access time: 100 ns or less
   - Battery backup supported

2. **SRAM with 1-Mbyte (maximum) battery backup function** mounted for data memory
   - Select from 256 Kbit, 512 Kbit and 1 Mbit settings
   - Factory setting at shipment: 256 Kbits

3. **Bank select function** - Memory can be selected arbitrarily and accessed in 4 Mbit units
   - Bank numbers are valid from 0H to 3FH

4. **Power Supply** - DC +5V is supplied from edge connector

5. **Memory write protect/write enable registers**
   - Memory content is protected from unnecessary memory write access to the program area
   - Initial status immediately after power on: write protect status

6. **LED status indicator function**
   - Function to indicate low battery warning and data retention voltage abnormalities via LEDs
   - Battery is used in memory write enable and backup

7. **Memory mode switching function**
   - Can handle the conversion to Mega Drive 16 Mbit mode through a switch

---

## 2.0 Main Specifications

| Specification | Details |
|--------------|---------|
| **Product Number** | 837-11068 |
| **Print Circuit Number** | 171-6865 |
| **Memory Capacity** | SRAM 32 Mbit (program area)<br>SRAM 1 Mbit (data area)<br>256 Kbits when shipped from factory<br>(512 Kbit/1 Mbit switch setting is possible) |
| **Word Length** | 1 word = 16 bits |
| **Memory Expandability** | Format Bank Select |
| **I/O Specifications** | Conforms to Mega Drive cartridge connector specifications |
| **Card Dimensions** | 95.5 (W) × 165 (H) mm |
| **Pins Used** | General logic pins: TTL/LS |
| **SRAM** | HM62812SALFF-10 (Hitachi) equivalent product |
| **Custom IC** | 315-5709 |
| **Battery** | CR2032 (Sony) equivalent product<br>MS621F (Seiko) equivalent product |
| **Other Components** | Electrolytic capacitor, Capacitor, LED, battery socket, DIP switch, etc. |
| **Power Supply** | DC +5V |
| **Temperature Range** | 0°C ~ 40°C |
| **Relative Humidity** | 80% or less |

---

## 3.0 Description of Functions

### Memory Organization

The SRAM card is managed by partitioning the memory address in 4 Mbits (bank 0 ~ bank 7, 32 Mbits total).

The Mega Drive cartridge area is partitioned into **eight areas**, each having 4 Mbits:
- **Area 0:** Fixed (vector area)
- **Areas 1-7:** Can be allocated to any bank

### Bank Setting Registers

Banks are specified by the bank setting registers located at:
- **Mega Drive addresses:** `A130F1H ~ A130FFH` (odd addresses)

#### Register Functions

**Register 0 (A130F1H):**
- **Bit 0:** ROM/Backup RAM switching
  - `0` = ROM area (addresses after `200000H`)
  - `1` = Backup RAM area (addresses after `200000H`)
- **Bit 1:** Backup RAM write protect
  - `0` = Can write
  - `1` = Cannot write (write protect)

**Registers 1-7 (A130F3H ~ A130FFH):**
- Set bank numbers (0-63) for Areas 1-7
- With 32 Mbit card, only bank numbers 0-7 are effective

### Power-On/Reset State

When the power is turned on or reset:
- Cartridge area becomes **32 Mbit ROM mode** (Area 1-7: Bank 1-7)
- Write protect for backup RAM is turned **OFF**
- This default allocation is called the **32M mode**

### Memory Map - 32M Mode

#### MD Cartridge Area to Bank Mapping

| MD Address Range | Area | Bank (Default) | Register |
|-----------------|------|----------------|----------|
| `000000H - 07FFFFH` | Area 0 | Bank 0 (permanent) | - |
| `080000H - 0FFFFFH` | Area 1 | Bank 1 | Register 1 (A130F3H) |
| `100000H - 17FFFFH` | Area 2 | Bank 2 | Register 2 (A130F5H) |
| `180000H - 1FFFFFH` | Area 3 | Bank 3 | Register 3 (A130F7H) |
| `200000H - 27FFFFH` | Area 4 | Bank 4 | Register 4 (A130F9H) |
| `280000H - 2FFFFFH` | Area 5 | Bank 5 | Register 5 (A130FBH) |
| `300000H - 37FFFFH` | Area 6 | Bank 6 | Register 6 (A130FDH) |
| `380000H - 3FFFFFH` | Area 7 | Bank 7 | Register 7 (A130FFH) |

#### Bank Setting Register Format

**Register 0 (A130F1H) - ROM/RAM Control:**

```
D7  D6  D5  D4  D3  D2  D1  D0
 -   -   -   -   -   -  EB ROM/RAM
```

- **Bit 0 (ROM/RAM):**
  - `0` = ROM area
  - `1` = Backup RAM area
- **Bit 1 (EB - Enable Bit):**
  - `0` = ROM area write disabled (cannot write) - **Initial state**
  - `1` = ROM area write enabled (can write) - **LED1 flashing**

**Note:** This register is **write only**. Operation differs from conventional 32M SRAM cards (837-9951).

**Registers 1-7 (A130F3H ~ A130FFH) - Bank Selection:**

```
D7  D6  D5  D4  D3  D2  D1  D0
 -   -  BN5 BN4 BN3 BN2 BN1 BN0
```

- **BN0-BN5:** Bank number (0-63, only 0-7 effective for 32Mbit card)

### Default Power-On State (32M Mode)

```
MD Cartridge Area          Bank          Register Value
┌─────────────────────┐
│ 000000H - 07FFFFH  │ ◄─── Bank 0    (permanent)
│ Area 0              │
├─────────────────────┤
│ 080000H - 0FFFFFH  │ ◄─── Bank 1    Reg. 1: 01H
│ Area 1              │
├─────────────────────┤
│ 100000H - 17FFFFH  │ ◄─── Bank 2    Reg. 2: 02H
│ Area 2              │
├─────────────────────┤
│ 180000H - 1FFFFFH  │ ◄─── Bank 3    Reg. 3: 03H
│ Area 3              │
├─────────────────────┤
│ 200000H - 27FFFFH  │ ◄─── Bank 4    Reg. 4: 04H
│ Area 4              │
├─────────────────────┤
│ 280000H - 2FFFFFH  │ ◄─── Bank 5    Reg. 5: 05H
│ Area 5              │
├─────────────────────┤
│ 300000H - 37FFFFH  │ ◄─── Bank 6    Reg. 6: 06H
│ Area 6              │
├─────────────────────┤
│ 380000H - 3FFFFFH  │ ◄─── Bank 7    Reg. 7: 07H
│ Area 7              │
└─────────────────────┘
```

**Note:** Write not allowed to all areas in initial state.

---

## 3.1 Using the 16 Mbit ROM Mode + Backup RAM

The SRAM card accommodates bank switching at shipment; therefore, it is 32 Mbit ROM space when initialized. As a result, the SRAM card is not compatible with a cartridge with 16 Mbit or less + backup RAM (existing memory map).

### 16M Mode Configuration

Changing DIP switch settings allows the use of **16 Mbit ROM + backup RAM**. Because changing the DIP switch settings automatically results in the 16 Mbit ROM + backup RAM when the power is turned on or resets, changing the bank setting register is not necessary.

**16M Mode Memory Map:**
- `000000H - 1FFFFFH` = ROM area (16 Mbit)
- `200000H - 3FFFFFH` = Backup RAM area

This type of memory allocation is called the **16M mode**.

**CRITICAL:** Improper operation occurs if a bank register is changed in this mode.

---

## 3.2 Card Switch Settings

DIP switches are designed on the card, and 32 Mbit and 16 Mbit memory modes can be selected by setting switches.

### 32M Mode (Factory Setting)

```
SW01-08:  1    2    3    4    5    6    7    8
         OFF  ON   OFF  OFF  OFF  OFF  ON   ON
```

### 16M Mode (User Setting)

```
SW01-08:  1    2    3    4    5    6    7    8
         ON   ON   OFF  OFF  OFF  OFF  ON   ON
```

---

## 3.3 Switch Descriptions

### Switches 1-4: SRAM Chip Select Signal Switching

Used in SRAM chip select signal switching.

### Switches 5-6: Backup RAM Capacity

Determines the backup RAM capacity. The standard is 256 Kbits.

| SW5 | SW6 | Backup RAM Capacity |
|-----|-----|---------------------|
| OFF | OFF | 256 Kbit (default) |
| ON  | OFF | 512 Kbit |
| ON  | ON  | 1 Mbit |

### Switch 7: Register Operation Control

**Register operation allowed/not allowed**
- **ON:** Bank Register operation **allowed**
- **OFF:** Bank Register operation **not allowed**

### Switch 8: Option Signal

**-CART signal connectivity switching** (device consideration)
- **ON:** -CART signal **connected**
- **OFF:** -CART signal **not connected**

---

## 3.4 Status Display Function Using LEDs

This card includes functionality that displays card status using three LEDs: LED1, LED2, and LED3.

### LED Indicators

| LED | State | Meaning |
|-----|-------|---------|
| **LED1** | ON | Allows write to the ROM area |
|  | OFF | Disallows write to the ROM area (write protect) |
| **LED2** | ON | **Replace the battery CR2032 (BATT0248)** - Low battery warning |
|  | OFF | The battery still has ample power |
| **LED3** | ON | **Voltage is abnormal, replace battery CR2032 (BATT0248)** |
|  | OFF | Memory data protect voltage is normal |

### LED Status Summary

- **LED1 = OFF:** Write protected (safe for reading)
- **LED1 = ON:** Write enabled (can modify ROM area)
- **LED2 = ON:** Battery low, replace soon
- **LED3 = ON:** Critical voltage issue, replace battery immediately

---

## 4.0 Component Layout

### Card Views

**Component Side Silk:** 171-6865

- DIP switch location (SW01-08)
- LED indicators (LED1, LED2, LED3)
- Battery holder (CR2032)
- SRAM chips
- Custom IC 315-5709
- Edge connector

---

## Usage Guidelines

### Initial Setup

1. **Check DIP switch settings:**
   - For 32M mode development: Use factory settings
   - For 16M + backup RAM: Change SW1 to ON

2. **Monitor LEDs:**
   - LED1 should be OFF when not writing (protected)
   - LED2 and LED3 should be OFF (battery OK)

3. **Enable write when needed:**
   - Write `01H` to register `A130F1H` to enable ROM area writes
   - LED1 will turn ON
   - **Remember to disable writes after programming**

### Bank Switching Example (32M Mode)

```assembly
; Example: Load Bank 5 into Area 2
move.b  #$05, $A130F5    ; Set Area 2 to Bank 5

; Example: Enable writes to ROM area
move.b  #$01, $A130F1    ; Enable ROM area writes (LED1 ON)

; Example: Switch to Backup RAM
move.b  #$03, $A130F1    ; ROM->RAM + Write Enable
```

### Safety Precautions

1. **Always write protect when not programming**
   - Write `00H` to `A130F1H` after programming complete
   - LED1 should be OFF

2. **Replace battery when indicated**
   - LED2 ON = Replace soon
   - LED3 ON = Replace immediately

3. **Do not change bank registers in 16M mode**
   - Improper operation will occur

4. **Handle with care**
   - Operating temperature: 0°C ~ 40°C
   - Relative humidity: 80% or less

---

## Technical Notes

### Differences from Previous Models

This card (837-11068) operates differently from conventional 32M SRAM cards (837-9951):
- Register `A130F1H` operation has changed
- Register is write-only
- LED1 flashing behavior differs

### Memory Access Times

- SRAM access time: 100 ns or less
- Compatible with standard Mega Drive timing

### Bank Number Limitations

- Valid bank numbers: 0-63 (6 bits)
- For 32 Mbit card: Only 0-7 are functional
- Setting invalid bank numbers will cause malfunction

---

**Document End**
