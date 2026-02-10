# STMicroelectronics M27C322 Datasheet

> **Converted from PDF**: `M27C322_datasheet.pdf`
> **Manufacturer**: STMicroelectronics
> **Date**: February 2001
> **Document**: 14 pages

---

## Overview

**M27C322** -- 32 Mbit (2Mb x 16) UV EPROM and OTP EPROM

---

## Key Features

- 5V +/- 10% supply voltage in read operation
- Access time: 80 ns
- Word-wide configurable
- 32 Mbit Mask ROM replacement
- Low power consumption
  - Active current: 50 mA at 5 MHz
  - Stand-by current: 100 uA
- Programming voltage: 12V +/- 0.25V
- Programming time: 50 us/word
- Electronic Signature
  - Manufacturer Code: 0020h
  - Device Code: 0034h

---

## Description

The M27C322 is a 32 Mbit EPROM offered in the UV range (ultra violet erase). It is ideally suited for microprocessor systems requiring large data or program storage. It is organised as 2 MWords of 16 bit. The pin-out is compatible with a 32 Mbit Mask ROM.

The FDIP42W (window ceramic frit-seal package) has a transparent lid which allows the user to expose the chip to ultraviolet light to erase the bit pattern. A new pattern can then be written rapidly to the device by following the programming procedure.

For applications where the content is programmed only one time and erasure is not required, the M27C322 is offered in PDIP42 and SDIP42 packages.

---

## Available Packages

- **FDIP42W** (F): 42-pin Ceramic Frit-seal DIP with window (UV erasable)
- **PDIP42** (B): 42-pin Plastic DIP
- **SDIP42** (S): 42-pin Shrink Plastic DIP

---

## Signal Names

| Signal | Function |
|--------|----------|
| A0-A20 | Address Inputs |
| Q0-Q15 | Data Outputs |
| E (active low) | Chip Enable |
| GV_PP (active low) | Output Enable / Program Supply |
| Vcc | Supply Voltage |
| Vss | Ground |

---

## Pin Assignment -- DIP Connections (42-pin)

```
              +----U----+
   A18 [ 1]  |         | [42] A19
   A17 [ 2]  |         | [41] A8
    A7 [ 3]  |         | [40] A9
    A6 [ 4]  |         | [39] A10
    A5 [ 5]  |         | [38] A11
    A4 [ 6]  |         | [37] A12
    A3 [ 7]  |         | [36] A13
    A2 [ 8]  |         | [35] A14
    A1 [ 9]  |         | [34] A15
    A0 [10]  |         | [33] A16
     E [11]  |         | [32] A20
   Vss [12]  |         | [31] Vss
 GV_PP [13]  |         | [30] Q15
    Q0 [14]  |         | [29] Q7
    Q8 [15]  |         | [28] Q14
    Q1 [16]  |         | [27] Q6
    Q9 [17]  |         | [26] Q13
    Q2 [18]  |         | [25] Q5
   Q10 [19]  |         | [24] Q12
    Q3 [20]  |         | [23] Q4
   Q11 [21]  |         | [22] Vcc
              +---------+
```

---

## Device Operation

The operating modes of the M27C322 are listed in the Operating Modes Table. A single power supply is required in the read mode. All inputs are TTL compatible except for V_PP and 12V on A9 for the Electronic Signature.

### Read Mode

The M27C322 has a word-wide organization. Chip Enable (E, active low) is the power control and should be used for device selection. Output Enable (G, active low) is the output control and should be used to gate data to the output pins independent of device selection.

Assuming that the addresses are stable, the address access time (t_AVQV) is equal to the delay from E to output (t_ELQV). Data is available at the output after a delay of t_GLQV from the falling edge of GV_PP, assuming that E has been low and the addresses have been stable for at least t_AVQV - t_GLQV.

### Standby Mode

The M27C322 has a standby mode which reduces the supply current from 50 mA to 100 uA. The M27C322 is placed in the standby mode by applying a CMOS high signal to the E input. When in the standby mode, the outputs are in a high impedance state, independent of the GV_PP input.

### Two Line Output Control

Because EPROMs are usually used in larger memory arrays, this product features a 2 line control function which accommodates the use of multiple memory connection. The two line control function allows:

a. The lowest possible memory power dissipation
b. Complete assurance that output bus contention will not occur

For the most efficient use of these two control lines, E should be decoded and used as the primary device selecting function, while GV_PP should be made a common connection to all devices in the array and connected to the READ line from the system control bus. This ensures that all deselected memory devices are in their low power standby mode and that the output pins are only active when data is required from a particular device.

---

## Absolute Maximum Ratings

| Symbol | Parameter | Value | Unit |
|--------|-----------|-------|------|
| T_A | Ambient Operating Temperature (3) | -40 to 125 | deg C |
| T_BIAS | Temperature Under Bias | -50 to 125 | deg C |
| T_STG | Storage Temperature | -65 to 150 | deg C |
| V_IO (2) | Input or Output Voltage (except A9) | -2 to 7 | V |
| Vcc | Supply Voltage | -2 to 7 | V |
| V_A9 (2) | A9 Voltage | -2 to 13.5 | V |
| V_PP | Program Supply Voltage | -2 to 14 | V |

**Notes:**
1. Except for the rating "Operating Temperature Range", stresses above those listed in the Table "Absolute Maximum Ratings" may cause permanent damage to the device. These are stress ratings only and operation of the device at these or any other conditions above those indicated in the Operating sections of this specification is not implied. Exposure to Absolute Maximum Rating conditions for extended periods may affect device reliability. Refer also to the STMicroelectronics SURE Program and other relevant quality documents.
2. Minimum DC voltage on Input or Output is -0.5V with possible undershoot to -2.0V for a period less than 20ns. Maximum DC voltage on Output is Vcc + 0.5V with possible overshoot to Vcc + 2V for a period less than 20ns.
3. Depends on range.

---

## Operating Modes

| Mode | E (active low) | GV_PP (active low) | A9 | Q15-Q0 |
|------|:-:|:-:|:-:|:---:|
| Read | V_IL | V_IL | X | Data Out |
| Output Disable | V_IL | V_IH | X | Hi-Z |
| Program | V_IL Pulse | V_PP | X | Data In |
| Program Inhibit | V_IH | V_PP | X | Hi-Z |
| Standby | V_IH | X | X | Hi-Z |
| Electronic Signature | V_IL | V_IL | V_ID | Codes |

*Note: X = V_IH or V_IL; V_ID = 12V +/- 0.5V.*

---

## Electronic Signature

| Identifier | A0 | Q7 | Q6 | Q5 | Q4 | Q3 | Q2 | Q1 | Q0 | Hex Data |
|------------|:--:|:--:|:--:|:--:|:--:|:--:|:--:|:--:|:--:|:--------:|
| Manufacturer's Code | V_IL | 0 | 0 | 1 | 0 | 0 | 0 | 0 | 0 | 20h |
| Device Code | V_IH | 0 | 0 | 1 | 1 | 0 | 1 | 0 | 0 | 34h |

*Note: Outputs Q15-Q8 are set to '0'.*

---

## Read Mode DC Characteristics

(T_A = 0 to 70 deg C, -40 to 85 deg C or -40 to 125 deg C; Vcc = 5V +/- 10%; V_PP = Vcc)

| Symbol | Parameter | Test Condition | Min | Max | Unit |
|--------|-----------|---------------|-----|-----|------|
| I_LI | Input Leakage Current | 0V <= V_IN <= Vcc | | +/-1 | uA |
| I_LO | Output Leakage Current | 0V <= V_OUT <= Vcc | | +/-10 | uA |
| Icc | Supply Current | E = V_IL, GV_PP = V_IL, I_OUT = 0 mA, f = 8 MHz | | 70 | mA |
| Icc | Supply Current | E = V_IL, GV_PP = V_IL, I_OUT = 0 mA, f = 5 MHz | | 50 | mA |
| Icc1 | Supply Current (Standby) TTL | E = V_IH | | 1 | mA |
| Icc2 | Supply Current (Standby) CMOS | E > Vcc - 0.2V | | 100 | uA |
| I_PP | Program Current | V_PP = Vcc | | 10 | uA |
| V_IL | Input Low Voltage | | -0.3 | 0.8 | V |
| V_IH (2) | Input High Voltage | | 2 | Vcc + 1 | V |
| V_OL | Output Low Voltage | I_OL = 2.1 mA | | 0.4 | V |
| V_OH | Output High Voltage TTL | I_OH = -400 uA | 2.4 | | V |

**Notes:**
1. Vcc must be applied simultaneously with or before V_PP and removed simultaneously or after V_PP.
2. Maximum DC voltage on Output is Vcc + 0.5V.

---

## Read Mode AC Characteristics

(T_A = 0 to 70 deg C, -40 to 85 deg C or -40 to 125 deg C; Vcc = 5V +/- 10%; V_PP = Vcc)

| Symbol | Alt | Parameter | Test Condition | M27C322-80 (3) | | M27C322-100 | | Unit |
|--------|-----|-----------|---------------|-----|-----|-----|-----|------|
| | | | | Min | Max | Min | Max | |
| t_AVQV | t_ACC | Address Valid to Output Valid | E = V_IL, GV_PP = V_IL | | 80 | | 100 | ns |
| t_ELQV | t_CE | Chip Enable Low to Output Valid | GV_PP = V_IL | | 80 | | 100 | ns |
| t_GLQV | t_OE | Output Enable Low to Output Valid | E = V_IL | | 40 | | 50 | ns |
| t_EHQZ (2) | t_DF | Chip Enable High to Output Hi-Z | GV_PP = V_IL | 0 | 40 | 0 | 40 | ns |
| t_GHQZ (2) | t_DF | Output Enable High to Output Hi-Z | E = V_IL | 0 | 40 | 0 | 40 | ns |
| t_AXQX | t_OH | Address Transition to Output Transition | E = V_IL, GV_PP = V_IL | 5 | | 5 | | ns |

**Notes:**
1. Vcc must be applied simultaneously with or before V_PP and removed simultaneously or after V_PP.
2. Sampled only, not 100% tested.
3. Speed obtained with High Speed AC measurement conditions.

---

## AC Measurement Conditions

|  | High Speed | Standard |
|--|-----------|----------|
| Input Rise and Fall Times | <= 10 ns | <= 20 ns |
| Input Pulse Voltages | 0 to 3V | 0.4V to 2.4V |
| Input and Output Timing Ref. Voltages | 1.5V | 0.8V and 2V |

### AC Testing Load Circuit

- 1.3V supply through 1N914 diode and 3.3 kOhm resistor to device output
- Capacitive load C_L at output:
  - C_L = 30 pF for High Speed
  - C_L = 100 pF for Standard
  - C_L includes JIG capacitance

---

## Capacitance (T_A = 25 deg C, f = 1 MHz)

| Symbol | Parameter | Test Condition | Min | Max | Unit |
|--------|-----------|---------------|-----|-----|------|
| C_IN | Input Capacitance | V_IN = 0V | | 10 | pF |
| C_OUT | Output Capacitance | V_OUT = 0V | | 12 | pF |

*Note: Sampled only, not 100% tested.*

---

## System Considerations

The power switching characteristics of Advanced CMOS EPROMs require careful decoupling of the supplies to the devices. The supply current Icc has three segments of importance to the system designer: the standby current, the active current and the transient peaks that are produced by the falling and rising edges of E. The magnitude of the transient current peaks is dependent on the capacitive and inductive loading of the device outputs. The associated transient voltage peaks can be suppressed by complying with the two line output control and by properly selected decoupling capacitors.

It is recommended that a 0.1 uF ceramic capacitor is used on every device between Vcc and Vss. This should be a high frequency type of low inherent inductance and should be placed as close as possible to the device. In addition, a 4.7 uF electrolytic capacitor should be used between Vcc and Vss for every eight devices. This capacitor should be mounted near the power supply connection point. The purpose of this capacitor is to overcome the voltage drop caused by the inductive effects of PCB traces.

---

## Read Mode AC Waveform Description

The read mode AC timing shows:

1. **Address (A0-A20)**: Valid address applied, t_AVQV measured from address valid to output valid
2. **E (active low)**: Falling edge starts chip access; t_ELQV from E low to data valid; t_EHQZ from E high to output Hi-Z
3. **GV_PP (active low)**: Falling edge enables outputs; t_GLQV from GV_PP low to data valid; t_GHQZ from GV_PP high to output Hi-Z
4. **Outputs (Q0-Q15)**: Data becomes valid after access time; returns to Hi-Z after disable time
5. **t_AXQX**: Address transition to output transition (minimum 5 ns)

---

## Programming Mode DC Characteristics

(T_A = 25 deg C; Vcc = 6.25V +/- 0.25V; V_PP = 12V +/- 0.25V)

| Symbol | Parameter | Test Condition | Min | Max | Unit |
|--------|-----------|---------------|-----|-----|------|
| I_LI | Input Leakage Current | V_IL <= V_IN <= V_IH | | +/-10 | uA |
| Icc | Supply Current | | | 50 | mA |
| I_PP | Program Current | E = V_IL | | 50 | mA |
| V_IL | Input Low Voltage | | -0.3 | 0.8 | V |
| V_IH | Input High Voltage | | 2.4 | Vcc + 0.5 | V |
| V_OL | Output Low Voltage | I_OL = 2.1 mA | | 0.4 | V |
| V_OH | Output High Voltage TTL | I_OH = -2.5 mA | 3.5 | | V |
| V_ID | A9 Voltage | | 11.5 | 12.5 | V |

*Note: Vcc must be applied simultaneously with or before V_PP and removed simultaneously or after V_PP.*

---

## Margin Mode AC Characteristics

(T_A = 25 deg C; Vcc = 6.25V +/- 0.25V; V_PP = 12V +/- 0.25V)

| Symbol | Alt | Parameter | Test Condition | Min | Max | Unit |
|--------|-----|-----------|---------------|-----|-----|------|
| t_A9HVPH | t_AS9 | V_A9 High to V_PP High | | 2 | | us |
| t_VPHEL | t_VPS | V_PP High to Chip Enable Low | | 2 | | us |
| t_A10HEH | t_AS10 | V_A10 High to Chip Enable High (Set) | | 1 | | us |
| t_A10LEH | t_AS10 | V_A10 Low to Chip Enable High (Reset) | | 1 | | us |
| t_EXA10X | t_AH10 | Chip Enable Transition to V_A10 Transition | | 1 | | us |
| t_EXVPX | t_VPH | Chip Enable Transition to V_PP Transition | | 2 | | us |
| t_VPXA9X | t_AH9 | V_PP Transition to V_A9 Transition | | 2 | | us |

*Note: Vcc must be applied simultaneously with or before V_PP and removed simultaneously or after V_PP.*

---

## Programming Mode AC Characteristics

(T_A = 25 deg C; Vcc = 6.25V +/- 0.25V; V_PP = 12V +/- 0.25V)

| Symbol | Alt | Parameter | Test Condition | Min | Max | Unit |
|--------|-----|-----------|---------------|-----|-----|------|
| t_AVEL | t_AS | Address Valid to Chip Enable Low | | 1 | | us |
| t_QVEL | t_DS | Input Valid to Chip Enable Low | | 1 | | us |
| t_VCHEL | t_VCS | Vcc High to Chip Enable Low | | 2 | | us |
| t_VPHEL | t_OES | V_PP High to Chip Enable Low | | 1 | | us |
| t_VPLVPH | t_PRT | V_PP Rise Time | | 50 | | ns |
| t_ELEH | t_PW | Chip Enable Program Pulse Width (Initial) | | 45 | 55 | us |
| t_EHQX | t_DH | Chip Enable High to Input Transition | | 2 | | us |
| t_EHVPX | t_OEH | Chip Enable High to V_PP Transition | | 2 | | us |
| t_VPLEL | t_VR | V_PP Low to Chip Enable Low | | 1 | | us |
| t_ELQV | t_DV | Chip Enable Low to Output Valid | | | 1 | us |
| t_EHQZ (2) | t_DFP | Chip Enable High to Output Hi-Z | | 0 | 130 | ns |
| t_EHAX | t_AH | Chip Enable High to Address Transition | | 0 | | ns |

**Notes:**
1. Vcc must be applied simultaneously with or before V_PP and removed simultaneously or after V_PP.
2. Sampled only, not 100% tested.

---

## Programming

When delivered (and after each erasure for UV EPROM), all bits of the M27C322 are in the "1" state. Data is introduced by selectively programming "0"s into the desired bit locations. Although only "0"s will be programmed, both "1"s and "0"s can be present in the data word. The only way to change a "0" to a "1" is by die exposition to ultraviolet light (UV EPROM).

The M27C322 is in the programming mode when V_PP input is at 12V, GV_PP is at V_IH and E is pulsed to V_IL. The data to be programmed is applied to 16 bits in parallel to the data output pins. The levels required for the address and data inputs are TTL. Vcc is specified to be 6.25V +/- 0.25V.

---

## PRESTO III Programming Algorithm

The PRESTO III Programming Algorithm allows the whole array to be programmed with a guaranteed margin in a typical time of 100 seconds. Programming with PRESTO III consists of applying a sequence of 50 us program pulses to each word until a correct verify occurs. During programming and verify operation a MARGIN MODE circuit must be activated to guarantee that each cell is programmed with enough margin. No overprogram pulse is applied since the verify in MARGIN MODE provides the necessary margin to each programmed cell.

### Programming Flowchart

1. Set Vcc = 6.25V, V_PP = 12V
2. Set MARGIN MODE
3. Set n = 0
4. Apply E = 50 us Pulse
5. Increment n (++n, max 25)
6. VERIFY: If pass, advance to next address; if fail after 25 attempts, FAIL
7. If last address: proceed to RESET MARGIN MODE
8. CHECK ALL WORDS: 1st at Vcc = 6V, 2nd at Vcc = 4.2V

---

## Program Verify

A verify (read) should be performed on the programmed bits to determine that they were correctly programmed. The verify is accomplished with GV_PP at V_IL. Data should be verified with t_ELQV after the falling edge of E.

---

## Program Inhibit

Programming of multiple M27C322s in parallel with different data is also easily accomplished. Except for E, all like inputs including GV_PP of the parallel M27C322 may be common. A TTL low level pulse applied to a M27C322's E input and V_PP at 12V will program that M27C322. A high level E input inhibits the other M27C322s from being programmed.

---

## Electronic Signature (ES Mode)

The Electronic Signature (ES) mode allows the reading out of a binary code from an EPROM that will identify its manufacturer and type. This mode is intended for use by programming equipment to automatically match the device to be programmed with its corresponding programming algorithm.

The ES mode is functional in the 25 deg C +/- 5 deg C ambient temperature range that is required when programming the M27C322. To activate the ES mode, the programming equipment must force 11.5V to 12.5V on address line A9 of the M27C322, with V_PP = Vcc = 5V.

Two identifier bytes may then be sequenced from the device outputs by toggling address line A0 from V_IL to V_IH. All other address lines must be held at V_IL during Electronic Signature mode.

- **Byte 0** (A0 = V_IL): Manufacturer code (outputs Q0 to Q7)
- **Byte 1** (A0 = V_IH): Device identifier code (outputs Q0 to Q7)

For the STMicroelectronics M27C322, these two identifier bytes are given in Table 4 and can be read-out on outputs Q0 to Q7.

---

## Erasure Operation (applies to UV EPROM)

The erasure characteristics of the M27C322 is such that erasure begins when the cells are exposed to light with wavelengths shorter than approximately 4000 Angstroms. It should be noted that sunlight and some type of fluorescent lamps have wavelengths in the 3000-4000 Angstrom range.

Research shows that constant exposure to room level fluorescent lighting could erase a typical M27C322 in about 3 years, while it would take approximately 1 week to cause erasure when exposed to direct sunlight. If the M27C322 is to be exposed to these types of lighting conditions for extended periods of time, it is suggested that opaque labels be put over the M27C322 window to prevent unintentional erasure.

The recommended erasure procedure for M27C322 is exposure to short wave ultraviolet light which has a wavelength of 2537 Angstroms. The integrated dose (i.e. UV intensity x exposure time) for erasure should be a minimum of 30 W-sec/cm^2. The erasure time with this dosage is approximately 30 to 40 minutes using an ultraviolet lamp with 12000 uW/cm^2 power rating. The M27C322 should be placed within 2.5 cm (1 inch) of the lamp tubes during the erasure. Some lamps have a filter on their tubes which should be removed before erasure.

---

## Ordering Information Scheme

Example: **M27C322 -80 F 1**

| Field | Description | Options |
|-------|------------|---------|
| Device Type | M27 | |
| Supply Voltage | C = 5V +/-10% | |
| Device Function | 322 = 32 Mbit (2Mb x 16) | |
| Speed | -80 = 80 ns (1), -100 = 100 ns | |
| Package | F = FDIP42W, B = PDIP42, S = SDIP42 | |
| Temperature Range | 1 = 0 to 70 deg C, 3 = -40 to 125 deg C, 6 = -40 to 85 deg C | |

*Note: 1. High Speed, see AC Characteristics section for further information.*

---

## Package Mechanical Data

### FDIP42W -- 42 pin Ceramic Frit-seal DIP with window

| Symbol | millimeters | | | inches | | |
|--------|-----|-----|-----|-----|-----|-----|
| | Typ | Min | Max | Typ | Min | Max |
| A | | | 5.72 | | | 0.225 |
| A1 | | 0.51 | 1.40 | | 0.020 | 0.055 |
| A2 | | 3.91 | 4.57 | | 0.154 | 0.180 |
| A3 | | 3.89 | 4.50 | | 0.153 | 0.177 |
| B | | 0.41 | 0.56 | | 0.016 | 0.022 |
| B1 | 1.45 | -- | -- | 0.057 | -- | -- |
| C | | 0.23 | 0.30 | | 0.009 | 0.012 |
| D | | 54.41 | 54.86 | | 2.142 | 2.160 |
| D2 | 50.80 | -- | -- | 2.000 | -- | -- |
| E | 15.24 | -- | -- | 0.600 | -- | -- |
| E1 | | 14.50 | 14.90 | | 0.571 | 0.587 |
| e | 2.54 | -- | -- | 0.100 | -- | -- |
| eA | 14.99 | -- | -- | 0.590 | -- | -- |
| eB | | 16.18 | 18.03 | | 0.637 | 0.710 |
| L | | 3.18 | 4.10 | | 0.125 | 0.161 |
| S | | 1.52 | 2.49 | | 0.060 | 0.098 |
| K | 8.00 | -- | -- | 0.315 | -- | -- |
| K1 | 16.00 | -- | -- | 0.630 | -- | -- |
| alpha | | 4 deg | 11 deg | | 4 deg | 11 deg |
| N | | 42 | | | 42 | |

### PDIP42 -- 42 pin Plastic DIP, 600 mils width

| Symbol | millimeters | | | inches | | |
|--------|-----|-----|-----|-----|-----|-----|
| | Typ | Min | Max | Typ | Min | Max |
| A | | -- | 5.08 | | -- | 0.200 |
| A1 | | 0.25 | -- | | 0.010 | -- |
| A2 | | 3.56 | 4.06 | | 0.140 | 0.160 |
| B | | 0.38 | 0.53 | | 0.015 | 0.021 |
| B1 | | 1.27 | 1.65 | | 0.050 | 0.065 |
| C | | 0.20 | 0.36 | | 0.008 | 0.014 |
| D | | 52.20 | 52.71 | | 2.055 | 2.075 |
| D2 | 50.80 | -- | -- | 2.000 | -- | -- |
| E | 15.24 | -- | -- | 0.600 | -- | -- |
| E1 | | 13.59 | 13.84 | | 0.535 | 0.545 |
| e1 | 2.54 | -- | -- | 0.100 | -- | -- |
| eA | 14.99 | -- | -- | 0.590 | -- | -- |
| eB | | 15.24 | 17.78 | | 0.600 | 0.700 |
| L | | 3.18 | 3.43 | | 0.125 | 0.135 |
| S | | 0.86 | 1.37 | | 0.034 | 0.054 |
| alpha | | 0 deg | 10 deg | | 0 deg | 10 deg |
| N | | 42 | | | 42 | |

### SDIP42 -- 42 pin Shrink Plastic DIP, 600 mils width

| Symbol | millimeters | | | inches | | |
|--------|-----|-----|-----|-----|-----|-----|
| | Typ | Min | Max | Typ | Min | Max |
| A | | | 5.08 | | | 0.200 |
| A1 | | 0.51 | | | 0.020 | |
| A2 | 3.81 | 3.05 | 4.57 | 0.150 | 0.120 | 0.180 |
| b | 0.46 | 0.38 | 0.56 | 0.018 | 0.015 | 0.022 |
| b2 | 1.02 | 0.89 | 1.14 | 0.040 | 0.035 | 0.045 |
| c | 0.25 | 0.23 | 0.38 | 0.010 | 0.009 | 0.015 |
| D | 36.83 | 36.58 | 37.08 | 1.450 | 1.440 | 1.460 |
| e | 1.78 | -- | -- | 0.070 | -- | -- |
| E | | 15.24 | 16.00 | | 0.600 | 0.630 |
| E1 | 13.72 | 12.70 | 14.48 | 0.540 | 0.500 | 0.570 |
| eA | 15.24 | -- | -- | 0.600 | -- | -- |
| eB | | | 18.54 | | | 0.730 |
| L | 3.30 | 2.54 | 3.56 | 0.130 | 0.100 | 0.140 |
| S | 0.64 | | | 0.025 | | |
| N | | 42 | | | 42 | |

---

## Revision History

| Date | Revision Details |
|------|-----------------|
| July 1999 | First Issue |
| 02/24/00 | Programming Time changed; Programming Flowchart changed (Figure 8); Presto III Programming Algorithm paragraph changed |
| 04/04/00 | -40 to 85 deg C and -40 to 125 deg C temperature ranges added (Table 7, 8 and 12); 80 ns speed class in High Speed AC measurement conditions |
| 09/20/00 | AN620 Reference removed |
| 11/29/00 | Note changed (Figure 7) |
| 02/27/01 | SDIP42 Package added (Figure 11, Table 16) |

---

*Copyright 2001 STMicroelectronics - All Rights Reserved*

*Information furnished is believed to be accurate and reliable. However, STMicroelectronics assumes no responsibility for the consequences of use of such information nor for any infringement of patents or other rights of third parties which may result from its use. No license is granted by implication or otherwise under any patent or patent rights of STMicroelectronics. Specifications mentioned in this publication are subject to change without notice. This publication supersedes and replaces all information previously supplied. STMicroelectronics products are not authorized for use as critical components in life support devices or systems without express written approval of STMicroelectronics.*

*www.st.com*
