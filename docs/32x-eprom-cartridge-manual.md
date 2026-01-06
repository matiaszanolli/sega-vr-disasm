# 16M 42 PIN * 4 EPROM 32X R/D User's Manual

**Product Number:** 837-11070
**Document Number:** MAR-48-081594

**CONFIDENTIAL - PROPERTY OF SEGA**

© 1994 SEGA. All Rights Reserved.

---

## 1.0 Overview

This is one of the cards used in developing software for the Mega Drive/32X. Below is a list of its main features:

### Key Features

1. **Can install an EPROM of up to 64 Mb (8 MB)** on the card
   - EPROM used: TC5716200D/TC578200D series or equivalent
   - Access time: 150 ns or less device
   - **EPROM is not attached** (must be purchased and programmed separately)

2. **SRAM with maximum of 256 KB** and battery backup function is installed

3. **Bank select function** - Any EPROM can be selected and accessed in 4 Mbit units
   - Bank numbers valid from 0 to 15
   - When used in 8 Mbit × 4 format, bank numbers valid from 0 to 7

4. **Power Supply:** +5V DC supplied from the main unit

5. **Memory mode change function**
   - Able to handle the conventional Mega Drive 16 Mbit mode by changing switches
   - Mode at factory shipment: 32 Mbit mode

6. **EPROM type selection**
   - Either 16 Mbit-type or 8 Mbit-type EPROM can be selected by changing DIP switches

---

## 2.0 Main Specifications

| Specification | Details |
|--------------|---------|
| **Product Number** | 837-11070 |
| **Printed Circuit Board Number** | 171-6867 |
| **Memory Capacity** | EPROM 64 M/32 Mbit (program area)<br>SRAM 256 Kbit (data area) |
| **Word Length** | 1 word = 16 bits |
| **Memory Expandability** | Format Bank Select |
| **I/O Specifications** | Conforms to Mega Drive cartridge connector specifications |
| **Card Dimensions** | 95.5 (W) × 150 (H) mm |
| **Pins Used** | General logic pins: TTL/LSI |
| **EPROM** | TC5716200D-150 / TC578200D-150 (Toshiba) equivalent product |
| **SRAM** | HM628128 (Hitachi) equivalent product |
| **Custom IC** | 315-5709 |
| **Battery** | CR2032 (Sony) equivalent product |
| **Other Components** | Electrolytic capacitor, chip capacitor, LED, battery socket, DIP switch, etc. |
| **Power Supply** | DC +5V |
| **Temperature Range** | 0°C ~ 40°C |
| **Relative Humidity** | 80% RH or less |

---

## 3.0 Description of Functions

### Memory Organization

This ROM card is partitioned and managed in 4 Mbit memory addresses (bank 0 ~ bank 15, 64 Mbits total).

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
  - `0` = Write allowed
  - `1` = Write not allowed

**Registers 1-7 (A130F3H ~ A130FFH):**
- Set bank numbers (0-63) for Areas 1-7
- With this ROM card, only EPROM-installed bank numbers are effective:
  - **Four 16 Mbit EPROMs (64 Mbit total):** Banks 0-15 are effective
  - **Four 8 Mbit EPROMs (32 Mbit total):** Banks 0-7 are effective

### Power-On/Reset State

When the power is turned on or reset:
- Cartridge area becomes **32 Mbit ROM mode** (Area 1-7: Bank 1-7)
- Write protect for backup RAM is turned **OFF**
- This default allocation is called the **32M mode**

### Memory Map - 32M Mode

#### MD Cartridge Area to Bank Mapping

| MD Address Range | Area | Bank (Default) | Register |
|-----------------|------|----------------|----------|
| `000000H - 07FFFFH` | Area 0 | Bank 0 (fixed) | - |
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
 -   -   -   -   -   -  *2  *1
```

- **Bit 0 (*1):** ROM/RAM selection
  - `0` = ROM area
  - `1` = Backup RAM area
- **Bit 1 (*2):** Write protection
  - `0` = Write allowed
  - `1` = Write not allowed

**Registers 1-7 (A130F3H ~ A130FFH) - Bank Selection:**

```
D7  D6  D5  D4  D3  D2  D1  D0
 -   -  BN5 BN4 BN3 BN2 BN1 BN0
```

- **BN0-BN5:** Bank number (0-63)
  - Only banks 0-15 effective for 64 Mbit (16 Mbit × 4)
  - Only banks 0-7 effective for 32 Mbit (8 Mbit × 4)

### Default Power-On State (32M Mode)

```
ROM Bank              MD Cartridge Area          Register Value
┌─────────────────┐
│ Bank 0          │ ◄─── 000000H - 07FFFFH     (permanent)
│                 │      Area 0
├─────────────────┤
│ Bank 1          │ ◄─── 080000H - 0FFFFFH     Reg. 1: 01H
│                 │      Area 1
├─────────────────┤
│ Bank 2          │ ◄─── 100000H - 17FFFFH     Reg. 2: 02H
│                 │      Area 2
├─────────────────┤
│ Bank 3          │ ◄─── 180000H - 1FFFFFH     Reg. 3: 03H
│                 │      Area 3
├─────────────────┤
│ Bank 4          │ ◄─── 200000H - 27FFFFH     Reg. 4: 04H
│                 │      Area 4
├─────────────────┤
│ Bank 5          │ ◄─── 280000H - 2FFFFFH     Reg. 5: 05H
│                 │      Area 5
├─────────────────┤
│ Bank 6          │ ◄─── 300000H - 37FFFFH     Reg. 6: 06H
│                 │      Area 6
├─────────────────┤
│ Bank 7          │ ◄─── 380000H - 3FFFFFH     Reg. 7: 07H
│                 │      Area 7
└─────────────────┘
│ Bank 8          │
├─────────────────┤
│ Bank 9          │
├─────────────────┤
│ Bank 10         │
├─────────────────┤
│ Bank 11         │
├─────────────────┤
│ Bank 12         │
├─────────────────┤
│ Bank 13         │
├─────────────────┤
│ Bank 14         │
├─────────────────┤
│ Bank 15         │
└─────────────────┘
```

**Notes:**
- When using 16 Mbit × 4, banks are effective from 0 to 15
- When using 8 Mbit × 4, banks are effective from 0 to 7
- **DO NOT mix and use 8 Mbit-type EPROMs with 16 Mbit-type EPROMs**

---

## 3.1 Using the 16 Mbit ROM Mode + Backup RAM

The ROM board accommodates bank switching at shipment; therefore, it is 32 Mbit ROM space when initialized. As a result, there is no compatibility in the case of 16 Mbit or less + backup RAM (memory map up to this time).

### 16M Mode Configuration

Changing DIP switches allows the use of **16 Mbit ROM mode + backup RAM**. Because changing the DIP switch settings automatically results in the 16 Mbit + backup RAM when the power is turned on or reset, changing the bank setting register is not necessary.

**16M Mode Memory Map:**
- `000000H - 1FFFFFH` = ROM area (16 Mbit)
- `200000H - 3FFFFFH` = Backup RAM area

This type of memory allocation is called the **16M mode**.

**CRITICAL:** Improper operation occurs if a bank register is changed in this mode.

---

## 3.2 Switch Settings on the Card

Two DIP switches are designed on the card and can select the type of EPROM used for 32 Mbit or 16 Mbit memory mode. The factory setting is 32M mode for 16 Mbit-type EPROM use.

### 32M Mode - 16 Mbit Type EPROM (Factory Setting)

**SW141:**
```
 1   2   3   4   5   6
ON  OFF ON  OFF ON  ON
```

**SW138:**
```
 1   2   3   4   5   6   7   8
ON  ON  ON  ON  OFF OFF OFF OFF
```

### 16M Mode - 16 Mbit Type EPROM (User Setting)

**SW141:**
```
 1   2   3   4   5   6
OFF ON  ON  OFF ON  ON
```

**SW138:**
```
 1   2   3   4   5   6   7   8
ON  ON  ON  ON  OFF OFF OFF OFF
```

### 32M Mode - 8 Mbit Type EPROM (User Setting)

**SW141:**
```
 1   2   3   4   5   6
ON  OFF ON  OFF ON  ON
```

**SW138:**
```
 1   2   3   4   5   6   7   8
OFF OFF OFF OFF ON  ON  ON  ON
```

### 16M Mode - 8 Mbit Type EPROM (User Setting)

**SW141:**
```
 1   2   3   4   5   6
OFF ON  ON  OFF ON  ON
```

**SW138:**
```
 1   2   3   4   5   6   7   8
OFF OFF OFF OFF ON  ON  ON  ON
```

---

## 3.3 Description of Each Switch

Two DIP switches, **SW141** and **SW138**, are designed on the card. The function of these switches are explained below.

### SW141 (Memory Mode Setting Switch)

| Switch | Function |
|--------|----------|
| **1-3** | Used in the chip select signal switch of SRAM/EPROM |
| **4** | Not in use. Normally turned OFF. |
| **5** | **Bank register operation control:**<br>ON = Bank register operation allowed<br>OFF = Bank register operation not allowed |
| **6** | **Signal connection change** (option devices):<br>ON = -CART signal connected<br>OFF = -CART signal not connected |

### SW138 (EPROM Type Setting Switch)

| Switch | Function |
|--------|----------|
| **1-4** | Used in the **16 Mbit type EPROM** chip select signal switch<br>Correspond respectively to IC1 through IC4 |
| **5-8** | Used in the **8 Mbit type EPROM** chip select signal switch<br>Correspond respectively to IC1 through IC4 |

**Important:** Set switches 1-4 or 5-8 based on which EPROM type you are using, not both.

---

## 4.0 EPROM Mounting

This EPROM card includes IC sockets **IC1 through IC4**. Programmed EPROMs are inserted in IC sockets and used.

Because EPROMs used on this EPROM card are 16 Mbit/8 Mbit (2 Mbyte/1 Mbyte), **a minimum of one chip should be mounted in IC1**.

### ROM Banks and Corresponding Chips

#### 8 Mbit Type (TC578200D)

| Socket | Location | Banks Accommodated |
|--------|----------|-------------------|
| IC1 | U025 | Bank 0 and Bank 1 |
| IC2 | U026 | Bank 2 and Bank 3 |
| IC3 | U027 | Bank 4 and Bank 5 |
| IC4 | U028 | Bank 6 and Bank 7 |

**Total:** 32 Mbit (4 MB) - Banks 0-7

#### 16 Mbit Type (TC5716200D)

| Socket | Location | Banks Accommodated |
|--------|----------|-------------------|
| IC1 | U025 | Bank 0 to Bank 3 |
| IC2 | U026 | Bank 4 to Bank 7 |
| IC3 | U027 | Bank 8 to Bank 11 |
| IC4 | U028 | Bank 12 to Bank 15 |

**Total:** 64 Mbit (8 MB) - Banks 0-15

### Mounting Notes

**CRITICAL:** Before mounting an EPROM, make sure to check the position of pin no. 1.

- EPROMs must be programmed before installation
- Access time: 150 ns or less
- Compatible chips:
  - Toshiba TC5716200D-150 (16 Mbit)
  - Toshiba TC578200D-150 (8 Mbit)
  - Or equivalent products

---

## 5.0 Component Layout

### Card Views

**Front View:** SEGA 171-6867

**Components:**
- IC Sockets: IC1 (U025), IC2 (U026), IC3 (U027), IC4 (U028)
- DIP Switch SW141 (6-position)
- DIP Switch SW138 (8-position)
- Battery holder (CR2032)
- SRAM chip
- Custom IC 315-5709
- Edge connector

---

## Usage Guidelines

### Initial Setup

1. **Program your EPROMs:**
   - Use EPROM programmer to burn your ROM data
   - Verify programming was successful
   - Check access time specification (≤150 ns)

2. **Configure DIP switches:**
   - **For 16 Mbit EPROMs:**
     - SW138 switches 1-4: ON (or configured per IC)
     - SW138 switches 5-8: OFF
   - **For 8 Mbit EPROMs:**
     - SW138 switches 1-4: OFF
     - SW138 switches 5-8: ON (or configured per IC)

3. **Select memory mode:**
   - **32M Mode:** SW141 switch 1 = ON
   - **16M Mode:** SW141 switch 1 = OFF

4. **Mount EPROMs:**
   - Ensure correct orientation (pin 1 alignment)
   - Mount IC1 first (required)
   - Add IC2-IC4 as needed for larger ROMs

### Bank Switching Example (32M Mode)

```assembly
; Example: Access Bank 8 in Area 2 (16 Mbit EPROMs)
move.b  #$08, $A130F5    ; Set Area 2 to Bank 8

; Example: Access Bank 4 in Area 3 (8 Mbit EPROMs)
move.b  #$04, $A130F7    ; Set Area 3 to Bank 4

; Example: Switch to Backup RAM
move.b  #$01, $A130F1    ; Switch ROM->RAM
```

### EPROM Programming Tips

1. **Organization:**
   - Organize your ROM data in 4 Mbit (512 KB) banks
   - Place vectors and startup code in Bank 0
   - Use bank switching for larger programs

2. **Testing:**
   - Test with SRAM cartridge first
   - Burn EPROMs only when code is stable
   - EPROMs cannot be rewritten (use UV erasable or one-time programmable)

3. **Bank Planning:**
   - Plan your bank layout before burning EPROMs
   - Document which data goes in which bank
   - Leave room for expansion if possible

### Safety Precautions

1. **EPROM Handling:**
   - Protect from static electricity
   - Store in anti-static packaging
   - Cover UV window on UV-erasable EPROMs

2. **Mounting:**
   - Double-check pin 1 orientation
   - Apply even pressure when inserting
   - Do not force chips into sockets

3. **Power:**
   - Operating temperature: 0°C ~ 40°C
   - Relative humidity: 80% or less
   - Ensure stable +5V power supply

### Differences from SRAM Cartridge (837-11068)

| Feature | EPROM Cartridge | SRAM Cartridge |
|---------|----------------|----------------|
| **Program Memory** | EPROM (read-only) | SRAM (read/write) |
| **Capacity** | Up to 64 Mbit | 32 Mbit |
| **Programming** | External programmer required | Write directly via cartridge |
| **Rewritability** | One-time (or UV erasable) | Unlimited rewrites |
| **Write Protect** | Not needed (read-only) | LED indicator, register control |
| **Use Case** | Final testing, production masters | Active development |

---

## Technical Notes

### EPROM Types Supported

**16 Mbit EPROMs (recommended):**
- Toshiba TC5716200D-150
- Compatible: 16 Mbit, 16-bit bus, 150ns or faster

**8 Mbit EPROMs:**
- Toshiba TC578200D-150
- Compatible: 8 Mbit, 16-bit bus, 150ns or faster

### Memory Access Times

- EPROM access time: 150 ns or less required
- SRAM access time: 100 ns or less
- Must be compatible with Mega Drive timing

### Bank Number Limitations

- **64 Mbit (16 Mbit × 4):** Banks 0-15 valid
- **32 Mbit (8 Mbit × 4):** Banks 0-7 valid
- **DO NOT MIX:** Never use 8 Mbit and 16 Mbit EPROMs together
- Invalid bank numbers will cause malfunction

### Register Compatibility

The bank switching registers are **compatible** with the SRAM cartridge (837-11068), allowing the same code to work on both development cartridges.

---

## Troubleshooting

| Problem | Possible Cause | Solution |
|---------|---------------|----------|
| Cart not detected | EPROM not in IC1 | Mount EPROM in IC1 first |
| Wrong data displayed | Incorrect bank settings | Verify SW138 matches EPROM type |
| Crashes on bank switch | Invalid bank number | Check bank 0-15 (16M) or 0-7 (8M) |
| No response | Pin 1 misaligned | Check EPROM orientation |
| Intermittent errors | Slow EPROM | Use 150ns or faster |
| Mode issues | Wrong DIP switch | Verify SW141 settings for 32M/16M |

---

**Document End**
