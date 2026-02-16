# 32X System Registers Reference

**Date:** 2026-02-05
**Source:** 32X Hardware Manual Section 1.5

## Overview

Complete reference for 32X system registers accessed by both MEGA Drive (68000) and SH2 processors. Registers control adapter configuration, interrupts, DMA, communication, PWM audio, and VDP access.

---

## MEGA Drive Side Registers

### Adapter Control Register
**Address:** `A1 5100h` (Byte/Word Access)

| Bit | 15-8 | 7 | 6-2 | 1 | 0 |
|-----|------|---|-----|---|---|
| Mode | R/W | Read only | - | R/W | R/W |
| Name | FM | REN | - | RES | ADEN |

**FM** - VDP Access Authorization
- `0`: MD (68000) has VDP access (initial value)
- `1`: SH2 has VDP access

⚠️ **CRITICAL:** Switching access authorization occurs **immediately** when writing to FM bit. If the 68K writes to FM while SH2 is accessing VDP, access is **forced** to switch to MEGA Drive, potentially corrupting ongoing VDP operations.

**REN** - SH2 Reset Enable
- `0`: Disable
- `1`: Enable

**RES** - Resets SH2
- `0`: Reset
- `1`: Cancel reset (initialization by initial program - change not allowed)

**ADEN** - Adapter Enable Bit
- `0`: Prohibits use of 32X
- `1`: Permits use of 32X (initialization by initial program - change not allowed)

---

### Interrupt Control Register
**Address:** `A1 5102h` (Byte/Word Access)

| Bit | 15-2 | 1 | 0 |
|-----|------|---|---|
| Mode | - | R/W | R/W |
| Name | - | INTS | INTM |

**INTS** - Slave SH2 Interrupt Command
- `0`: NO OPERATION (initial value)
- `1`: Interrupt command

**INTM** - Master SH2 Interrupt Command
- `0`: NO OPERATION (initial value)
- `1`: Interrupt command

Both are automatically cleared if SH2 does not interrupt clear.

---

### Bank Set Register
**Address:** `A1 5104h` (Byte/Word Access)

| Bit | 15-2 | 1 | 0 |
|-----|------|---|---|
| Mode | - | R/W | R/W |
| Name | - | BK1 | BK0 |

Controls ROM cartridge bank switching (256KB window):

| BK1 | BK0 | ROM Range |
|-----|-----|-----------|
| 0 | 0 | `00 0000h – 0F FFFFh` (initial value) |
| 0 | 1 | `10 0000h – 1F FFFFh` |
| 1 | 0 | `20 0000h – 2F FFFFh` |
| 1 | 1 | `30 0000h – 3F FFFFh` |

---

### DMAC Transfer Control Register
**Address:** `A1 5106h` (Byte/Word Access)

| Bit | 15-8 | 7 | 6-3 | 2 | 1 | 0 |
|-----|------|---|-----|---|---|---|
| Mode | - | Read only | - | R/W | R/W | R/W |
| Name | - | FULL | - | 68S | 0 | RV |

**FULL** - DMA FIFO Full
- `0`: Can write
- `1`: Cannot write

**RV** - ROM to VRAM DMA
- `0`: NO OPERATION (initial value)
- `1`: DMA Start Allowed

⚠️ **CRITICAL - ROM ACCESS BLOCKING:**
> "The SH2 side cannot access the ROM when RV = 1 (when doing ROM to VRAM DMA, be sure that RV = 1). Waits until value becomes 0 (RV = 0) before accessing."

**Impact:** When 68K sets RV=1 for ROM→VRAM DMA:
- **ALL SH2 ROM access BLOCKS** including:
  - Main ROM: `0x02000000-0x022FFFFF`
  - **Expansion ROM: `0x02300000-0x023FFFFF`**
- SH2 CPUs stall until RV returns to 0

**VRD Status (B-008, 2026-02-16):** VRD never sets RV=1. The game uses CPU Write mode (`#$04` = 68S) for all DREQ transfers, never ROM-to-VRAM DMA. Expansion ROM is safe for SH2 execution at all times.

**68S** - DMA Mode
- `0`: No Operation
- `1`: CPU Write (68K writes data in FIFO)

> **Note on bit layout:** The hardware manual (§3.2) shows a compact layout `{FULL=bit2, RV=bit1, 68S=bit0}`, but VRD's actual register access confirms the layout above: `move.b #$04,$A15107` sets 68S (bit 2), `btst #7,$A15107` tests FULL (bit 7). This matches the expanded layout in this table. The hardware manual's compact table appears to show logical field ordering, not physical bit positions.

The internal system starts operation when 68S is 1. Writing 0 force-ends the operation. It is automatically set to 0 after DMA ends.

**68K to SH DREQ Source Address Register:** `A1 5108h` / `A1 510Ah` (High/Low Order)
*Note: Because DREQ circuit does not use this data, nothing needs to be set at the time of CPU WRITE.*

---

### SEGA TV Register
**Address:** `A1 511Ah` (Byte/Word Access)

| Bit | 15-1 | 0 |
|-----|------|---|
| Mode | - | R/W |
| Name | - | CM |

**CM** - Cartridge Mode
- `0`: ROM (initial value)
- `1`: DRAM

*This is a SEGA TV exclusive register, use of this bit with other application is prohibited.*

---

### Communication Port
**Addresses:** `A1 5120h` - `A1 512Eh` (8 words, Byte/Word Access)

8-word bi-directional communication register accessible from both MEGA Drive and SH2.

⚠️ **RACE CONDITION WARNING:**
> "Read/write is possible from the MEGA Drive and SH2 directions, but when writing the same register from both at the same time, the value of that register becomes undefined. Caution is advised."

**VRD Usage:**
- **COMM7** (`$2000402E`): Master→Slave command signal
- **COMM5** (`$2000402A`): Vertex transform counter

**Best Practice:** Use separate COMM slots for Master→Slave vs Slave→Master to avoid simultaneous writes.

---

### PWM Control Register
**Address:** `A1 5130h` (Byte/Word Access)

| Bit | 15-12 | 11-8 | 7 | 6-3 | 2-1 | 0 |
|-----|-------|------|---|-----|-----|---|
| Mode | Read only | Read only | R/W | - | R/W | R/W |
| Name | TM3-TM0 | RTP | - | RMD1-RMD0 | LMD1-LMD0 |

**TM3-0** - PWM timer interrupt interval (read only)
**RTP** - DREQ 1 occurrence enable (SH2 side only)
- `0`: OFF (initial value)
- `1`: ON

**RMD1/RMD0** - Right channel output
- `00`: OFF
- `01`: R
- `10`: L
- `11`: Setting not allowed

**LMD1/LMD0** - Left channel output
- `00`: OFF
- `01`: L
- `10`: R
- `11`: Setting not allowed

*Both cannot be set to L ch or R ch.*

---

### Cycle Register
**Address:** `A1 5132h` (Byte/Word Access, R/W)

The base clock frequency of the cycle registers are fixed respectively:
- **NTSC:** 23.01 MHz
- **PAL:** 22.8 MHz

Formula: `NTSC Scyc = 1/23.01 [MHz]` | `PAL Scyc = 1/22.8 [MHz]`

The cycle counter does not operate when both L ch and R ch are off.

---

### Pulse Width Registers

**L ch Pulse Width Register:** `A1 5134h` (Byte/Word)
**R ch Pulse Width Register:** `A1 5136h` (Byte/Word)
**Mono Pulse Width Register:** `A1 5138h` (Byte/Word)

| Bit | 15-14 | 13-12 | 11-0 |
|-----|-------|-------|------|
| Mode | Read only | Read only | Write only |
| Name | FULL | EMPTY | Pulse Width Value |

**FULL** - Pulse Width FIFO Conditions
- `0`: Space available
- `1`: No space available

**EMPTY** - Pulse Width FIFO Conditions
- `0`: Data per FIFO
- `1`: No data per FIFO

The value set by bit 11-0 × Scyc becomes the pulse width.

**Important FIFO Behavior:**
> "Bits D0~D11 of all L ch, R ch and MONO pulse width registers are write only. When read is performed, undefined data is read. Each PWM of L ch and R ch have time separate FIFO steps. When both the L and R channels are off, because the cycle counter does not operate, once the FULL bit is set to i1i, it will not become i0i as long as the channels are not turned on. When either the L of R channel is on, because the OFF side FIFO is also operating, no sound will be output; however, data within FIFO will disappear. If writing when FIFO is FULL, the oldest data is discarded and shift occurs one item at a time."

---

## SH2 Side Registers

### Interrupt Mask Register
**Address:** `2000 4000h` (Byte/Word Access)

| Bit | 15 | 14-9 | 8 | 7 | 6-4 | 3 | 2 | 1 | 0 |
|-----|----|----- |---|---|-----|---|---|---|---|
| Mode | R/W | Read only | R/W | Read only | - | R/W | R/W | R/W | R/W |
| Name | FM | - | ADEN | CART | HEN | - | V | H | CMD | PWM |

**FM** - VDP Access Authorization
- `0`: MEGA DRIVE (initial value)
- `1`: SH2

⚠️ **CRITICAL - VDP ACCESS PREEMPTION:**
> "Please note carefully that if a i11 is written to the FM bit, access authorisation is forced to switch to the SH2 side, even if access of VDP is in progress in the MEGA Drive side."

**ADEN** - Adapter Enable Bit
- `0`: The 32x use prohibited
- `1`: The 32X use allowed

**CART** - Cartridge Insert Condition
- `0`: Inserted
- `1`: Not inserted

**HEN** - H INT Approval Within V Blank
- `0`: H INT not approved (initial value)
- `1`: H INT approved

**V** - V INT Mask
- `0`: Mask (initial value)
- `1`: Valid

**H** - H INT Mask
- `0`: Mask (initial value)
- `1`: Valid

**CMD** - Command Interrupt Mask
- `0`: Mask (initial value)
- `1`: Valid

**PWM** - PWM Timer Interrupt Mask
- `0`: Mask (initial value)
- `1`: Valid

**Important:** This register is mapped to the same address for both SH2 master side and slave side. But V, H, CMD and PWM each possesses exclusive address on the master side and the slave side. Other bits are common to both the master and slave sides.

---

### H Count Register
**Address:** `2000 4004h` (Byte/Word Access, R/W)

Sets H interrupt occurrence interval. Designates by the number of lines. `0 = each line` (initial value).

---

### VRES Interrupt Clear Register
**Address:** `2000 4014h` (Word Access, Write only)

Clears VRES interrupt (interrupt caused by pressing the MEGA Drive reset button). If not cleared, interrupt will no longer occur.

---

### V Interrupt Clear Register
**Address:** `2000 4016h` (Word Access, Write only)

Clears V interrupt. If not cleared, interrupt will no longer occur.

---

### H Interrupt Clear Register
**Address:** `2000 4018h` (Word Access, Write only)

Clears H interrupt. If not cleared, interrupt will no longer occur.

---

### CMD Interrupt Clear Register
**Address:** `2000 401Ah` (Word Access, Write only)

Clears CMD interrupt (command interrupt). If not cleared, interrupt will no longer occur.

---

### PWM Interrupt Clear Register
**Address:** `2000 401Ch` (Word Access, Write only)

Clears PWM interrupt (command interrupt). If not cleared, interrupt will no longer occur.

---

## Interrupt Behavior Details

### Interrupt Masking vs Clearing

**Important Distinction:**
- **Masking** (via Interrupt Mask Register bits): Prevents interrupt from firing, but doesn't clear the pending condition
- **Clearing** (via Interrupt Clear Registers): Removes the interrupt condition entirely

### CMDINT vs Other Interrupts

32X has VRESINT, VINT, HINT, CMDINT, and PWMINT, but **CMDINT behaves differently**:

**VRES, VINT, HINT, PWMINT:**
- INT continues to occur until each INT is cleared (via clear register)
- Interrupt condition **persists** even when masked
- If INT occurs before being masked, condition remains saved until cleared
- When unmasked, interrupt fires immediately if condition still pending

**CMDINT (Command Interrupt):**
- INT is **negated** when masked
- When CMDINT is enabled after CMDINT is not received, CMDINT is **again asserted**
- Interrupt condition saved as long as not cleared, but temporarily disappears when masked
- Effectively acts as level-triggered with mask-sensitive behavior

**From Hardware Manual:**
> "when all INT occur before they are masked, the INT conditions will continue to be saved as long as that INT is not cleared. But when Interrupt is masked only for CMDINT, INT will temporarily disappear. Still, because CMDINT information will be saved as long as it is not cleared, INT will again occur if CMDINT is enabled."

### HEN Bit and H Count Register Timing

**HEN** (H INT approval within V Blank) is common to both Master and Slave SH2. The HINT occurrence interval is affected by this HEN bit.

**H Count Register Loading Behavior:**
- H Count value loaded into **internal counter** when H Blank is **negated** (ends)
- Internal counter generates HINT as result of count
- When H Blank is negated, H Count register value is **reloaded**
- If H Count register is set when H Blank **does not occur** (because not loaded until next H Blank), HINT may occur according to value **prior to setting**

**Example 1:**
When `H Count register = 0`, value `1` is set in H Count register during H Bank. When `HEN = 0`, HINT occurs within the **second H Blank** after existing H Blank is negated.

**Example 2:**
When `H Count register = 0` and H Count is set to `1` when H Blank **does not occur**. When `HEN = 0`, HINT occurs during the **next H Blank**. HINT occurs during the **2nd H Blank** after the H Blank is negated because the H Count register setting (value) is loaded in the internal counter when this H Blank is negated.

**Implication:** Changing H Count register has **delayed effect** - new value takes effect at next H Blank negation, not immediately.

---

## Critical Behaviors Summary

### 1. RV Bit ROM Blocking
When 68K sets RV=1 for ROM→VRAM DMA, **all SH2 ROM access blocks** including expansion ROM at `$02300000`. SH2 CPUs stall until RV=0.

**Implications:**
- Expansion code execution timing affected during DMA
- Need to profile if VRD uses ROM→VRAM DMA during gameplay
- May need to copy critical code to SDRAM instead of executing from ROM

### 2. FM Bit Preemption
Writing FM=1 **immediately preempts** any ongoing 68K VDP access. Can corrupt mid-transfer VRAM/CRAM/VSRAM writes if not synchronized.

**Best Practice:** Only switch FM during V-Blank when VDP is idle.

### 3. Communication Port Race Conditions
Simultaneous writes to same COMM register from both 68K and SH2 result in **undefined value**.

**Best Practice:**
- Use separate COMM slots for each direction
- VRD uses COMM7 (Master→Slave) and COMM5 (counter) - verify no overlaps

### 4. Edge-Triggered Interrupts
All interrupts (V, H, CMD, PWM, VRES) require **explicit clearing** via interrupt clear registers. If not cleared, interrupt will not occur again (not level-triggered).

### 5. PWM FIFO Behavior
- 4-step FIFO for pulse width values
- Writing when FULL discards oldest data and shifts queue
- FULL bit stays set when both L/R channels off (cycle counter stops)

### 6. Frame Buffer Swap Timing (VDP)
Writing FS bit to swap frame buffers is **always allowed**, but actual swap occurs **only during V-Blank**.

**Synchronization Required:**
- If written during display, swap delayed until next V Blank
- Read FS value shows buffer currently displayed (not pending swap)
- **Must confirm** `VBLK = 1` or FS bit changed before accessing swapped frame buffer

**Implication:** Double-buffering requires V-Blank synchronization to avoid tearing or accessing wrong buffer.

### 7. Palette Access Timing (VDP)
**Palette access possible only during H-Blank and V-Blank** (or when in direct color mode).

**From Hardware Manual:**
> "Palette access is possible only during H and V blank."

**Exception:** In direct color bitmap mode, palette accessible at any time.

**Implication:** VRD must synchronize palette updates to blanking periods to avoid corruption, unless using direct color mode.

---

## VDP (Video Display Processor) Registers

### VDP Address Mapping

**SH2 Side:**
- **VDP Registers:** `2000 4100h` - Cache-through only (I/O device)
- **DRAM (Frame Buffer):** `2400 0000h` - Cache-through
- **Over Write Image:** `2402 0000h` - Cache-through
- **Color Palette:** `2000 4200h` and `2404 0000h` - Cache-through

⚠️ **CRITICAL:** VDP exists as I/O device for CPU. **Accessing without the color palette is only a cache-through address.** Never use cached addresses for VDP access.

---

### Frame Buffer Control Register
**Address:** `A1 518Ah` (MD side) / `2000 410Ah` (SH2 side, Byte/Word Access)

| Bit | 15 | 14 | 13 | 12-2 | 1 | 0 |
|-----|----|----|----|----- |---|---|
| Mode | Read only | Read only | Read only | - | R/W | R/W |
| Name | VBLK | HBLK | PEN | - | FEN | FS |

**VBLK** - V Blank Status
- `0`: During display period
- `1`: During V Blank

**HBLK** - H Blank Status
- `0`: During display period
- `1`: During H Blank

**PEN** - Palette Access Approval
- `0`: Access denied
- `1`: Access approved

⚠️ **PALETTE ACCESS RESTRICTION:**
> "Palette access is possible **only during H and V blank**."

**Exception:** Palette can access whenever bitmap mode is in direct color mode, as well as during Blank.

**FEN** - Frame Buffer Authorization
- `0`: Access approved
- `1`: Access denied

**After Fill Operation:** Be sure to access Frame Buffer after confirming that `FEN = 0`.

**FS** - Frame Buffer Swap
- `0`: Transfers DRAM0 to VDP side (initial value)
- `1`: Transfers DRAM1 to VDP side

⚠️ **FRAME BUFFER SWAP TIMING:**
> "Swapping the Frame Buffer is allowed during V Blank (VBLK = 1) or when in the blank mode. However, **writing the FS bit is always allowed**, and when written during display, **swapping is done at the next V Blank**."

**Critical Synchronization:**
- Frame buffer can be switched **only in VBlank**
- Writing FS during display delays swap until next V Blank
- Read FS value indicates buffer selected on current display (until next V Blank)
- **After swapping:** Access Frame Buffer only after confirming `VBLK = 1` or FS bit has changed

---

### Screen Shift Control Register
**Address:** `A1 5182h` (MD side) / `2000 4102h` (SH2 side, Byte/Word Access)

| Bit | 15-1 | 0 |
|-----|------|---|
| Mode | - | R/W |
| Name | - | SFT |

**SFT** - Screen 1 Dot Left Shift
- `0`: OFF
- `1`: ON

Switching is allowed at any time, but is valid from the next line.

---

### Auto Fill Length Register
**Address:** `A1 5184h` (MD side) / `2000 4104h` (SH2 side, Byte/Word Access)

| Bit | 15-8 | 7-0 |
|-----|------|-----|
| Mode | - | R/W |

Word length when filling DRAM (frame buffer). To set this value, set the value for the to-be-filled word length (0-255).

---

### Auto Fill Start Address Register
**Address:** `A1 5186h` (MD side) / `2000 4106h` (SH2 side, Word Access)

| Bit | 15-8 | 7-0 |
|-----|------|-----|
| Mode | R/W | R/W |
| Name | A16-A9 | A8-A1 |

Sets the start address of the area to be filled. **A16-A9 remains as fixed**, but **A8-A1 are incremented at each Fill**.

---

### Auto Fill Data Register
**Address:** `A1 5188h` (MD side) / `2000 4108h` (SH2 side, Word Access)

| Bit | 15-8 | 7-0 |
|-----|------|-----|
| Mode | R/W | R/W |

Sets data to be filled. **The Fill operation begins when setting this register.**

After fill completes, confirm `FEN = 0` in Frame Buffer Control Register before accessing frame buffer.

---

### Display Mode Combinations

32X supports NTSC (Japan, USA) and PAL (Western Europe) formats:

| 32X Mode | MD Mode Required |
|----------|------------------|
| Non-blank 320×224 pixels | Graphic V - 40×28 cells (320×224 pixels) |
| Non-blank 320×240 pixels | Graphic V - 40×30 cells (320×240 pixels) |
| Blank | Graphics IV - 32×28 (256×192 pixels) |
| Blank | Graphics V - 32×28 cells (256×224 pixels) |
| Blank | Graphics V - 40×28 cells (320×224 pixels) |
| Blank | Graphics V - 32×30 cells (256×240 pixels) |
| Blank | Graphics V - 40×30 cells (320×240 pixels) |

When 32X image output is not blank, the MEGA Drive display mode should select a resolution **equal to** the 32X resolution.

---

## Related Documentation

- [MEMORY_MAP.md](MEMORY_MAP.md) - Memory addressing and RV bit impact
- [68K_SH2_COMMUNICATION.md](../68K_SH2_COMMUNICATION.md) - COMM register usage patterns
- [SH2_INTERRUPT_HANDLERS.md](../sh2-analysis/SH2_INTERRUPT_HANDLERS.md) - Interrupt handling code
- [STATE_MACHINES.md](STATE_MACHINES.md) - V-INT state machine architecture

## See Also

- **Hardware Manual:** `docs/32x-hardware-manual.md` - Section 1.5 (Registers)
- **Auto Memory:** `/home/matias/.claude/projects/-mnt-data-src-32x-playground/memory/MEMORY.md`
