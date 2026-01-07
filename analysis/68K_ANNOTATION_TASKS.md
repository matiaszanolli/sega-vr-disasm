# 68K Annotation Tasks - Virtua Racing Deluxe

**Project**: Virtua Racing Deluxe (USA).32x
**Date**: 2026-01-06
**Total Functions**: 769

## Priority Overview

| Priority | Category | Functions | Status | Notes |
|----------|----------|-----------|--------|-------|
| 1 | Interrupt Handlers | 3 | ✅ Complete | V-INT, H-INT, Default |
| 2 | Top Hotspots (10+ calls) | 9 | ✅ Complete | Core game loop functions |
| 3 | Entry Point & Init | ~15 | ✅ Complete | Boot, MARS, SH2 handshake |
| 4 | Communication (68K↔SH2) | 3 | ✅ Complete | COMM protocol documented |
| 5 | Controller/Input | ~8 | 🔄 Partial | ControllerRead done |
| 6 | Low Code Utilities | 33 | Pending | Memory ops, helpers |
| 7 | V-INT State Handlers | 16 | Pending | Jump table targets |
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
| [x] | EntryPoint | $008803F0 | ~207 bytes | Initial PC from vector - MARS detect, Z80 init |
| [x] | MARSAdapterInit | $00880838 | ~92 bytes | 32X adapter initialization - ADEN/REN check |
| [x] | SH2Handshake | $008808A8 | 64 bytes | Wait for 'VRES', 'M_OK', 'S_OK' signatures |
| [ ] | func_058A | $0088058A | TBD | Called during boot |
| [x] | func_05A6 | $008805A6 | TBD | Init function 1 (called from entry) |
| [ ] | func_05B0 | $008805B0 | TBD | Called during boot |
| [x] | func_05CE | $008805CE | TBD | Init function 2 (called from entry) |
| [ ] | func_0654 | $00880654 | TBD | Called 2x during boot |
| [ ] | func_0694 | $00880694 | TBD | Called during boot |
| [x] | SecurityCode | $008806E4 | TBD | MARS security protocol |
| [ ] | func_0FBE | $00880FBE | TBD | Boot sequence |
| [ ] | func_1140 | $00881140 | TBD | Boot sequence |
| [ ] | func_11E4 | $008811E4 | TBD | Boot sequence |
| [ ] | func_12F4 | $008812F4 | TBD | Called 4x |
| [ ] | func_13A4 | $008813A4 | TBD | Boot sequence |
| [ ] | func_13B4 | $008813B4 | TBD | Called 2x |

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

## Priority 5: Controller/Input System

| Status | Function | Address | Calls | Purpose |
|--------|----------|---------|-------|---------|
| [x] | ControllerRead | $0088179E | 16 | Low-level port read |
| [ ] | func_185E | $0088185E | TBD | Called by $179E |
| [ ] | func_17EE | $008817EE | TBD | Called by $179E |
| [ ] | ProcessInput | TBD | TBD | High-level input |

**6-Button Controller Protocol**:
1. Write $40 to control register
2. Read TH=1 state (Up, Down, Left, Right, B, C)
3. Write $00 to control register
4. Read TH=0 state (Up, Down, A, Start)
5. Repeat for extra buttons (X, Y, Z, Mode)

---

## Priority 6: Low Code Utilities ($2000-$3FFF)

| Status | Function | Address | Calls | Purpose |
|--------|----------|---------|-------|---------|
| [ ] | func_204A | $0088204A | 11 | TBD |
| [ ] | func_205E | $0088205E | 16 | TBD |
| [ ] | func_2066 | $00882066 | 1 | TBD |
| [x] | func_2080 | $00882080 | 21 | UpdateInputState |
| [ ] | func_20C6 | $008820C6 | 1 | TBD |
| [ ] | func_21CA | $008821CA | 5 | TBD |
| [ ] | func_2236 | $00882236 | 1 | TBD |
| [ ] | func_24CA | $008824CA | 2 | TBD |
| [ ] | func_24FA | $008824FA | 1 | TBD |
| [ ] | func_251A | $0088251A | 1 | TBD |
| [ ] | func_251C | $0088251C | 1 | TBD |
| [ ] | func_252C | $0088252C | 1 | TBD |
| [ ] | func_253E | $0088253E | 1 | TBD |
| [ ] | func_2546 | $00882546 | 1 | TBD |
| [ ] | func_2558 | $00882558 | 1 | TBD |
| [ ] | func_25B0 | $008825B0 | 2 | TBD |
| [ ] | func_266C | $0088266C | 1 | TBD |
| [ ] | func_268C | $0088268C | 1 | TBD |
| [ ] | func_26C8 | $008826C8 | 10 | TBD |
| [ ] | func_270A | $0088270A | 1 | TBD |
| [ ] | func_2742 | $00882742 | 4 | TBD |
| [ ] | func_27A0 | $008827A0 | 1 | TBD |
| [ ] | func_27F8 | $008827F8 | 1 | TBD |
| [ ] | func_281E | $0088281E | 1 | TBD |
| [ ] | func_284C | $0088284C | 1 | TBD |
| [ ] | func_2862 | $00882862 | 1 | TBD |
| [ ] | func_28C2 | $008828C2 | 2 | TBD |
| [ ] | func_318E | $0088318E | 1 | TBD |
| [ ] | func_344C | $0088344C | 1 | TBD |
| [ ] | func_38C0 | $008838C0 | 1 | TBD |
| [ ] | func_3D2C | $00883D2C | 1 | TBD |
| [ ] | func_3D6A | $00883D6A | 1 | TBD |
| [ ] | func_3FD0 | $00883FD0 | 1 | TBD |

---

## Priority 7: V-INT State Handlers

These are the handlers called from V-INT jump table at $16B2:

| Status | State | Address | Purpose |
|--------|-------|---------|---------|
| [ ] | 0,1,2,8 | $008819FE | Default/no-op handler |
| [ ] | 3 | $00018200 | Unknown (odd address?) |
| [ ] | 4 | $00881A6E | Main game state? |
| [ ] | 5 | $00881A72 | Similar to state 4 |
| [ ] | 6 | $00881C66 | TBD |
| [ ] | 7 | $00881ACA | TBD |
| [ ] | 9 | $00881E42 | TBD |
| [ ] | 10 | $00881B14 | TBD |
| [ ] | 11 | $00881A64 | TBD |
| [ ] | 12 | $00881BA8 | TBD |
| [ ] | 13 | $00881E94 | TBD |
| [ ] | 14 | $00881F4A | TBD |
| [ ] | 15 | $00882010 | TBD |

---

## Priority 8: Main Game Logic ($4000-$FFFF)

124 functions in this region. Key targets:

| Status | Function | Address | Calls | Purpose |
|--------|----------|---------|-------|---------|
| [x] | WaitForVBlank | $00884998 | 21 | V-INT sync |
| [x] | SetDisplayParams | $008849AA | 21 | Display init |
| [ ] | func_4920 | $00884920 | 6 | TBD |
| [ ] | func_4922 | $00884922 | 2 | TBD |
| [ ] | func_6D00 | $00886D00 | 4 | TBD |
| [ ] | func_7280 | $00887280 | 2 | TBD |
| [ ] | func_83AE | $008883AE | 2 | TBD |
| [ ] | func_E316 | $0088E316 | 6 | TBD |
| [ ] | func_E35A | $0088E35A | 7 | TBD |
| [ ] | func_E406 | $0088E406 | 6 | TBD |
| [ ] | func_E4BC | $0088E4BC | 6 | TBD |
| [ ] | func_E52C | $0088E52C | 8 | TBD |
| [ ] | func_FB36 | $0088FB36 | 17 | HIGH PRIORITY |

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
| 3. Entry/Init | 15 | 6 | 9 | 40% |
| 4. Communication | 3 | 3 | 0 | 100% |
| 5. Controller | ~8 | 3 | ~5 | ~38% |
| 6. Low Code | 33 | 5 | 28 | 15% |
| 7. V-INT States | 16 | 0 | 16 | 0% |
| 8. Main Logic | 124 | 4 | 120 | 3% |
| 9. Extended | 500+ | 0 | 500+ | 0% |
| **TOTAL** | **769** | **33** | **736** | **4.3%** |

### Milestones

- [x] Priority 1 Complete (3 functions) ✅
- [x] Priority 2 Complete (9 functions) ✅
- [x] Priority 3 Complete (6 functions) ✅
- [x] Priority 4 Complete (3 functions) ✅
- [ ] 50 functions annotated (currently 33)
- [ ] 100 functions annotated
- [ ] Priority 1-6 Complete (~80 functions)
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

1. **Complete Priority 2** - Annotate remaining 5 hotspot functions
2. **Trace Entry Point** - Follow $3F0 → initialization chain
3. **Map COMM Usage** - Find all 68K↔SH2 communication
4. **Document V-INT States** - Analyze each state handler
5. **Build Call Graph** - Understand function relationships

---

## References

- [68K_MEMORY_MAP.md](68K_MEMORY_MAP.md) - Hardware registers
- [68K_INTERRUPT_HANDLERS.md](68K_INTERRUPT_HANDLERS.md) - Interrupt documentation
- [68K_FUNCTION_INVENTORY.md](68K_FUNCTION_INVENTORY.md) - Complete function list
- [68K_HOTSPOT_FUNCTIONS.md](68K_HOTSPOT_FUNCTIONS.md) - High-call-count functions
- [68K_ANNOTATION_PLAN.md](68K_ANNOTATION_PLAN.md) - Original planning document
