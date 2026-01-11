# Virtua Racing Deluxe - SH2 Master Code Analysis

**Last Updated**: 2026-01-06
**Status**: Initial investigation
**Entry Point**: ROM offset 0x288 (SH2 address $06000288)

---

## Executive Summary

The SH2 Master processor is responsible for 3D polygon transformation, rendering, and coordinating with the Slave processor. This document analyzes the Master's code starting from its entry point discovered at ROM offset 0x288.

---

## Entry Point Discovery

### How We Found It

The SH2 Boot ROM (internal to the SH2 chip) reads the Master's entry point from a fixed location in the cartridge ROM:

- **ROM offset 0x3E4** contains: `0x06000288`
- This translates to: **ROM offset 0x288** (SH2 address $06000288 uncached)

### Boot Sequence

1. Power on / Reset
2. SH2 Master executes internal Boot ROM
3. Boot ROM reads address from ROM offset 0x3E4
4. Boot ROM jumps to that address ($06000288)
5. Master begins initialization

---

## Expected Code Structure

Based on typical SH2 initialization patterns, we expect to see:

### 1. Stack Pointer Setup
```asm
MOV.L   @(stack_addr,PC),R15    ; Load stack pointer
```

### 2. Register Initialization
```asm
MOV     #0,R0                    ; Clear registers
MOV     R0,R1
...
```

### 3. Hardware Setup
- Set up cache control registers
- Configure interrupt vectors
- Initialize SDRAM base addresses

### 4. Handshake with 68K
```asm
MOV.L   @(comm0_addr,PC),R1     ; Get COMM0 address
MOV.L   #'M_OK',R0              ; Load signature
MOV.L   R0,@R1                  ; Write to COMM0
```

### 5. Wait for Start Signal
```asm
wait_loop:
    MOV.L   @R1,R0              ; Read COMM0
    TST     R0,R0               ; Check if zero
    BNE     wait_loop           ; Loop until 68K writes 0
```

### 6. Main Loop Entry
- Jump to 3D rendering main loop
- Coordinate with Slave via SDRAM

---

## Disassembly Analysis

### ROM Offset 0x288-0x2FF (First 128 bytes)

**To examine this code, run:**
```bash
python3 tools/sh2_disasm.py <rom_file> 0x288 128
```

**Expected to find:**
- Entry vector or jump table
- Initialization routines
- Pointer to main rendering loop

### Key Addresses to Track

| Purpose | Expected Location | Notes |
|---------|------------------|--------|
| Stack pointer (R15) | SDRAM region | Likely $22000000 + offset |
| COMM0 address | $20004020 (cached) | For 68K communication |
| SDRAM work area | $22000000+ | Transformation matrices, polygons |
| Main loop | Unknown | Jump target after init |

---

## SH2 Memory Layout (Master View)

```
┌─────────────────────────────────────────────────────────────────┐
│ SH2 Master Address Space                                        │
├──────────────┬──────────────────────────────────────────────────┤
│ $00000000    │ Boot ROM (internal, executed first)              │
│ $06000000    │ ROM (uncached) - Code executes from here         │
│ $06000288    │ ← Master entry point (this file's focus)         │
│ $20000000    │ ROM (cached) - Faster access for data            │
│ $20004020    │ COMM0 register (68K communication)               │
│ $22000000    │ SDRAM (256KB) - Working memory                   │
│              │   - Stack                                        │
│              │   - Transformation matrices                      │
│              │   - Polygon buffers                              │
│              │   - Shared data with Slave                       │
│ $24000000    │ Frame buffer (direct access)                     │
└──────────────┴──────────────────────────────────────────────────┘
```

---

## Communication Protocol

### Master → 68K

**Phase 1: Initialization Complete**
```
Master writes to COMM0 ($A15120 from 68K view, $20004020 from SH2 view):
Value: 0x4D5F4F4B ("M_OK")
```

**Phase 2: Ready for Commands**
```
Master reads COMM0:
Value: 0x00000000 (68K signals "start main loop")
```

**Phase 3: Runtime Communication**
```
COMM0-COMM7: Command buffers, status flags, data pointers
Master polls these each frame
```

### Master ↔ Slave

**Coordination via SDRAM:**
- Shared memory at $22000000+
- Lock/flag system for synchronization
- Work distribution (e.g., even/odd scanlines, left/right polygons)

---

## Code Sections Expected

### Section 1: Initialization (0x288+)
- Stack setup
- Cache configuration
- Interrupt vector setup
- SDRAM clear/initialize

### Section 2: Handshake (0x2??+)
- Write "M_OK" to COMM0
- Wait for zero from 68K
- Jump to main loop

### Section 3: Main Loop (location TBD)
- Read 68K commands from COMM registers
- Process 3D transformation matrices
- Coordinate with Slave
- Render polygons to frame buffer
- Signal completion back to 68K

---

## Analysis Tools

### Disassemble Entry Point
```bash
python3 tools/sh2_disasm.py <rom_file> 0x288 256
```

### Search for "M_OK" String
```bash
python3 -c "
data = open('<rom_file>', 'rb').read()
target = b'M_OK'
for i in range(len(data) - 3):
    if data[i:i+4] == target:
        print(f'Found at offset 0x{i:X}')
"
```

### Find COMM0 Register References
```bash
# SH2 COMM0 address: $20004020
# Look for: 0x20 0x00 0x40 0x20 in ROM
python3 tools/sh2_disasm.py <rom_file> 0x288 2048 | grep "20004020"
```

---

## Next Steps

### Immediate (This Session)
1. ✅ Locate entry point (ROM 0x288) - **DONE**
2. ⏳ Disassemble first 256 bytes - **NEXT**
3. ⏳ Identify stack pointer setup
4. ⏳ Find "M_OK" handshake code
5. ⏳ Locate main loop jump target

### Short Term
6. Map complete initialization flow
7. Document all SDRAM usage
8. Trace communication protocol
9. Find Slave entry and compare with Master

### Long Term
10. Disassemble entire 3D rendering pipeline
11. Understand polygon transformation algorithm
12. Document frame buffer management
13. Identify optimization opportunities

---

## References

### Internal Documentation
- [SH2_CODE_HUNT.md](SH2_CODE_HUNT.md) - How we found the entry point
- [INITIALIZATION_SEQUENCE.md](INITIALIZATION_SEQUENCE.md) - 68K boot sequence
- [MEMORY_MAP.md](MEMORY_MAP.md) - Complete memory layout

### Hardware Documentation
- [32X Hardware Manual](../docs/32x-hardware-manual.md) - SH2 memory map
- [32X Technical Info](../docs/32x-technical-info-attachment1.md) - Sample code

### External References
- Hitachi SH7604 Hardware Manual - SH2 instruction set
- SH2 Programmer's Manual - Addressing modes, registers

---

## Questions to Answer

1. **Where is the stack?** - Which SDRAM address is used for R15?
2. **Code location?** - Does code stay in ROM or get copied to SDRAM?
3. **Main loop?** - Where does execution go after initialization?
4. **Work distribution?** - How do Master and Slave divide rendering work?
5. **Synchronization?** - What mechanism prevents race conditions?
6. **Performance?** - Where are the bottlenecks in the rendering pipeline?

---

**Status**: Entry point confirmed. Ready to disassemble and analyze code.
**Priority**: HIGH - This is the heart of the 3D engine!

