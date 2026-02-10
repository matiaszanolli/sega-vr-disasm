# Hitachi HM65256B Series Datasheet

> **Converted from PDF**: `HM65256B_datasheet.pdf`
> **Manufacturer**: Hitachi America, Ltd.
> **Document**: 12 pages, catalog section 6

---

## Overview

**HM65256B Series** -- 32,768-word x 8-bit High Speed Pseudo Static RAM

**Supply Voltage**: 5.0 V

---

## Features

- Single 5 V (+/-10%)
- Access time
  - CE access time: 100/120/150/200 ns
  - Address access time: 50/60/75/100 ns (in static column mode)
- Cycle time
  - Random read/write cycle time: 160/190/235/310 ns
  - Static column mode cycle time: 55/65/80/105 ns
- Low power: 175 mW typ. active
- All inputs and outputs TTL compatible
- Static column mode capability
- Non-multiplexed address
- 256 refresh cycles (4 ms)
- Refresh functions
  - Address refresh
  - Automatic refresh
  - Self refresh

---

## Ordering Information

### 600-mil 28-pin Plastic DIP (DP-28)

| Type No. | Access Time |
|----------|-------------|
| HM65256BP-10 | 100 ns |
| HM65256BP-12 | 120 ns |
| HM65256BP-15 | 150 ns |
| HM65256BP-20 | 200 ns |

### 300-mil 28-pin Plastic DIP (DP-28N)

| Type No. | Access Time |
|----------|-------------|
| HM65256BLP-10 | 100 ns |
| HM65256BLP-12 | 120 ns |
| HM65256BLP-15 | 150 ns |
| HM65256BLP-20 | 200 ns |

### 300-mil 28-pin Plastic DIP (DP-28N)

| Type No. | Access Time |
|----------|-------------|
| HM65256BSP-10 | 100 ns |
| HM65256BSP-12 | 120 ns |
| HM65256BSP-15 | 150 ns |
| HM65256BSP-20 | 200 ns |

### 300-mil 28-pin Plastic DIP (DP-28N) -- "L" variants

| Type No. | Access Time |
|----------|-------------|
| HM65256BLSP-10 | 100 ns |
| HM65256BLSP-12 | 120 ns |
| HM65256BLSP-15 | 150 ns |
| HM65256BLSP-20 | 200 ns |

### 28-pin Plastic SOP (FP-28DA)

| Type No. | Access Time |
|----------|-------------|
| HM65256BFP-10T | 100 ns |
| HM65256BFP-12T | 120 ns |
| HM65256BFP-15T | 150 ns |
| HM65256BFP-20T | 200 ns |

### 28-pin Plastic SOP (FP-28DA) -- "L" variants

| Type No. | Access Time |
|----------|-------------|
| HM65256BLFP-10T | 100 ns |
| HM65256BLFP-12T | 120 ns |
| HM65256BLFP-15T | 150 ns |
| HM65256BLFP-20T | 200 ns |

---

## Pin Arrangement (28-pin DIP, Top View)

```
              +----U----+
   A14 [ 1]  |         | [28] Vcc
   A12 [ 2]  |         | [27] WE
    A7 [ 3]  |         | [26] A13
    A6 [ 4]  |         | [25] A8
    A5 [ 5]  |         | [24] A9
    A4 [ 6]  |         | [23] A11
    A3 [ 7]  |         | [22] OE
    A2 [ 8]  |         | [21] A10
    A1 [ 9]  |         | [20] CE
    A0 [10]  |         | [19] I/O7
  I/O0 [11]  |         | [18] I/O6
  I/O1 [12]  |         | [17] I/O5
  I/O2 [13]  |         | [16] I/O4
   Vss [14]  |         | [15] I/O3
              +---------+
```

### Pin Functions

| Pin | Name | Function |
|-----|------|----------|
| 1 | A14 | Address input |
| 2 | A12 | Address input |
| 3 | A7 | Address input |
| 4 | A6 | Address input |
| 5 | A5 | Address input |
| 6 | A4 | Address input |
| 7 | A3 | Address input |
| 8 | A2 | Address input |
| 9 | A1 | Address input |
| 10 | A0 | Address input |
| 11 | I/O0 | Data input/output |
| 12 | I/O1 | Data input/output |
| 13 | I/O2 | Data input/output |
| 14 | Vss | Ground |
| 15 | I/O3 | Data input/output |
| 16 | I/O4 | Data input/output |
| 17 | I/O5 | Data input/output |
| 18 | I/O6 | Data input/output |
| 19 | I/O7 | Data input/output |
| 20 | CE (active low) | Chip Enable |
| 21 | A10 | Address input |
| 22 | OE (active low) | Output Enable |
| 23 | A11 | Address input |
| 24 | A9 | Address input |
| 25 | A8 | Address input |
| 26 | A13 | Address input |
| 27 | WE (active low) | Write Enable |
| 28 | Vcc | Power supply |

---

## Block Diagram

The internal architecture consists of:

- **Address latch/control** (A0-A7): Latches row addresses
- **Row decoder**: Decodes row address to select memory rows
- **Memory matrix**: 256 x 128 x 8 organization
- **Column decoder** (A8-A14): Decodes column address for column I/O
- **Input data control** (I/O1-I/O8): Controls data flow for read/write
- **Column I/O**: Interface between column decoder and memory matrix
- **Refresh control**: Manages internal refresh counters
- **Timing pulse generator**: Generates internal timing from CE
- **Read/write control**: Controlled by OE and WE signals

---

## Truth Table

| CE (active low) | OE (active low) | WE (active low) | I/O Pin | Mode |
|:---:|:---:|:---:|:---:|:---:|
| L | L | H | Low Z | Read |
| L | X | L | High Z | Write |
| L | H | H | High Z | -- |
| H | L | X | High Z | Refresh |
| H | H | X | High Z | Standby |

---

## Absolute Maximum Ratings

| Parameter | Symbol | Rating | Unit |
|-----------|--------|--------|------|
| Terminal voltage with respect to Vss | V_T | -1.0 to +7.0 | V |
| Power dissipation | P_T | 1.0 | W |
| Operating temperature | Topr | 0 to +70 | deg C |
| Storage temperature | Tstg | -55 to +125 | deg C |
| Storage temperature under bias | Tbias | -10 to +85 | deg C |

---

## Recommended DC Operating Conditions (Ta = 0 to +70 deg C)

| Parameter | Symbol | Min | Typ | Max | Unit |
|-----------|--------|-----|-----|-----|------|
| Supply voltage | Vcc | 4.5 | 5.0 | 5.5 | V |
| | Vss | 0 | 0 | 0 | V |
| Input voltage (high) | V_IH | 2.2 | -- | 6.0 | V |
| Input voltage (low) | V_IL | -0.5* | -- | 0.8 | V |

*Note: V_IL min = -3.0 V for pulse width <= 10 ns.*

---

## DC Characteristics (Ta = 0 to +70 deg C, Vcc = 5 V +/- 10%)

| Parameter | Symbol | HM65256B | | | HM65256BL | | | Unit | Test Conditions |
|-----------|--------|-----|-----|-----|-----|-----|-----|------|----------------|
| | | Min | Typ | Max | Min | Typ | Max | | |
| Operating power supply current | I_CC1 | -- | 35 | 65 | -- | 35 | 65 | mA | I_I/O = 0 mA, tcyc = min |
| Standby power supply current | I_SB1 | -- | 1 | 2 | -- | 1 | 2 | mA | CE = V_IH, OE = V_IH, Vin >= 0 V |
| | I_SB2 | -- | -- | -- | -- | 0.05 | 0.1 | mA | CE > Vcc - 0.2 V, OE >= Vcc - 0.2, Vin >= 0 |
| Operating power supply current in self refresh mode | I_CC2 | -- | 1 | 2 | -- | 0.6 | 1 | mA | CE = V_IH, OE = V_IL, Vin >= 0 V |
| | I_CC3 | -- | -- | -- | -- | 50 | 100 | uA | CE >= Vcc - 0.2 V, OE <= 0.2 V, Vin >= 0 V |
| Input leakage current | I_I | -10 | -- | 10 | -10 | -- | 10 | uA | Vcc = 5.5 V, Vin = Vss to Vcc |
| Output leakage current | I_O | -10 | -- | 10 | -10 | -- | 10 | uA | OE = V_IH, V_I/O = Vss to Vcc |
| Output voltage (low) | V_OL | -- | -- | 0.4 | -- | -- | 0.4 | V | I_OL = 2.1 mA |
| Output voltage (high) | V_OH | 2.4 | -- | 2.4 | -- | -- | -- | V | I_OH = -1 mA |

---

## Capacitance

| Parameter | Symbol | Typ | Max | Unit | Test Conditions |
|-----------|--------|-----|-----|------|----------------|
| Input capacitance | Cin | -- | 5 | pF | Vin = 0 V |
| Input/output capacitance | C_I/O | -- | 7 | pF | V_I/O = 0 V |

*Note: These parameters are sampled and not 100% tested.*

---

## AC Characteristics (Ta = 0 to +70 deg C, Vcc = 5 V +/- 10%)

### AC Test Conditions

- Input pulse levels: 2.4 V, 0.4 V
- Input rise and fall times: 5 ns
- Timing measurement level: 2.2 V, 0.8 V
- Reference level: V_OH = 2.0 V, V_OL = 0.8 V
- Output load: 1 TTL and 100 pF (including scope and jig)

### Timing Parameters

| Parameter | Symbol | -10 | | -12 | | -15 | | -20 | | Unit |
|-----------|--------|-----|-----|-----|-----|-----|-----|-----|-----|------|
| | | Min | Max | Min | Max | Min | Max | Min | Max | |
| Random read or write cycle time | t_RC | 160 | -- | 190 | -- | 235 | -- | 310 | -- | ns |
| Static column mode read or write cycle | t_RSC | 55 | -- | 65 | -- | 80 | -- | 105 | -- | ns |
| Chip enable access time | t_CEA | -- | 100 | -- | 120 | -- | 150 | -- | 200 | ns |
| Address access time | t_AA | -- | 50 | -- | 60 | -- | 75 | -- | 100 | ns |
| Output enable access time | t_OEA | -- | 40 | -- | 50 | -- | 60 | -- | 75 | ns |
| Chip disable to output in high Z | t_CHZ | -- | 25 | -- | 25 | -- | 30 | -- | 35 | ns |
| Chip enable to output in low Z | t_CLZ | 30 | -- | 30 | -- | 35 | -- | 40 | -- | ns |
| Output enable to output in low Z | t_OLZ | 10 | -- | 10 | -- | 10 | -- | 10 | -- | ns |
| Output disable to output in high Z | t_OHZ | -- | 25 | -- | 25 | -- | 30 | -- | 35 | ns |
| Chip enable pulse width | t_CE | 100 ns | 4 ms | 120 ns | 4 ms | 150 ns | 4 ms | 200 ns | 4 ms | |
| Chip enable precharge time | t_P | 50 | -- | 60 | -- | 75 | -- | 100 | -- | ns |
| Address set-up time | t_AS | 0 | -- | 0 | -- | 0 | -- | 0 | -- | ns |
| Row address hold time | t_RAH | 20 | -- | 20 | -- | 25 | -- | 30 | -- | ns |
| Column address hold time | t_CAH | 100 | -- | 120 | -- | 150 | -- | 200 | -- | ns |
| Read command set-up time | t_RCS | 0 | -- | 0 | -- | 0 | -- | 0 | -- | ns |
| Read command hold time | t_RCH | 0 | -- | 0 | -- | 0 | -- | 0 | -- | ns |
| Output enable hold time | t_OHC | 0 | -- | 0 | -- | 0 | -- | 0 | -- | ns |
| Output enable to chip enable delay time | t_OCD | 0 | -- | 0 | -- | 0 | -- | 0 | -- | ns |
| Output hold time from column address | t_OH | 5 | -- | 5 | -- | 5 | -- | 10 | -- | ns |
| Write command pulse width | t_WP | 25 | -- | 25 | -- | 30 | -- | 35 | -- | ns |
| Chip enable to end of write | t_CW | 100 | -- | 120 | -- | 150 | -- | 200 | -- | ns |

### Additional AC Timing Parameters

| Parameter | Symbol | -10 | | -12 | | -15 | | -20 | | Unit |
|-----------|--------|-----|-----|-----|-----|-----|-----|-----|-----|------|
| | | Min | Max | Min | Max | Min | Max | Min | Max | |
| Column address set-up time (write) | t_ASW | 0 | -- | 0 | -- | 0 | -- | 0 | -- | ns |
| Column address hold time after write | t_AHW | 0 | -- | 0 | -- | 0 | -- | 0 | -- | ns |
| Data valid to end of write | t_DW | 20 | -- | 20 | -- | 25 | -- | 30 | -- | ns |
| Data in hold time for write | t_DH | 0 | -- | 0 | -- | 0 | -- | 0 | -- | ns |
| Output active from end of write | t_OW | 5 | -- | 5 | -- | 5 | -- | 5 | -- | ns |
| Write to output in high Z | t_WHZ | -- | 25 | -- | 25 | -- | 30 | -- | 35 | ns |
| Transition time (rise and fall) | t_T | 3 | 50 | 3 | 50 | 3 | 50 | 3 | 50 | ns |
| Refresh command delay time | t_RFD | 50 | -- | 60 | -- | 75 | -- | 100 | -- | ns |
| Refresh precharge time | t_FP | 30 | -- | 30 | -- | 30 | -- | 30 | -- | ns |
| Refresh command pulse width (auto) | t_FAP | 80 | 10000 | 80 | 10000 | 80 | 10000 | 80 | 10000 | ns |
| Automatic refresh cycle time | t_FC | 160 | -- | 190 | -- | 235 | -- | 310 | -- | ns |
| Refresh command pulse width (self) | t_FAS | 10000 | -- | 10000 | -- | 10000 | -- | 10000 | -- | ns |
| Refresh reset time for self refresh | t_FRS | 160 | -- | 190 | -- | 235 | -- | 310 | -- | ns |
| Refresh period | t_REF | -- | 4 | -- | 4 | -- | 4 | -- | 4 | ms |

### AC Characteristics Notes

1. t_CHZ, t_OHZ, and t_WHZ are defined as the time at which the output achieves the open circuit conditions.
2. t_CLZ, t_OLZ and t_OW are sampled under the condition of t_T = 5 ns, and not 100% tested.
3. A write occurs during the overlap of a low CE and low WE.
4. If CE goes low simultaneously with WE going low or after WE going low, the outputs remain in high impedance state.
5. If input signals of opposite phase to the outputs are applied in a write cycle, OE or WE must disable output buffers prior to applying data to the device and data inputs must be floating prior to OE or WE turning on output buffers.
6. V_IH (min.) and V_IL (max.) are reference levels for measuring timing of input signals. Also, transition times are measured between V_IH and V_IL.
7. An initial pause of 100 us is required after power-up followed by a minimum of 8 initialization cycles.
8. At the end of self refresh, refresh reset time (t_FRS) is required to reset the internal self refresh operation of the RAM. During t_FRS, CE and OE must be kept high. If auto refresh follows self refresh, low transition of OE at the beginning of auto refresh must not occur during t_FRS period.

---

## Timing Waveform Descriptions

### Read Cycle (1) -- CE Controlled

In this mode, CE controls the read cycle. The sequence is:
1. Address lines (A0-A7 for row, A8-A14 for column) are set up before or simultaneously with CE going low
2. WE remains high (read mode)
3. OE is held low to enable outputs
4. Data appears on outputs after t_CEA from CE going low
5. Row address must be held for t_RAH, column address held for t_CAH
6. After CE goes high, outputs go to high-Z within t_CHZ
7. Precharge time t_P must elapse before next CE low

### Read Cycle (2) -- OE Controlled

Similar to Read Cycle (1), but OE controls output timing:
1. CE goes low first, enabling the chip
2. Address is latched
3. OE going low enables the output drivers
4. Data appears after t_OEA from OE going low
5. Output transitions from high-Z to low-Z within t_OLZ of OE falling
6. When OE goes high, outputs return to high-Z within t_OHZ

### Write Cycle (1) -- OE Clock

OE is used as a clock to gate write data:
1. CE goes low with address stable
2. WE goes low to enable write mode
3. OE is held high during write (data driven by external source)
4. Data must be valid for t_DW before end of write
5. Data must be held for t_DH after end of write
6. When write completes (WE or CE going high), outputs transition from data-in to high-Z

### Write Cycle (2) -- OE Fixed Low

OE is held low throughout the write cycle:
1. CE goes low with address stable
2. WE goes low to start write
3. OE remains low (outputs briefly show old read data, then transition)
4. Data must be valid for t_DW before end of write
5. After WE goes high, output data appears within t_OW

### Static Column Mode Read Cycle

Allows fast sequential reads within a row:
1. CE goes low, latching row address (A0-A7)
2. Column address (A8-A14) can be changed while CE remains low
3. New data appears after t_AA from column address change
4. Each column access takes only t_RSC (55-105 ns depending on speed grade)
5. Multiple valid data outputs shown for successive column addresses

### Static Column Mode Write Cycle

Similar to static column mode read but for writes:
1. CE goes low, latching row address
2. WE goes low to enable writes
3. Column address can be changed for successive writes within the same row
4. Data must be valid for t_DW before each write pulse ends
5. Each column write cycle takes t_RSC

### Automatic Refresh Cycle

External logic triggers periodic refreshes:
1. After normal access, CE goes high for at least t_RFD (refresh command delay)
2. CE pulses low for t_FAP (refresh command pulse width: 80-10000 ns)
3. OE must be held low during refresh
4. Precharge time t_FP required between refresh pulses
5. Cycle repeats; all 256 rows must be refreshed within t_REF (4 ms)

### Self Refresh Cycle

The device internally generates refresh addresses:
1. After normal access, CE goes high for at least t_RFD
2. OE goes low to initiate self refresh
3. CE goes low for at least t_FAS (10000 ns min)
4. Internal refresh counter automatically cycles through all rows
5. At completion, t_FRS (refresh reset time) is required with CE and OE high

---

*Hitachi America, Ltd. -- Hitachi Plaza, 2000 Sierra Point Pkwy., Brisbane, CA 94005-1819*
