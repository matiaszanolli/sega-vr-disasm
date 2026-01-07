# 68K Annotation Tasks - Virtua Racing Deluxe

**Project**: Virtua Racing Deluxe (USA).32x
**Date**: 2026-01-06
**Total Functions**: 769

## Priority Overview

| Priority | Category | Functions | Status | Notes |
|----------|----------|-----------|--------|-------|
| 1 | Interrupt Handlers | 3 | ✅ Complete | V-INT, H-INT, Default |
| 2 | Top Hotspots (10+ calls) | 9 | ✅ Complete | Core game loop functions |
| 3 | Entry Point & Init | 14 | ✅ Complete | Boot, MARS, SH2, decompression |
| 4 | Communication (68K↔SH2) | 3 | ✅ Complete | COMM protocol documented |
| 5 | Controller/Input | 6 | ✅ Complete | 3-btn + 6-btn support |
| 6 | Low Code Utilities | 33 | ✅ Complete | Input, VDP, memory utilities |
| 7 | V-INT State Handlers | 16 | ✅ Complete | All 16 states documented |
| 8 | Main Game Logic | ~100 | Pending | State machines |
| 9 | Extended/Data | ~500+ | Pending | Track, graphics, etc. |

---

## Priority 1: Interrupt Handlers ✅ COMPLETE

| Status | Function | Address | Size | Purpose |
|--------|----------|---------|------|---------|
| [x] | DefaultExceptionHandler | $00880832 | 6 bytes | Infinite loop crash handler |
| [x] | H_INT_Handler | $0088170A | 2 bytes | H-blank (unused, immediate RTE) |
| [x] | V_INT_Handler | $00881684 | 44 bytes | V-blank main timing + state machine |

**Documentation**: [68K_INTERRUPT_HANDLERS.md](68K_INTERRUPT_HANDLERS.md)

---

## Priority 2: Top Hotspot Functions (10+ calls) ✅ COMPLETE

| Status | Function | Address | Calls | Purpose |
|--------|----------|---------|-------|---------|
| [x] | WaitForVBlank | $00884998 | 21 | Sync with V-INT |
| [x] | UpdateInputState | $00882080 | 21 | Controller state machine |
| [x] | SetDisplayParams | $008849AA | 21 | Init display buffers |
| [x] | SendDREQCommand | $0088FB36 | 17 | DMA request to SH2 |
| [x] | ControllerRead | $0088179E | 16 | Read controller ports |
| [x] | SetInputFlag | $0088205E | 16 | Set input state flag |
| [x] | TableLookup | $008814BE | 12 | Indexed table access |
| [x] | ClearInputState | $0088204A | 11 | Clear input RAM |
| [x] | VDPFrameControl | $008826C8 | 10 | Frame buffer FM toggle |

**Documentation**: [68K_HOTSPOT_FUNCTIONS.md](68K_HOTSPOT_FUNCTIONS.md)

---

## Priority 3: Entry Point & Initialization ✅ COMPLETE

| Status | Function | Address | Size | Purpose |
|--------|----------|---------|------|---------|
| [x] | EntryPoint | $008803F0 | 207 bytes | Initial PC from vector - MARS detect, Z80 init |
| [x] | MARSAdapterInit | $00880838 | 92 bytes | 32X adapter initialization - ADEN/REN check |
| [x] | SH2Handshake | $008808A8 | 64 bytes | Wait for 'VRES', 'M_OK', 'S_OK' signatures |
| [N/A] | func_058A | $0088058A | 16 bytes | DATA: "ROM Version 1.0" ASCII string (not code) |
| [x] | func_05A6 | $008805A6 | 38 bytes | VDP register init - load 19 bytes from table |
| [N/A] | func_05B0 | $008805B0 | N/A | Not a function start (middle of func_05A6) |
| [x] | func_05CE | $008805CE | 110 bytes | Clear Genesis VDP RAM (CRAM/VRAM/VSRAM) |
| [x] | func_0654 | $00880654 | 62 bytes | 32X VDP mode setup - auto-fill init |
| [x] | func_0694 | $00880694 | 46 bytes | Clear 32X frame buffer (512 bytes) |
| [x] | SecurityCode | $008806E4 | ~48 bytes | MARS security protocol |
| [x] | func_0FBE | $00880FBE | 94 bytes | Copy init code to Work RAM + Z80 bus control |
| [x] | func_1140 | $00881140 | 162 bytes | RLE/bit-packed data decompressor |
| [x] | func_11E4 | $008811E4 | 94 bytes | Byte stream decoder with $FF terminator |
| [x] | func_12F4 | $008812F4 | 174 bytes | Bit field extraction with bitmask table |
| [x] | func_13A4 | $008813A4 | 16 bytes | Bit buffer refill helper (< 9 bits check) |
| [x] | func_13B4 | $008813B4 | 206 bytes | Stack-based multi-phase bit decoder (LZ77-like) |

**Documentation**: [68K_ENTRY_INIT.md](68K_ENTRY_INIT.md)

---

## Priority 4: 68K ↔ SH2 Communication ✅ COMPLETE

Functions that use COMM0-COMM7 registers ($A15120-$A1512E):

| Status | Function | Address | Purpose |
|--------|----------|---------|---------|
| [x] | SendDREQCommand | $0088FB36 | Write DREQ request, wait for SH2 ack |
| [x] | SH2Handshake | $008808A8 | Boot handshake - 'VRES', 'M_OK', 'S_OK' |
| [x] | VDPFrameControl | $008826C8 | FM bit toggle for frame buffer access |

**Documentation**: [68K_COMM_PROTOCOL.md](68K_COMM_PROTOCOL.md)

**Key Patterns Documented**:
- Command/Response protocol
- Status polling
- Signature handshake
- DREQ (DMA Request) system
- Frame buffer access control

---

## Priority 5: Controller/Input System ✅ COMPLETE

| Status | Function | Address | Calls | Purpose |
|--------|----------|---------|-------|---------|
| [x] | ControllerRead | $0088179E | 16 | Main controller reading entry point |
| [x] | Read6ButtonPad | $0088185E | - | 6-button detection via TH toggle |
| [x] | MapButtonBits | $008817EE | - | Map hardware bits to game buttons |
| [x] | UpdateInputState | $00882080 | 21 | High-level input state machine (see Priority 2) |
| [x] | SetInputFlag | $0088205E | 16 | Set input processing flag (see Priority 2) |
| [x] | ClearInputState | $0088204A | 11 | Clear input RAM (see Priority 2) |

**Documentation**: [68K_CONTROLLER_INPUT.md](68K_CONTROLLER_INPUT.md)

**Key Systems Documented**:
- 3-button and 6-button controller support
- TH pin toggle sequence for 6-button detection
- Button mapping table at $FE82
- Input state RAM at $C822, $C86C, $8509, etc.
- Edge detection for button presses
- Integration with SH2 via COMM/DREQ

---

## Priority 6: Low Code Utilities ($2000-$3FFF) ✅ COMPLETE

| Status | Function | Address | Calls | Purpose |
|--------|----------|---------|-------|---------|
| [x] | ClearInputState | $0088204A | 11 | Clear input RAM (see Priority 2) |
| [x] | SetInputFlag | $0088205E | 16 | Set input processing flag (see Priority 2) |
| [x] | func_2066 | $00882066 | 1 | Input system initialization |
| [x] | UpdateInputState | $00882080 | 21 | Input state machine (see Priority 2) |
| [x] | func_20C6 | $008820C6 | 1 | Extended input processing (V-INT state 11) |
| [x] | func_21CA | $008821CA | 5 | Input state copy to controller buffer |
| [x] | func_2236 | $00882236 | 1 | Bit test and branch utility |
| [x] | func_24CA | $008824CA | 2 | Data processing |
| [x] | func_24FA | $008824FA | 1 | Data transformation |
| [x] | func_251A | $0088251A | 1 | Memory initialization |
| [x] | func_251C | $0088251C | 1 | Memory operation |
| [x] | func_252C | $0088252C | 1 | Data processing |
| [x] | func_253E | $0088253E | 1 | Utility operation |
| [x] | func_2546 | $00882546 | 1 | Data handling |
| [x] | func_2558 | $00882558 | 1 | Memory utility |
| [x] | func_25B0 | $008825B0 | 2 | Memory operation |
| [x] | func_266C | $0088266C | 1 | VDP-related operation |
| [x] | func_268C | $0088268C | 1 | VDP-related operation |
| [x] | VDPFrameControl | $008826C8 | 10 | Frame buffer FM toggle (see Priority 2) |
| [x] | func_270A | $0088270A | 1 | VDP operation |
| [x] | func_2742 | $00882742 | 4 | VDP auto-fill operation |
| [x] | func_27A0 | $008827A0 | 1 | Frame buffer write |
| [x] | func_27F8 | $008827F8 | 1 | VDP fill operation |
| [x] | func_281E | $0088281E | 1 | VDP preparation |
| [x] | func_284C | $0088284C | 1 | VDP operation |
| [x] | func_2862 | $00882862 | 1 | Memory operation |
| [x] | func_2878 | $00882878 | 1 | Palette RAM copy (called by V-INT state 6) |
| [x] | func_28C2 | $008828C2 | 2 | VDP/SH2 COMM synchronization |
| [x] | func_318E | $0088318E | 1 | High-level utility |
| [x] | func_344C | $0088344C | 1 | High-level utility |
| [x] | func_38C0 | $008838C0 | 1 | High-level utility |
| [x] | func_3D2C | $00883D2C | 1 | High-level utility |
| [x] | func_3D6A | $00883D6A | 1 | High-level utility |
| [x] | func_3FD0 | $00883FD0 | 1 | High-level utility |

**Documentation**: [68K_LOW_CODE_UTILITIES.md](68K_LOW_CODE_UTILITIES.md)

**Key Categories Documented**:
- Input processing utilities (func_2066, func_20C6, func_21CA)
- VDP/graphics operations (func_2742, func_27A0, func_2878, func_28C2)
- Memory/data functions (func_2236, func_24CA, func_25B0, etc.)
- Performance characteristics and debugging guide

---

## Priority 7: V-INT State Handlers ✅ COMPLETE

These are the handlers called from V-INT jump table at $16B2:

| Status | State | Address | Purpose |
|--------|-------|---------|---------|
| [x] | 0,1,2,8 | $008819FE | Shared default handler |
| [x] | 3 | $00018200 | INVALID (odd address - unused/error state) |
| [x] | 4 | $00881A6E | Minimal NOP-like handler |
| [x] | 5 | $00881A72 | SH2 communication |
| [x] | 6 | $00881C66 | Frame buffer + VDP control |
| [x] | 7 | $00881ACA | SH2 communication |
| [x] | 9 | $00881E42 | Palette initialization |
| [x] | 10 | $00881B14 | SH2 communication |
| [x] | 11 | $00881A64 | Delegate to func at $20C6 |
| [x] | 12 | $00881BA8 | SH2 communication |
| [x] | 13 | $00881E94 | Frame buffer operations |
| [x] | 14 | $00881F4A | Frame buffer operations |
| [x] | 15 | $00882010 | COMM register cleanup |

**Documentation**: [68K_VINT_STATES.md](68K_VINT_STATES.md)

---

## Priority 8: Main Game Logic ($4000-$FFFF)

124 functions in this region. Key targets:

| Status | Function | Address | Calls | Purpose |
|--------|----------|---------|-------|---------|
| [x] | WaitForVBlank | $00884998 | 21 | V-INT sync (Priority 2) |
| [x] | SetDisplayParams | $008849AA | 21 | Display init (Priority 2) |
| [x] | func_4004 | $00884004 | 1 | Dual conditional table lookup & write |
| [x] | func_4280 | $00884280 | 2 | Nibble extractor & field populator |
| [x] | func_426E | $0088426E | 1 | Conditional VDP write with counter |
| [x] | func_4836 | $00884836 | 1 | Quad memory fill dispatcher |
| [x] | func_483A | $0088483A | 1 | Memory fill waterfall entry 1 |
| [x] | func_483E | $0088483E | 1 | Memory fill waterfall entry 2 |
| [x] | func_4842 | $00884842 | 2 | Memory fill 60 bytes (A1) |
| [x] | func_4846 | $00884846 | 1 | Memory fill 60 bytes (A4) |
| [x] | func_4920 | $00884920 | 6 | Fast 20-byte memory copy (A1→A2) |
| [x] | func_4922 | $00884922 | 2 | Fast 16-byte copy (variant entry) |
| [x] | func_48CA | $008848CA | 2 | Triple memory fill dispatcher |
| [x] | func_48CE | $008848CE | 2 | Memory fill waterfall entry 1 |
| [x] | func_48D2 | $008848D2 | 2 | Memory fill waterfall entry 2 |
| [x] | func_4CBC | $00884CBC | 1 | Game state jump table dispatcher |
| [x] | func_5306 | $00885306 | 1 | Game state dispatcher 2 (parallel to 4CBC) |
| [x] | func_58C8 | $008858C8 | 1 | Conditional bus operation loop (6 iter) |
| [x] | func_5908 | $00885908 | 1 | Conditional bus operation loop (8 iter) |
| [x] | func_593C | $0088593C | 1 | Conditional bus operation loop (single) |
| [x] | func_60FD | $008860FD | 1 | Subroutine call chain (14+ calls) |
| [x] | func_64A8 | $008864A8 | 1 | Object initialization & setup |
| [x] | func_6C88 | $00886C88 | 1 | Bitfield dispatcher (7-way) |
| [x] | func_6D00 | $00886D00 | 4 | Table search with conditional index |
| [x] | func_6D9C | $00886D9C | 1 | Hardware loop 1 (6 iter, $FF9100) |
| [x] | func_6DC8 | $00886DC8 | 1 | Hardware loop 2 (8 iter, $FF9700) |
| [x] | func_6DF0 | $00886DF0 | 1 | Hardware loop 3 (single, $FF9F00) |
| [x] | func_7280 | $00887280 | 2 | Bitfield calculator (3D spatial) |
| [x] | func_83AE | $008883AE | 2 | PSG nibble splitter |
| [x] | func_9084 | $00889084 | 1 | VDP calculation & write |
| [x] | func_D1D4 | $0088D1D4 | 6 | Z80 sound command sender |
| [x] | func_5000 | $00885000 | - | Interrupt vector setup |
| [x] | func_8000 | $00888000 | - | Object state updater |
| [x] | func_E316 | $0088E316 | 6 | Send COMM command $25 to SH2 |
| [x] | func_E35A | $0088E35A | 7 | Send COMM command $22 (multi-phase) |
| [x] | func_E406 | $0088E406 | 6 | Send COMM command $2F (4 params) |
| [x] | func_E4BC | $0088E4BC | 6 | Compute + send COMM command $21 |
| [x] | func_E52C | $0088E52C | 8 | Multi-table processor (HIGHEST P8 calls) |
| [x] | SendDREQCommand | $0088FB36 | 17 | DMA request to SH2 (Priority 4) |
| [x] | func_5A52 | $00885A52 | - | Object field calculator (table lookup) |
| [x] | func_6EAE | $00886EAE | - | Multi-stage initialization coordinator |
| [x] | func_6F98 | $00886F98 | - | Conditional object update |
| [x] | func_71B3 | $008871B3 | - | Table-based address calculator |
| [x] | func_7364 | $00887364 | - | Parallel address calculator |
| [x] | func_73F2 | $008873F2 | - | 3D coordinate transform calculator |
| [x] | func_757A | $0088757A | - | Multi-threshold comparator |
| [x] | func_7BE4 | $00887BE4 | - | 16-entry jump table dispatcher |
| [x] | func_9A9E | $00889A9E | - | Value clamp with damping |
| [x] | func_9B7C | $00889B7C | - | Dual function (write + validator) |
| [x] | func_4856 | $00884856 | - | Unrolled memory fill 1 (96 bytes) |
| [x] | func_485E | $0088485E | - | Unrolled memory fill 2 (112 bytes) |
| [x] | func_48B8 | $008848B8 | - | Unrolled memory fill 3 (32 bytes) |
| [x] | func_48FE | $008848FE | - | Unrolled memory fill 4 (60 bytes) |
| [x] | func_88BE | $008888BE | - | Complex conditional state handler |
| [x] | func_8DC0 | $00888DC0 | - | 3D coordinate calculation |
| [x] | func_A144 | $0088A144 | - | Table-based data initialization |
| [x] | func_A80A | $0088A80A | - | Loop-based data copy 1 (structured) |
| [x] | func_A83E | $0088A83E | - | Loop-based data copy 2 (bulk) |
| [x] | func_BA18 | $0088BA18 | - | Triple jump table dispatcher |
| [x] | func_CA20 | $0088CA20 | - | Hardware register configuration (VDP) |
| [x] | func_CA9A | $0088CA9A | - | Game mode initialization |
| [x] | func_CC06 | $0088CC06 | - | SH2 COMM setup with table lookup |
| [x] | func_CC74 | $0088CC74 | - | Register and flag initialization |
| [x] | func_CC88 | $0088CC88 | - | Control register continuation |
| [x] | func_CD4C | $0088CD4C | - | Loop-based array processor |
| [x] | func_CD92 | $0088CD92 | - | Conditional push with setup |
| [x] | func_CDD2 | $0088CDD2 | - | Table lookup with loop update |
| [x] | func_CE02 | $0088CE02 | - | Field manipulation (conditional paths) |
| [x] | func_CE76 | $0088CE76 | - | Multi-handler orchestration |
| [x] | func_CEC2 | $0088CEC2 | - | Bit calculation with shifts |
| [x] | func_CECC | $0088CECC | - | Bit calculation (alt variant) |
| [x] | func_CF0C | $0088CF0C | - | Multi-JSR orchestration with loop |
| [x] | func_CFAE | $0088CFAE | - | Complex data copy (mode handling) |

**Documentation**: [68K_MAIN_LOGIC.md](68K_MAIN_LOGIC.md)

---

## Priority 9: Extended Regions

### Main Code 2 ($10000-$1FFFF) - 61 functions

| Status | Function | Address | Calls | Purpose |
|--------|----------|---------|-------|---------|
| [ ] | func_10674 | $00890674 | 9 | HIGH - 9 calls |
| [ ] | func_188EC | $008988EC | 9 | HIGH - 9 calls |
| [ ] | func_10656 | $00890656 | 5 | TBD |
| [ ] | func_10606 | $00890606 | 3 | TBD |
| [ ] | ... | ... | ... | (57 more) |

### Extended ($30000-$FFFFF) - 123 functions

| Status | Function | Address | Calls | Purpose |
|--------|----------|---------|-------|---------|
| [ ] | func_30000 | $008B0000 | 8 | Track/data loader? |
| [ ] | func_30004 | $008B0004 | 1 | TBD |
| [ ] | ... | ... | ... | (121 more) |

### High ROM ($100000+) - 285 functions

Likely data handlers, track-specific code, graphics routines.

---

## Progress Tracking

### Completion Summary

| Priority | Total | Complete | Remaining | % |
|----------|-------|----------|-----------|---|
| 1. Interrupts | 3 | 3 | 0 | 100% |
| 2. Hotspots | 9 | 9 | 0 | 100% |
| 3. Entry/Init | 14 | 14 | 0 | 100% |
| 4. Communication | 3 | 3 | 0 | 100% |
| 5. Controller | 6 | 6 | 0 | 100% |
| 6. Low Code | 33 | 33 | 0 | 100% |
| 7. V-INT States | 16 | 16 | 0 | 100% |
| 8. Main Logic | 124 | 77 | 47 | 62% |
| 9. Extended | 500+ | 0 | 500+ | 0% |
| **TOTAL** | **769** | **161** | **608** | **20.9%** |

### Milestones

- [x] Priority 1 Complete (3 functions) ✅
- [x] Priority 2 Complete (9 functions) ✅
- [x] Priority 3 Complete (14 functions) ✅ **NEW!**
- [x] Priority 4 Complete (3 functions) ✅
- [x] Priority 5 Complete (6 functions) ✅
- [x] Priority 6 Complete (33 functions) ✅
- [x] Priority 7 Complete (16 state handlers) ✅
- [x] 50 functions annotated ✅
- [x] **Priority 1-7 ALL COMPLETE** (88 functions) ✅ **MILESTONE!**
- [x] **100 functions annotated** ✅ **MILESTONE ACHIEVED!** 🎉
- [ ] 200 functions annotated
- [ ] 50% of high-priority functions

---

## Key RAM Locations

From hotspot analysis:

| Address | Type | Purpose |
|---------|------|---------|
| $FF8509 | Byte | Controller state A |
| $FF850A | Byte | Controller state B |
| $FFC822 | Byte | Input state flag A |
| $FFC86C | Word | Display parameter 1 |
| $FFC86E | Word | Display parameter 2 |
| $FFC87A | Word | **VBlank flag / state index** |
| $FFC8A4 | Long | Input state buffer |
| $FFC8A5 | Byte | Input state flag B |
| $FFC8A7 | Byte | Input state flag C |
| $FFC964 | Long | **Frame counter** |
| $FFC970 | Long | Display parameter 3 |
| $FFC974 | Long | Display parameter 4 |

---

## Next Steps

1. ~~**Complete Priority 2**~~ ✅ - Annotate remaining 5 hotspot functions
2. ~~**Trace Entry Point**~~ ✅ - Follow $3F0 → initialization chain
3. ~~**Map COMM Usage**~~ ✅ - Find all 68K↔SH2 communication
4. ~~**Document V-INT States**~~ ✅ - Analyze each state handler
5. **Complete Priority 5** - Finish controller/input system documentation
6. **Complete Priority 6** - Document low code utilities (33 functions)
7. **Build Call Graph** - Understand function relationships

---

## References

- [68K_MEMORY_MAP.md](68K_MEMORY_MAP.md) - Hardware registers
- [68K_INTERRUPT_HANDLERS.md](68K_INTERRUPT_HANDLERS.md) - Interrupt documentation
- [68K_VINT_STATES.md](68K_VINT_STATES.md) - V-INT state machine (16 handlers)
- [68K_CONTROLLER_INPUT.md](68K_CONTROLLER_INPUT.md) - Controller/input system (3-btn + 6-btn)
- [68K_FUNCTION_INVENTORY.md](68K_FUNCTION_INVENTORY.md) - Complete function list
- [68K_HOTSPOT_FUNCTIONS.md](68K_HOTSPOT_FUNCTIONS.md) - High-call-count functions
- [68K_ENTRY_INIT.md](68K_ENTRY_INIT.md) - Boot sequence and initialization
- [68K_COMM_PROTOCOL.md](68K_COMM_PROTOCOL.md) - 68K↔SH2 communication protocol
- [68K_ANNOTATION_PLAN.md](68K_ANNOTATION_PLAN.md) - Original planning document
- [68K_MAIN_LOGIC.md](68K_MAIN_LOGIC.md) - Priority 8 main game logic functions
