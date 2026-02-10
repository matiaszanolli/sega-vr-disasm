# Fujitsu MB838200B/BL Datasheet

> **Converted from PDF**: `MB838200B_datasheet.pdf`
> **Manufacturer**: Fujitsu Limited
> **Edition**: 2.0, April 1993
> **Document**: 11 pages (pages 7-27 through 7-37)

---

## Overview

**MB838200B/BL** -- CMOS 8M-Bit Mask Read Only Memory

**Organization**: 512K x 16 (1M x 8) CMOS Mask Read Only Memory

---

## Description

The Fujitsu MB838200B/BL is a CMOS Si-gate mask-programmable static read only memory organized as 524,288 words by 16 bits or 1,048,576 words by 8 bits.

All pins are TTL-compatible and 3-state output level. The device is full-static operable (i.e. no need of clock signal) with a single +5V power supply. Also, the MB838200BL can be used with a single +3V power supply which is required for battery powered applications.

The MB838200B/BL is designed for applications such as character generator and program storage which require large memory capacity and high-speed/low-power operation.

The memory organization of MB838200B/BL is configurable between 16 bits and 8 bits by BYTE pin (e.g. The system using 8 bits CPU and 16 bits CPU can use common data on the same chip.)

---

## Key Specifications

- **Organization**: 524,288 words x 16 bits / 1,048,576 words x 8 bits
- **Access time**:
  - 120 ns max. @ Vcc = 5V (MB838200B)
  - 200 ns max. @ Vcc = 3V (MB838200BL)
- **Completely static operation**: No clock required
- **TTL compatible Input/Output**
- **Three state output**
- **Power supply**:
  - Single +5V power supply (MB838200B)
  - Single +3V power supply (MB838200BL)
- **Power dissipation**:
  - 275 mW max. (Active) @ Vcc = 5V (MB838200B)
  - 82.5 mW max. (Active) @ Vcc = 3V (MB838200BL)

---

## Available Packages

- **42-pin Plastic DIP**: Suffix P
- **44-pin Plastic SOP**: Suffix PF
- **48-pin Plastic Thin Small Outline Package (TSOP)**:
  - Suffix PFTN (Normal Bend)
  - Suffix PFTR (Reversed Bend)

---

## Pin Assignment -- DIP-42-P-M01 (Top View)

```
              +----U----+
   A18 [ 1]  |         | [42] NC
    A7 [ 2]  |         | [41] A8
    A7 [ 3]  |         | [40] A9
    A6 [ 4]  |         | [39] A10
    A5 [ 5]  |         | [38] A11
    A4 [ 6]  |         | [37] A12
    A3 [ 7]  |         | [36] A13
    A2 [ 8]  |         | [35] A14
    A1 [ 9]  |         | [34] A15
    A0 [10]  |         | [33] A16
    CE [11]  |         | [32] BYTE
  *Vss [12]  |         | [31] Vss*1
    OE [13]  |         | [30] (A-1)/O16
    O1 [14]  |         | [29] O15*
    O8 [15]  |         | [28] O7
    O2 [16]  |         | [27] O14*
  O10* [17]  |         | [26] O6
    O3 [18]  |         | [25] O13*
   O9* [19]  |         | [24] O5
   O11*[20]  |         | [23] O12*
    O4 [21]  |         | [22] Vcc
              +---------+
```

This pin (\*) is High-Z when the device is used in 8-bit mode.

\*1: All pins should be connected.

### Pin Functions

| Pin Name | Function |
|----------|----------|
| A0-A18 | Address inputs |
| A-1 | Additional address input (active in 8-bit mode, directly connected to O16 pin) |
| O1-O16 | Data outputs (O9-O15 are High-Z in 8-bit mode) |
| CE (active low) | Chip Enable |
| OE (active low) | Output Enable |
| BYTE | Byte mode select (H=16-bit, L=8-bit) |
| Vcc | Power supply |
| Vss | Ground |

---

## Block Diagram

The internal architecture consists of:

- **Address Buffer** (A0-A18): Buffers address inputs
- **Row Decoder**: Decodes row portion of address
- **524,288 x 16 bits ROM Cell Array**: Main storage matrix
- **Column Decoder** (A12-A18): Decodes column address
- **Logic**: CE and OE control logic
- **8/16 Change Circuit**: Controlled by BYTE pin
- **Output Buffer** (O1-O16): Three-state output drivers

---

## Output Mode Selection

A-1 is LSB in 8-bit mode:

| BYTE | O1 to O8 | O9 to O15 | (A-1)/O16 |
|:----:|:--------:|:---------:|:---------:|
| H | O1 to O8 | O9 to O15 | O16 |
| L | O1 to O8 | High-Z | A-1 ("L" input) |
| L | O8 to O15 | High-Z | A-1 ("H" input) |

---

## Truth Table

| CE (active low) | OE (active low) | Mode | Output | Power Dissipation Mode |
|:---:|:---:|:---:|:---:|:---:|
| H | X | Not Selected | High-Z | Standby |
| L | H | Not Selected | High-Z | Active |
| L | L | Selected | D_OUT | Active |

---

## Absolute Maximum Ratings (see NOTE)

*Referenced to GND*

| Rating | Symbol | Value | Unit |
|--------|--------|-------|------|
| Supply Voltage | Vcc | -0.3 to +7.0 | V |
| Input Voltage | V_IN | -0.5 to Vcc + 0.5* | V |
| Output Voltage | V_OUT | -0.5 to Vcc + 0.5* | V |
| Temperature Under Bias | T_BIAS | -10 to +85 | deg C |
| Storage Temperature Range | T_STG | -45 to +125 | deg C |

\* Referenced to GND

**NOTE**: Permanent device damage may occur if the above Absolute Maximum Ratings are exceeded. Functional operation should be restricted to the conditions as detailed in the operational sections of this data sheet. Exposure to absolute maximum rating conditions for extended periods may affect device reliability.

---

## Recommended Operating Conditions

*Referenced to GND*

| Parameter | Symbol | MB838200B | | | MB838200BL | | | Unit |
|-----------|--------|-----|-----|-----|-----|-----|-----|------|
| | | Min | Typ | Max | Min | Typ | Max | |
| Supply Voltage | Vcc | 4.5 | 5.0 | 5.5 | 2.7 | 3.0 | 3.3 | V |
| Input Low Voltage | V_IL | -0.3 | | 0.8 | -0.3 | | 0.6 | V |
| Input High Voltage | V_IH | 2.2 | | Vcc+0.3 | Vcc x 0.7 | | Vcc+0.3 | V |
| Ambient Temperature | T_A | 0 | | 70 | 0 | | 70 | deg C |

---

## DC Characteristics

*Recommended operating conditions unless otherwise noted.*

| Parameter | Test Condition | Symbol | MB838200B | | | MB838200BL | | | Unit |
|-----------|---------------|--------|-----|-----|-----|-----|-----|-----|------|
| | | | Min | Typ | Max | Min | Typ | Max | |
| Active Supply Current | CE=V_IL, Min Cycle, Output=Open | Icc | | 50 | | | 25 | | mA |
| Standby Supply Current | CE=V_IH | I_SB1 | | 1 | | | 0.5 | | mA |
| | CE=Vcc=V_IH, V_IN=GND or Vcc | I_SB2 | | 10 | | | 10 | | uA |
| Input Leakage Current | V_IN=0 to Vcc | I_LI | -10 | 10 | | -10 | 10 | | uA |
| Output Leakage Current | CE=V_IH, OE=V_IH | I_LIO | -10 | 10 | | -10 | 10 | | uA |
| Output High Voltage | I_OH=-400 uA | V_OH | 2.4 | | | 2.0 | | | V |
| Output Low Voltage | I_OL=2.1 mA | V_OL | | 0.4 | | | 0.4 | | V |
| | I_OL=1.0 mA | V_OL | | | | | 0.4 | | V |

---

## Capacitance (Ta = 25 deg C, f = 1 MHz)

| Parameter | Symbol | Min | Typ | Max | Unit |
|-----------|--------|-----|-----|-----|------|
| Output Capacitance (V_OUT = 0V) | C_OUT | | | 15 | pF |
| Input Capacitance (V_IN = 0V) | C_IN | | | 10 | pF |

---

## AC Characteristics

*Recommended operating conditions unless otherwise noted.*

### AC Test Conditions

- **Input Pulse Level**: 0.6 to 2.4V @ Vcc = 5V (MB838200B); 0.4 to Vcc x 0.8 @ Vcc = 3V (MB838200BL)
- **Input Pulse Rise and Fall Time**: tT = 5 ns
- **Timing Reference Levels**:
  - Input: V_IL = 0.8V, V_IH = 2.2V / Output: V_OL = 0.8V, V_OH = 2.2V @ Vcc = 5V (MB838200B)
  - Input: V_IL = 0.5V, V_IH = Vcc x 0.7V / Output: V_OL = 1.2V, V_OH = 1.8V @ Vcc = 3V (MB838200BL)
- **Output Load**: 1 TTL Gate and 100 pF

### AC Timing Parameters

| Parameter | Test Condition | Symbol | MB838200B | | MB838200BL | | Unit |
|-----------|---------------|--------|-----|-----|-----|-----|------|
| | | | Min | Max | Min | Max | |
| Address Access Time | CE=OE=V_IL | t_ACC | | 120 | | 200 | ns |
| Chip Enable Access Time | OE=V_IL | t_CE | | 120 | | 200 | ns |
| Output Enable Access Time | *1 | t_OE | | 60 | | 120 | ns |
| Output Disable Time | *2 | t_DF | | 50 | | 60 | ns |
| Output Hold Time | CE=OE=V_IL | t_OH | 0 | | 0 | | ns |

*1: When continuously switching between 3V operation and 5V operation, during Vcc transition the CE should be High state (Standby mode).*

*2: t_DF is specified by either of CE or OE changing to High earlier.*

---

## Timing Diagram Description

The timing diagram shows:

1. **Address lines** (A0 to A18, or A-1 to A18 in 8-bit mode): Set valid address
2. **CE (active low)**: Goes low to enable chip, with t_CE access time to data valid
3. **OE (active low)**: Goes low to enable outputs, with t_OE access time to data valid
4. **t_ACC**: Address access time from address stable to data valid output
5. **t_DF**: Output disable time after CE or OE goes high
6. **t_OH**: Output hold time after address change (0 ns minimum)
7. **Data outputs** (O1 to O16 or O1 to O8): Valid data appears after access time, outputs go high-Z after t_DF

---

## Package Dimensions

### DIP-42-P-M01 (Suffix: P) -- 42-Lead Plastic Dual In-Line Package

| Dimension | inches (millimeters) |
|-----------|---------------------|
| Package length | 2.063 +0.008/-0.012 (52.40 +0.20/-0.30) |
| Package width | 0.543 +/- 0.010 (13.80 +/- 0.25) |
| Pin spacing | 0.600 (15.24) typ |
| Lead width | 0.034 +0.020/-0 (0.865 +0.50/-0) |
| Pin pitch | 0.100 (2.54) typ |
| Lead thickness | 0.018 +/- 0.003 (0.46 +/- 0.08) |
| Standoff height | 0.020 (0.51) min |
| Package height | 0.195 (4.96) max / 0.118 (3.00) min |
| Lead insertion width | 0.050 +0.020/-0 (1.27 +0.50/-0) |

### FPT-44P-M05 (Suffix: PF) -- 44-Lead Plastic Flat Package

Pin assignment for FPT-44P-M05 (44-pin SOP):

```
              +----U----+
   NC  [ 1]  |         | [44] NC
   A18 [ 2]  |         | [43] NC
   A17 [ 3]  |         | [42] A8
    A7 [ 4]  |         | [41] A9
    A6 [ 5]  |         | [40] A10
    A5 [ 6]  |         | [39] A11
    A4 [ 7]  |         | [38] A12
    A3 [ 8]  |         | [37] A13
    A2 [ 9]  |         | [36] A14
    A1 [10]  |         | [35] A15
    A0 [11]  |         | [34] A16
    CE [12]  |         | [33] BYTE
 Vss*1 [13]  |         | [32] Vss*1
    OE [14]  |         | [31] (A-1)/O16
    O1 [15]  |         | [30] O8
   O9* [16]  |         | [29] O15*
    O2 [17]  |         | [28] O7
  O10* [18]  |         | [27] O14*
    O3 [19]  |         | [26] O6
  O11* [20]  |         | [25] O13*
    O4 [21]  |         | [24] O5
  O12* [22]  |         | [23] Vcc
              +---------+
```

This pin (\*) is High-Z when the device is used in 8-bit mode.

\*1: All pins should be connected.

Package dimensions:
| Dimension | inches (millimeters) |
|-----------|---------------------|
| Body length | 1.120 +0.010/-0.008 (28.45 +0.25/-0.20) |
| Body width | 0.638 +/- 0.008 (16.20 +/- 0.20) |
| Overall width | 0.512 +/- 0.004 (13.00 +/- 0.10) |
| Lead width | 0.016 +0.004/-0.002 (0.40 +0.10/-0.05) |
| Mounting height | 0.098 (2.50) max |
| Stand off height | 0 (0) min |
| Pin pitch | 0.050 (1.27) typ |

### FPT-48P-M07 (Suffix: PFTN) -- 48-Lead Plastic Flat Package, Normal Bend

Pin assignment for FPT-48P-M07 (48-pin TSOP, Normal Bend):

```
              +----U----+
  BYTE [ 1]  |         | [48] Vss*2
   A16 [ 2]  |         | [47] Vss*2
   A15 [ 3]  |         | [46] (A-1)/O16
   A14 [ 4]  |         | [45] O8
   A13 [ 5]  |         | [44] O15*
   A12 [ 6]  |         | [43] O7
   A11 [ 7]  |         | [42] O14*
   A10 [ 8]  |         | [41] O6
    A9 [ 9]  |         | [40] O13*
    A8 [10]  |         | [39] O5
    NC [11]  |         | [38] Vcc
  NC*1 [12]  |         | [37] Vcc
    NC [13]  |         | [36] NC*1
   A18 [14]  |         | [35] O12*
   A17 [15]  |         | [34] O4
    A7 [16]  |         | [33] O11*
    A6 [17]  |         | [32] O3
    A5 [18]  |         | [31] O10*
    A4 [19]  |         | [30] O2
    A3 [20]  |         | [29] O9*
    A2 [21]  |         | [28] O1
    A1 [22]  |         | [27] OE
    A0 [23]  |         | [26] Vss*2
    CE [24]  |         | [25] Vss*2
              +---------+
```

This pin (\*) is High-Z when the device is used in 8-bit mode.

\*1: If the voltage is applied externally, it should be connected to Vss.

\*2: All pins should be connected.

Package dimensions:
| Dimension | inches (millimeters) |
|-----------|---------------------|
| Body length | 0.709 +/- 0.008 (18.00 +/- 0.20) |
| Body width | 0.472 +/- 0.008 (12.00 +/- 0.20) |
| Overall width | 0.453 (11.50) ref |
| Mounting height | 0.043 +0.004/-0.002 (1.10 +0.10/-0.05) |
| Stand off height | 0 (0) min |
| Lead width | 0.006 +/- 0.002 (0.15 +/- 0.05) |
| Lead thickness | 0.008 +/- 0.004 (0.20 +/- 0.10) |
| Pin pitch | 0.020 +/- 0.004 (0.50 +/- 0.10) |

### FPT-48P-M08 (Suffix: PFTR) -- 48-Lead Plastic Flat Package, Reversed Bend

Pin assignment for FPT-48P-M08 (48-pin TSOP, Reversed Bend):

```
              +----U----+
    CE [24]  |         | [25] Vss*2
    A0 [23]  |         | [26] Vss*2
    A1 [22]  |         | [27] OE
    A2 [21]  |         | [28] O1
    A3 [20]  |         | [29] O9*
    A4 [19]  |         | [30] O2
    A5 [18]  |         | [31] O10*
    A6 [17]  |         | [32] O3
    A7 [16]  |         | [33] O11*
   A17 [15]  |         | [34] O4
   A18 [14]  |         | [35] O12*
    NC [13]  |         | [36] NC*1
  NC*1 [12]  |         | [37] Vcc
    NC [11]  |         | [38] Vcc
    A8 [10]  |         | [39] O5
    A9 [ 9]  |         | [40] O13*
   A10 [ 8]  |         | [41] O6
   A11 [ 7]  |         | [42] O14*
   A12 [ 6]  |         | [43] O7
   A13 [ 5]  |         | [44] O15*
   A14 [ 4]  |         | [45] O8
   A15 [ 3]  |         | [46] (A-1)/O16
   A16 [ 2]  |         | [47] Vss*2
  BYTE [ 1]  |         | [48] Vss*2
              +---------+
```

(Pin numbering is reversed from PFTN -- marking face is opposite side)

This pin (\*) is High-Z when the device is used in 8-bit mode.

\*1: If the voltage is applied externally, it should be connected to Vss.

\*2: All pins should be connected.

Package dimensions (same as FPT-48P-M07):
| Dimension | inches (millimeters) |
|-----------|---------------------|
| Body length | 0.669 +/- 0.008 (17.00 +/- 0.20) |
| Body width | 0.472 +/- 0.008 (12.00 +/- 0.20) |
| Overall width | 0.453 (11.50) ref |
| Mounting height | 0.043 +0.004/-0.002 (1.10 +0.10/-0.05) |
| Stand off height | 0 (0) min |
| Lead width | 0.006 +/- 0.002 (0.15 +/- 0.05) |
| Lead thickness | 0.008 +/- 0.004 (0.20 +/- 0.10) |
| Pin pitch | 0.020 +/- 0.004 (0.50 +/- 0.10) |
| Lead count | 48 |

---

*Copyright 1993 by Fujitsu Limited*
