# Sega 32X Technical Information

**Document Number:** MAR-41-R8-090694

**CONFIDENTIAL - PROPERTY OF SEGA**

© 1994 SEGA. All Rights Reserved.

---

## Hardware Modifications

### 1. Mega Drive 32 Mbit SRAM Board Modifications

The following modifications are necessary when a Mega Drive 32 Mbit SRAM board is used with the 32X:

**Cut Method:**
- Refer to original documentation for specific trace cuts and jumper wire placements

### 2. Mega Drive 16 Mbit SRAM Board Modifications

The following modifications are necessary when a Mega Drive 16 Mbit SRAM board is used with the 32X:

**Work Procedure:**

1. Lift no. 1 pins of U31 and U32
   - Similarly, lift no. 13, 14, and 15 pins of U33
2. Jump the no. 16 pin of U30 and the no. 13 and 14 pins of U33
3. Connect the no. 15 pin of U33 to the GND (no. 8 pin)
4. Jump the no. 9 pin of U33 to each no. 1 pin of U31 and U32

**Important:** Operation cannot be guaranteed if U31 and U32 are not AC or ALS type. If equipped with the LS type, the AC or ALS type should be attached, replacing the LS type.

### 3. Mega Drive 32 Mbit ROM Board Modifications

The following modifications are necessary when a Mega Drive 32 Mbit ROM board is used with the 32X:

**Work Procedure:**

1. Cut between the pattern of the IC13 no. 7 pin and the through-hole below the pin
2. Cut between the pattern of the IC14 no. 1 pin and the through-hole to the left of the pin
3. Cut the trace pattern of the IC15 no. 4 and no. 6 pins
4. Wire (connect) IC13 no. 1 pin, IC14 no. 1 pin, and IC15 no. 4 pin
5. Wire (connect) the IC15 no. 5 and no. 6 pins to B16 of the card edge

---

## Development Notes and Errata

### 4. ICE Reset Procedure

**CRITICAL:** ICE must not be reset while in the break condition.

- It should be reset while the go command is being executed
- If ICE is reset in the break condition, it will not operate when the power is turned on

### 5. Target Version Requirements

The 32X target does not operate unless:
- SH2 is cut 2.3 or greater
- OT version is 2.1 or greater

### 6. VRES and RV Bit Issue

**CRITICAL:** If doing VRES with the RV bit equal to 1, it will not restart if the power is turned off.

When using the 32X with RV=1, the normal operation of the Mega Drive can be affected after reset is applied. The corrective measure involves:
- Checking RV bit in VRES interrupt handler
- If RV=1, Master SH2 triggers watchdog reset via FRT TOCR bit 0
- Slave SH2 waits in loop for Master's watchdog reset
- 68K side must detect if adapter usage procedure was already performed

**Full sample code:** See [32x-technical-info-attachment-1.md](32x-technical-info-attachment-1.md) for complete 68K, Master SH2, and Slave SH2 corrective programs including:
- Complete vector tables for both SH2 CPUs
- Interrupt dispatch mechanism (m_int/s_int)
- FRT initialization for interrupt correction
- Boot synchronization sequence (68K ↔ Master ↔ Slave)

### 7. RV Bit and FRAM Access

- The RV bit should be equal to 1 when reading and writing to the FRAM
- Normally it is not possible to read and write when the RV bit is equal to 0
- The RV bit is irrelevant when reading and writing to the SRAM

### 8. Bank IC Initialization (8/1/94)

Development equipment is not required when using the bank IC, but initialization by software must be done due to miss operations by the sample cartridge.

**Initialization Procedure:**

After the power is turned on:

```assembly
; Bank dummy read
; Do $200000 - $3FFFFF in ROM
; Set in stop interrupt condition
; address=$C0 (routine within Vector ROM)
; Return SR to origin if required
```

**Important:** Implement corrective measures with respect to the super 16 Mbit software whether or not a bank IC is used due to the structure (design) of the commercial cartridge (not required with 16 Mbit + backup).

### 9. 68000 Interrupts During RV=1

**CRITICAL:** All 68000 interrupts must be prohibited during the period that the RV bit = 1.

### 10. SH2 Free Run Timer Initialization

Initialization of the free run timer must be done whether or not interrupt is used in coping with SH2 interrupt.

```assembly
lea     $A130F1, a1
tst.b   (a1)
moveq   #0, d0
move.w  #$2700, sr
jsr     BankSet
move.w  #$2000, sr
```

**Cross-Reference:** See [32x-hardware-manual-supplement-2.md](32x-hardware-manual-supplement-2.md) for the full SH2 interrupt bug documentation and corrective action code, including:
- FRT TOCR toggle (XOR bit 1) required in all external interrupt handlers
- Synchronization read-back before RTE
- Pipeline timing requirements (1-4 cycles depending on interrupt source)
- Complete sample interrupt handler code

### 11. MD I/F Chip Versions

**Chip Versions and Issues:**

| Chip No. | Version | Development Target | Notes |
|----------|---------|-------------------|-------|
| 315-5780 | Ver. 2.0 | Bug in PWM | Chip must be exchanged |
| 315-5818 | Ver. 2.0A | Speed is slow | - |
| 315-5818A | Ver. 2.0A | Speed is fast | - |

**Note:** 5818 and 5818A are mixed in production.

With respect to 5818, as errors seldom occur in SH2-68000 communication, please use 5818A-loaded target/product in final check.

### 12. ROM Read When RV=1

The following address data is not normally read when RV=1:

- `$001070 - $001073` (4 bytes)
- `$002070 - $002073` (4 bytes)
- `$003070 - $003073` (4 bytes)

**Total:** 12 bytes

### 13. CD VRAM Capture DMA Issue

**CRITICAL:** When a CD is used, WORD-RAM-to-VRAM-capture-DMA has a problem in the timing of data fetch, and since data becomes undefined, it cannot be used.

### 14. VDP Shift Bit Limitation

In the 32X VDP, the shift bit becomes invalid when the lower byte of the base address set in the line table is `$FE`.

**Solution:** Make sure the lower byte in the table is not `$FF` when using shift.

### 15. Z80 Access Issues (Ver 2.0A)

In the current (Aug. 15, 1994) target version 2.0A, the 68000 locks up when Z80 accesses the 68000 area. Revision is required to develop a program in which Z80 accesses the 68000 area.

**Target Version 2.0B and 2.1 Changes:**

With target version 2.0B (contains corrective measures to the above problems concerning version 2.0A), version 2.1 (scheduled for Sept. 1994), and their products, the problems above are solved but the following limitation is added:

**CRITICAL:** Writing to `$840000 - $9FFFFF` as well as the `$A15100 - $A153FF` area by the Z80 causes the 68000 to lock up.

- Therefore, in such cases do not write by the Z80 (read is okay)
- The MD work RAM and PSG can be written to

### 16. Target Version 2.1 (Sept. 1994)

Target version 2.1 performs:
- Corrective action no. 6 VRES in this document
- Z80 corrective action of no. 15
- The NMI of each CPU is collected and wired to one spot

### 17. 32X Development Board Security Release

**CRITICAL:** 32X development board starts up from 68000 side boot ROM when power is switched on.

As a result, when power is on, write against cartridge connector is not allowed.

**Solution:** To avert this, make sure to write 1 using 1 byte to `$A14100`. GENESIS OS will be released, and the normal access will be allowed.

### 18. EPROM Requirements (8/22/94)

For EPROM, please use those with access type 120 nsec or less.

Specifically, make sure the Tacc and Tce catalog values are 120 nsec (MAX) or less (this should be a condition).

**Major Makers' Model Number Examples:**

- **Toshiba 16M:**
  - 16-bit bus: TC571600D-120
  - 8-bit bus: TC574200D-120
- **NEC 4M:**
  - 8-bit bus: uPD27C4001D-120

### 19. PWM Register Access Restrictions (8/25/94)

**CRITICAL:** Only word unit-based access is allowed from SH2 to:

- PWM L ch pulse width register (`20004034H`)
- PWM R ch pulse width register (`20004036H`)
- PWM MONO pulse width register (`20004038H`)

**The byte unit-based access is prohibited.**

With respect to PWM control register and period (cycle) register, the byte unit-based access is allowed.

From the 68000, with respect to each pulse width register, the byte unit-based access is allowed by writing in order of the upper byte and the lower byte.

### 20. PWM Sound Volume Fix (8/29/94)

In target ver 2.0x development board, compared to FM sound source, PWM sound volume has become fairly small.

**Modification:**
- Change R71 and R73 from 3 KΩ to 10 KΩ

**Results:**
- The balance between FM sound source and PWM sound source is improved
- However, please note that by maximizing both sound sources, the sound after mixing becomes distorted
- After mixing, set both sound source volumes so that the sound is not distorted

**Important:** With PWM sound source, please note that because of a wider dynamic range over the FM sound source, the sound at peak time tends to get distorted when setting through an average sound volume.

**Note:** The volume products have already been modified. Some working samples have not yet been modified. The target ver 3.0 (the next development target scheduled for the end of September) has already been modified.

### 21. Target Version 3.0 Display Differences

Following target ver 3.0, the volume product uses a different encoder and filter compared with target ver 2.0x. As a result, the screen display is somewhat different.

**Features of Ver 3.0 vs Ver 2.0x:**

1. Colors are somewhat more vivid
2. Less blot (blur) in the picture

**Important:** Make the final graphics check after target ver 3.0, using volume product.

### 22. Z80 PSG Access Bank Settings (CRITICAL)

**CRITICAL:** When Z80 accesses PSG, make sure that bank settings at access time are values outside the `$000000-$3FFFFF` and `$840000-$9FFFFF` ranges.

**Technical Details:**

After Z80 accesses PSG, the MegaDrive internal circuitry bank automatically becomes `$C000xx`. However, after the Z80 access is over, the normally set bank values will be output to the 68000 side, and here, there is a period of time existing during which the signal displays access on the 68000 side will be in an active mode.

With MegaDrive, there would be no problems. However, 32X compared to 68000 has a much faster reaction, therefore, it would react to the above state, and if bank settings are in the `$000000-$3FFFFF` and `$840000-$9FFFFF` ranges, 32X will misunderstand that access to the adapter has occurred. And soon after 68000 accesses this area, the misunderstood data could be passed to 68000. In addition, depending on the address at that time, the contents of 32X registers could be damaged.

**Important:** Please note that because this phenomenon could occur at very different frequencies depending on the MegaDrive individual differences, the problem may not occur when the software is being checked.

---

## Summary of Critical Issues

### Priority 1 - System Stability

1. **Never reset ICE in break condition** (Item 4)
2. **All 68000 interrupts must be prohibited when RV=1** (Item 9)
3. **Z80 cannot write to $840000-$9FFFFF or $A15100-$A153FF** (Item 15)
4. **Z80 PSG access requires careful bank settings** (Item 22)
5. **VRES with RV=1 will prevent restart** (Item 6)

### Priority 2 - Hardware Access

1. **PWM registers must be accessed by word from SH2** (Item 19)
2. **FRAM requires RV=1 for access** (Item 7)
3. **VDP shift bit invalid when line table lower byte is $FE** (Item 14)
4. **ROM read skips 12 bytes when RV=1** (Item 12)

### Priority 3 - Development

1. **Use 120 nsec or faster EPROMs** (Item 18)
2. **Initialize bank IC via software** (Item 8)
3. **Initialize SH2 free run timer with interrupt workaround** (Item 10, Supplement 2)
4. **Use 5818A chips for final testing** (Item 11)
5. **Graphics final check on ver 3.0 or production hardware** (Item 21)

**Note:** The SH2 interrupt limitations documented in Hardware Manual Supplement 2 (MAR-32-R4-SP2-072694) require special corrective action in all external interrupt handlers. This bug was fixed in EVA chip cut 2.5 but production units used earlier silicon.

---

**Document End**
