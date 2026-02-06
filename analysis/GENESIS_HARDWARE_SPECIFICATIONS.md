# Genesis/Mega Drive Hardware Specifications

*Source: Official SEGA Documentation (GenesisTechnicalOverview.pdf, Genesis Software Manuals)*

## System Architecture

### Main CPU: Motorola 68000
- **Clock Speed:** 7.67 MHz (NTSC) / 7.61 MHz (PAL)
  - Note: Often listed as "8 MHz" in early documentation
  - Actual: 53.693175 MHz ÷ 7 = 7.670454 MHz
- **Architecture:** 16-bit data bus, 24-bit address bus
- **Instruction Set:** Base 68000 only (no 68010+ features)
  - No MOVE from CCR
  - No RTD, BKPT instructions
  - No instruction cache

### Memory Map (68000 Perspective)
```
$000000-$3FFFFF   ROM (4MB max with bank switching)
$400000-$7FFFFF   Reserved/Expansion
$A00000-$A0FFFF   Z80 Address Space
$A10000-$A10FFF   System I/O
$A11000-$A110FF   Z80 Control
$A13000-$A130FF   Reserved
$A14000-$A14003   TMSS (Trademark Security System)
$C00000-$C0001F   VDP
$FF0000-$FFFFFF   RAM (64KB)
```

### VDP (Video Display Processor)
- **Type:** Dedicated video processor
- **VRAM:** 64 KBytes (Video RAM)
- **CRAM:** 64 × 9-bit (Color RAM)
- **Display:** 320×224 pixels (40 chars × 28 chars)
  - Each character: 8×8 pixels
  - Pixel resolution: 320×224

#### Display Capabilities
- **Planes:** 3 total
  - 2 scrolling playfields
  - 1 sprite plane
  - Definable priorities between planes
- **Scrolling:** 1-pixel scrolling resolution
  - Horizontal: whole playfield, each character line, or each scan line
  - Vertical: whole playfield, 2-char wide columns
- **Sprites:** Up to 80 sprites can be defined
  - 1×1 char up to 4×4 chars per sprite
  - Up to 20 sprites displayed on a scan line
  - Sprite priorities

#### Color System
- **Total Colors:** 512 possible (3 bits per RGB component)
- **On-Screen:** 64 colors simultaneously
- **Palettes:** 4 palettes of 16 colors
  - 0th color of each palette is always transparent
- **Character Definition:**
  - Each char position: 2 bytes (includes char name, palette, points to char definition, horizontal/vertical flip, priority)
  - 4 bits/pixel (points to color register)
  - 4 bytes/scanline of char
  - 32 bytes for complete char definition
  - Playfield & sprite chars are the same

### DMA (Direct Memory Access)
- **Control:** Removes 68000 from bus during operation
- **Performance:**
  - Can move **205 bytes/scanline** during VBLANK
  - **30 scanlines** available during VBLANK
  - **Total: 7,380 bytes during VBLANK**
- **Uses:** Fast VRAM/CRAM updates without CPU overhead

### Z80 Sound System
- **CPU:** Z80 @ 4 MHz
- **Purpose:** Controls PSG (Programmable Sound Generator) & FM chips
- **RAM:** 8 KBytes dedicated Sound RAM
- **Access:** 68000 can access Z80 bus when Z80 is halted

### Interrupts
- **Horizontal Interrupt (H-INT):** Triggered per scanline
- **Vertical Interrupt (V-INT):** Triggered during VBLANK
- **Timing:**
  - 30 scanlines during VBLANK (NTSC)
  - Available for DMA and heavy processing

---

## 32X Extension (Virtua Racing Deluxe)

### Additional CPUs: Dual SH2
- **Clock Speed:** 23.01 MHz (NTSC)
- **Architecture:** 32-bit RISC
- **Configuration:**
  - Master SH2 (coordinates with 68000)
  - Slave SH2 (parallel processing)
- **Frame Budget:** ~383,500 cycles/frame each @ 60 Hz

### Additional Memory
- **SDRAM:** 2 Mbit (256 KBytes)
- **Frame Buffers:** Two 1 Mbit buffers (128 KBytes each)
- **Color Depth:** 15-bit RGB (32,768 colors)

### 32X VDP Modes
1. **Direct Color Mode:** 15-bit RGB direct
2. **Packed Pixel Mode:** 8-bit indexed
3. **Run Length Mode:** Compressed rendering

---

## Key Hardware Constraints

### 68000 Performance Limitations
- **No Instruction Cache:** Every instruction fetch from ROM/RAM
- **16-bit Data Bus:** Long words require 2 memory cycles
- **DMA Blocks CPU:** During VDP DMA, 68000 cannot access bus
- **7.67 MHz Ceiling:** Cannot be overclocked

### VDP Limitations
- **64 KB VRAM:** Limited space for graphics
- **20 Sprites/Line:** Sprite limit can cause flickering
- **Character-Based:** Not ideal for 3D polygon rendering
  - This is why 32X adds dedicated frame buffers

### Z80 Constraints
- **4 MHz:** Slow by modern standards
- **8 KB RAM:** Limited space for sound driver and samples
- **Bus Contention:** 68000 must halt Z80 to access sound RAM

---

## Development Best Practices

### From Official Software Manuals

#### Z80 Bus Access Rules
- **ALWAYS** request Z80 bus before accessing Z80 address space
- Check bus grant before proceeding
- Release bus promptly after access
- Z80 must be running to respond to bus request

#### Interrupt Handling
- **V-INT Priority:** Primary synchronization point for game logic
- **H-INT Usage:** Use sparingly; can impact performance
- **Interrupt Nesting:** Not recommended; can cause stack overflow
- **Clear Interrupt:** Always clear interrupt flag in handler

#### VDP Access Precautions
- **Control A/B Screens:** Be careful when switching
- **Auto-increment:** Can cause unexpected behavior if not managed
- **VRAM Timing:** Respect access timing requirements
- **DMA Safety:** Only trigger DMA during VBLANK when possible

#### Sound System Best Practices
- **Z80 Coordination:** Use proper handshaking for sound requests
- **Sound Driver:** Use SEGA's Sound Driver V3.00 or compatible
- **Sample Management:** Limit sample size due to 8 KB RAM constraint
- **Bus Requests:** Minimize frequency and duration

---

## Hardware Bugs and Workarounds

### Known Issues
See [32x-technical-info.md](../docs/32x-technical-info.md) for comprehensive list of 22 documented hardware bugs.

### Critical Issues for VRD
1. **SH2 Interrupt Bug:** FRT timer interrupt can fail (see 32x-hardware-manual-supplement-2.md)
2. **RV Bit:** ROM access blocks when RV=1 during 68K DMA
3. **FM Bit Preemption:** Immediate VDP access switch can corrupt mid-transfer
4. **COMM Register Races:** Simultaneous write from both CPUs = undefined value

---

## Performance Characteristics

### Measured Performance (from profiling)
- **68K:** ~127,987 cycles/frame (100% utilization = bottleneck)
  - Theoretical: 127,833 cycles/frame
  - Overhead: 154 cycles/frame (interrupt handling)
- **Master SH2:** ~139,568 cycles/frame (36% utilization)
- **Slave SH2:** ~299,958 cycles/frame (78% utilization)

### Bottleneck Analysis
**Root Cause:** Blocking synchronization model
- 68K waits for SH2 to complete polygon transforms
- SH2s idle while 68K does game logic
- No parallel processing = underutilized CPUs
- Result: ~20 FPS ceiling despite dual 23 MHz CPUs

**Solution:** Async parallel processing (see OPTIMIZATION_PLAN.md)

---

## Assembly Syntax: SNASM68K vs vasm

### SEGA's Official Assembler: SNASM68K
- **Vendor:** Cross Products (UK)
- **Target:** Genesis/Mega Drive development
- **Features:**
  - Integrated debugger
  - ROM emulation via cartridge interface
  - EPROM programming support

### Key Syntax Differences

| Feature | SNASM68K | vasm (used in this project) |
|---------|----------|----------------------------|
| Comments | `;` semicolon | `;` semicolon |
| Hex Literals | `$` prefix | `$` prefix |
| Binary Literals | `%` prefix | `%` prefix |
| Local Labels | `.label` | `.label` or `@label` |
| Absolute Short | Accepts high addresses | Range-checks strictly |
| PC-Relative | Auto-calculates | Sometimes needs manual encoding |

### Translation Challenges (vasm)
1. **Absolute Short Addressing:** vasm rejects addresses like `$C30F` as absolute short
   - **Workaround:** Use manual `dc.w` encoding
2. **PC-Relative Indexed:** Complex addressing modes may not assemble correctly
   - **Workaround:** Use manual `dc.w` encoding
3. **Range Checking:** vasm is stricter than SNASM68K
   - **Benefit:** Catches potential errors
   - **Cost:** May need manual encoding for valid code

---

## References

### Official SEGA Documentation
- [GenesisTechnicalOverview.pdf](../docs/GenesisTechnicalOverview.pdf) - Hardware specifications
- [Genesis_Software_Development_Manual_Version_2.0_1991-07-09.pdf](../docs/Genesis_Software_Development_Manual_Version_2.0_1991-07-09.pdf) - Software development guide
- [SegaGenesisSoftwareManual_1990-02-06.pdf](../docs/SegaGenesisSoftwareManual_1990-02-06.pdf) - Comprehensive software manual
- [SNASM68K_Console_and_Z80_Notes.pdf](../docs/SNASM68K_Console_and_Z80_Notes.pdf) - Official assembler documentation
- [32XUSHardwareManual.pdf](../docs/32XUSHardwareManual.pdf) - 32X hardware manual

### Project Documentation
- [DOCUMENTATION_INDEX.md](../docs/DOCUMENTATION_INDEX.md) - Complete documentation catalog
- [32X_REGISTERS.md](architecture/32X_REGISTERS.md) - 32X register reference
- [DATA_STRUCTURES.md](architecture/DATA_STRUCTURES.md) - Memory maps and structures
