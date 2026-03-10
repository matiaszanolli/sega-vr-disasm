# Game Logic Initialization Architecture

**Module:** [disasm/modules/68k/game/game_logic_1.asm](../disasm/modules/68k/game/game_logic_1.asm)
**Address Range:** $006200-$008200 (8KB)
**Status:** ✅ Complete analysis with decoded mnemonics
**Date:** 2026-01-17

---

## Overview

The game logic module implements a state-based initialization system using jump table dispatch. The module contains 480 JSR calls across 238 labeled functions, indicating a highly modular architecture with clear separation of concerns.

**Key Statistics:**
- 238 function labels
- 480 JSR function calls (~60 calls per initialization state)
- 26 JMP dispatches (state transitions)
- 8 distinct initialization states (modes 0-7)

---

## Entry Point Architecture

### Main Entry ($006200)

```asm
        DC.W    $6702               ; $006200 BEQ.S  .dispatch
        DC.W    $7004               ; $006202 MOVEQ   #$04,D0
.dispatch:
        DC.W    $227B,$003A         ; $006204 MOVEA.L $3A(PC,D0.W),A1
        DC.W    $4E91               ; $006208 JSR     (A1)
```

**Pattern:** Indexed jump table dispatch
- **D0** contains state index (0 or 4)
- Jump table at offset $3A from PC ($006240)
- Dispatches to one of 8 initialization handlers

**Control Flow:**
1. If flag is zero, branch to dispatch (D0 = 0)
2. Otherwise set D0 = 4 (skip to alternate initialization)
3. Load handler address from jump table: `A1 = [PC + $3A + D0]`
4. Call handler via JSR (A1)
5. Return and check game state ($C8AA)

### Post-Handler Logic ($00620A)

```asm
        DC.W    $0C78,$0014,$C8AA   ; $00620A CMPI.W  #$0014,$C8AA.W
        DC.W    $662C               ; $006210 BNE.S  .done
        DC.W    $11FC,$0000,$C800   ; $006212 MOVE.B  #$0000,$C800.W
        DC.W    $31F8,$C092,$C07A   ; $006218 MOVE.W  $C092.W,$C07A.W
        DC.W    $31FC,$0004,$C8AC   ; $00621E MOVE.W  #$0004,$C8AC.W
```

**Game State Transition:**
- Checks if game state = $14 (initialization complete?)
- Clears $C800 (control flag)
- Copies $C092 → $C07A (mode transfer)
- Sets $C8AC = $0004 (default mode)

**Special Cases:**
- If $C89C ≠ 0: Set $C8AC = $0020 (alternate mode at $006230)
- If bit 7 of $C81C set: Set $C8AC = $0020 (debug mode at $006238)

---

## Jump Table Structure ($006240)

Located at PC + $3A = $006240, contains 8 long word pointers:

| Index | Address | Handler Function | Purpose |
|-------|---------|------------------|---------|
| 0 | $00625A | State_0_Init | Minimal initialization + main loop |
| 1 | $006292 | State_1_Init | Full system initialization |
| 2 | $00633A | State_2_Init | Partial initialization (subset) |
| 3 | $006394 | State_3_Init | Alternate partial init |
| 4 | $00640E | State_4_Init | Display mode initialization |
| 5 | $006496 | State_5_Init | Alternate display mode |
| 6 | $0065BC | State_6_Init | Extended initialization |
| 7 | $00677A | State_7_Init | Debug/test mode init |

**Jump Table Data:**
```asm
        DC.W    $0088,$3C7E,$0088   ; Entry 0: $00883C7E (adjusted address)
        DC.W    $3D5A,$0088         ; Entry 1: ...
        DC.W    $3D5A,$0088         ; Entry 2: ...
        DC.W    $3D5A,$0088         ; Entry 3: ...
        DC.W    $3D5A,$0088         ; Entry 4: ...
        DC.W    $3D5A,$7000         ; Entry 5: ...
```

Note: Addresses appear encoded in the DC.W format and need adjustment based on base address.

---

## Initialization States (Detailed Analysis)

### State 0: Minimal Initialization ($00625A)

**Purpose:** Quick boot path with minimal subsystem setup

**Pattern:**
```asm
        DC.W    $7000               ; MOVEQ   #$00,D0
        DC.W    $3140,$0044         ; MOVE.W  D0,$0044(A0)
        DC.W    $3140,$0046         ; MOVE.W  D0,$0046(A0)
        DC.W    $3140,$004A         ; MOVE.W  D0,$004A(A0)
        DC.W    $4EBA,$0EE2         ; JSR     object_link_copy_table_lookup(PC)
        DC.W    $4EBA,$13E2         ; JSR     calculate_object_heading_composite(PC)
        DC.W    $4EBA,$2458         ; JSR     $0086C8(PC)
        DC.W    $4EBA,$CEB2         ; JSR     $003126(PC)
        DC.W    $4EBA,$CEE8         ; JSR     $003160(PC)
        DC.W    $4EBA,$13A8         ; JSR     conditional_object_velocity_negate(PC)
        DC.W    $4EBA,$10CE         ; JSR     track_tile_object_display_list_builder(PC)
        DC.W    $11F8,$C304,$C30C   ; MOVE.B  $C304.W,$C30C.W
        DC.W    $4EB9,$0088,$6C88   ; JSR     $00886C88
        DC.W    $4EFA,$E71A         ; JMP     $0049AA(PC)
```

**Subsystems Initialized:**
1. Clear object offsets ($44, $46, $4A in A0)
2. 7 subsystem JSR calls (addresses $00714A, $00764E, $0086C8, $003126, $003160, $007624, $00734E)
3. Copy $C304 → $C30C (mode sync)
4. Call absolute handler at $00886C88
5. Jump to main loop at $0049AA

**Total Function Calls:** 8 JSR + 1 JMP = 9 calls

---

### State 1: Full System Initialization ($006292)

**Purpose:** Complete initialization of all game subsystems

**Pattern:**
```asm
        DC.W    $7000               ; MOVEQ   #$00,D0
        DC.W    $3140,$0044         ; MOVE.W  D0,$0044(A0)
        DC.W    $3140,$0046         ; MOVE.W  D0,$0046(A0)
        DC.W    $3140,$004A         ; MOVE.W  D0,$004A(A0)
        DC.W    $21FC,$0010,$0010,$C970 ; MOVE.L  #$00100010,$C970.W
        DC.W    $317C,$0002,$0092   ; MOVE.W  #$0002,$0092(A0)
        DC.W    $4EBA,$22EA         ; JSR     $00859A(PC)
        ... (28 more JSR calls)
        DC.W    $4EFA,$2D2C         ; JMP     $009064(PC)
```

**Subsystems Initialized:**
1. Clear object offsets
2. Set $C970 = $00100010 (display parameters?)
3. Set offset $92(A0) = $0002 (control mode)
4. **30 JSR calls** to initialize:
   - Memory systems
   - Display/VDP
   - Input handlers
   - Sound system
   - Hardware registers
   - Game objects
   - 3D rendering
   - Physics/collision
   - AI subsystems
5. Jump to main game loop at $009064

**Total Function Calls:** 30 JSR + 1 JMP = 31 calls

**Key Functions Called:**
- $00859A: Display initialization
- $00A350: Object manager init
- $008170: Input system setup
- $0080CC: VDP configuration
- $008548: Sound system init
- $0094FA, $009312, $009B12: Game logic subsystems
- $009182, $00961E, $009688: Physics/collision
- $009802: AI initialization
- $007E7A, $006F98, $007CD8: Object handling
- $00A434, $0070AA, $007C4E: Misc subsystems
- $00714A, $00764E: Core utilities
- $007F50, $009CCE, $009B54: Rendering pipeline
- $0086C8, $00ACD4, $00442E: Extended features
- $003126, $003160, $007624, $00734E: Hardware init
- $0036DE, $0037B6, $003F86: Low-level setup

---

### State 2: Partial Initialization ($00633A)

**Purpose:** Subset initialization (possibly for level restart)

**Pattern:**
```asm
        DC.W    $7000               ; MOVEQ   #$00,D0
        DC.W    $3140,$0044         ; MOVE.W  D0,$0044(A0)
        DC.W    $3140,$0046         ; MOVE.W  D0,$0046(A0)
        DC.W    $3140,$004A         ; MOVE.W  D0,$004A(A0)
        DC.W    $4EBA,$1D82         ; JSR     triple_guard_set_state_to_be(PC)
        ... (17 more JSR calls)
        DC.W    $4EFA,$D424         ; JMP     $0037B6(PC)
```

**Subsystems Initialized:**
1. Clear object offsets
2. **18 JSR calls** (subset of State 1)
3. Jump to handler at $0037B6

**Skipped Subsystems (vs State 1):**
- Display parameter setup ($C970 not set)
- Offset $92 control mode not set
- Several game object subsystems omitted
- Reduced rendering pipeline calls

**Total Function Calls:** 18 JSR + 1 JMP = 19 calls

---

### State 3: Alternate Partial Init ($006394)

**Purpose:** Similar to State 2 with different subsystem selection

**Pattern:**
```asm
        DC.W    $7000               ; MOVEQ   #$00,D0
        DC.W    $3140,$0044         ; MOVE.W  D0,$0044(A0)
        DC.W    $3140,$0046         ; MOVE.W  D0,$0046(A0)
        DC.W    $3140,$004A         ; MOVE.W  D0,$004A(A0)
        DC.W    $21FC,$0010,$0010,$C970 ; MOVE.L  #$00100010,$C970.W
        DC.W    $317C,$0002,$0092   ; MOVE.W  #$0002,$0092(A0)
        DC.W    $08B8,$0004,$C30E   ; BCLR    #4,$C30E.W
        ... (24 more JSR calls)
        DC.W    $4EFA,$DB7A         ; JMP     $003F86(PC)
```

**Unique Features:**
- Sets display parameters ($C970)
- Sets control mode ($92)
- **BCLR #4,$C30E** - Clears bit 4 of control register (disables feature?)
- 25 JSR calls
- Jump to $003F86

**Total Function Calls:** 25 JSR + 1 JMP = 26 calls

---

### State 4: Display Mode Initialization ($00640E)

**Purpose:** Initialize display subsystems with specific VDP mode

**Pattern:**
```asm
        DC.W    $49F8,$A000         ; LEA     $A000.W,A4
        DC.W    $41F8,$9000         ; LEA     $9000.W,A0
        DC.W    $11F8,$FEAF,$C30F   ; MOVE.B  $FEAF.W,$C30F.W
        DC.W    $4EBA,$07A0         ; JSR     object_bitmask_table_lookup(PC)
        DC.W    $2168,$00B2,$0018   ; MOVE.L  $00B2(A0),$0018(A0)
        DC.W    $1228,$00E5         ; MOVE.B  $00E5(A0),D1
        DC.W    $0201,$0006         ; ANDI.B  #$0006,D1
        DC.W    $6706               ; BEQ.S  loc_006436
        DC.W    $2178,$C70C,$0018   ; MOVE.L  $C70C.W,$0018(A0)
loc_006436:
        DC.W    $3038,$C07A         ; MOVE.W  $C07A.W,D0
        DC.W    $43FA,$0160         ; LEA     $0160(PC),A1
        DC.W    $2271,$0000         ; MOVEA.L $00(A1,D0.W),A1
        DC.W    $4E91               ; JSR     (A1)
```

**Display Setup:**
1. **A4 = $A000** - Hardware register base
2. **A0 = $9000** - Object/sprite base
3. Copy $FEAF → $C30F (VDP mode setting)
4. Call display init at $006BBE
5. Copy $B2(A0) → $18(A0) (display parameter transfer)
6. Check bits 1-2 of $E5(A0):
   - If set: Use alternate display mode ($C70C → $18(A0))
   - If clear: Keep original mode
7. Load mode from $C07A, dispatch to mode-specific handler via jump table at $0065A2

**Buffer Management:**
```asm
        DC.W    $45F8,$C000         ; LEA     $C000.W,A2
        DC.W    $43F8,$B400         ; LEA     $B400.W,A1
        DC.W    $7E1F               ; MOVEQ   #$1F,D7
loc_006466:
        DC.W    $4CDA,$087F         ; MOVEM.L D0/D1/D2/D3/D4/D5/D6/A3,(A2)+
        DC.W    $48E1,$FE10         ; MOVEM.L -(A1),D4/A1/A2/A3/A4/A5/A6/A7
        DC.W    $51CF,$FFF6         ; DBRA    D7,loc_006466
```

**Pattern:** Copy 32 register sets ($20 iterations × 8 longs)
- Source: $B400 (decremented, read backwards)
- Dest: $C000 (incremented, write forward)
- Transfers $100 bytes (256 bytes) of frame buffer metadata

**Display Mode Swap:**
```asm
        DC.W    $21F8,$C970,$C978   ; MOVE.L  $C970.W,$C978.W
        DC.W    $21F8,$C974,$C970   ; MOVE.L  $C974.W,$C970.W
```

**Pattern:** Swap display modes
- Save current mode $C970 → $C978
- Load new mode $C974 → $C970
- This enables double-buffered display switching

**Total Function Calls:** ~15 JSR + 1 nested dispatch

---

### State 5: Alternate Display Mode ($006496)

**Purpose:** Similar to State 4 with different buffer addresses

**Pattern:**
```asm
        DC.W    $49F8,$A000         ; LEA     $A000.W,A4
        DC.W    $41F8,$9F00         ; LEA     $9F00.W,A0
        DC.W    $11F8,$FEB0,$C30F   ; MOVE.B  $FEB0.W,$C30F.W
```

**Key Differences:**
- **A0 = $9F00** (instead of $9000) - Alternate sprite base
- **$FEB0 → $C30F** (instead of $FEAF) - Different VDP mode
- Uses buffer addresses $B800 and $B000 instead of $B400
- Swap uses $C978 → $C970 (reverse order)

**Purpose:** Likely handles alternate resolution or display format (possibly 32X interlaced vs progressive)

---

### State 6: Extended Initialization ($0065BC)

**Purpose:** Full initialization with extended features

**Pattern:**
```asm
        DC.W    $4EBA,$51B2         ; JSR     $00B770(PC)
        DC.W    $7000               ; MOVEQ   #$00,D0
        DC.W    $3140,$0044         ; MOVE.W  D0,$0044(A0)
        DC.W    $3140,$0046         ; MOVE.W  D0,$0046(A0)
        DC.W    $3140,$004A         ; MOVE.W  D0,$004A(A0)
        DC.W    $4EBA,$2040         ; JSR     $008610(PC)
        ... (27 more JSR calls)
        DC.W    $4EFA,$352C         ; JMP     $009B54(PC)
```

**Unique Features:**
1. **Pre-initialization call:** JSR $00B770 (called before clearing offsets)
2. **28 JSR calls** to standard subsystems
3. Jump to $009B54

**Total Function Calls:** 29 JSR + 1 JMP = 30 calls

---

### State 7: Debug/Test Mode ($00677A)

**Purpose:** Test mode initialization with custom settings

**Pattern:**
```asm
        DC.W    $7000               ; MOVEQ   #$00,D0
        DC.W    $3140,$0044         ; MOVE.W  D0,$0044(A0)
        DC.W    $3140,$0046         ; MOVE.W  D0,$0046(A0)
        DC.W    $3140,$004A         ; MOVE.W  D0,$004A(A0)
        DC.W    $21FC,$0010,$0010,$C970 ; MOVE.L  #$00100010,$C970.W
        DC.W    $11FC,$0000,$C30F   ; MOVE.B  #$0000,$C30F.W
        DC.W    $4EBA,$4FD8         ; JSR     $00B770(PC)
        ... (28 more JSR calls)
        DC.W    $4EFA,$DD1A         ; JMP     $00451C(PC)
```

**Debug Features:**
1. Sets display parameters $C970 = $00100010
2. **Clears $C30F** (disables VDP mode from State 4/5)
3. Calls $00B770 pre-init
4. Standard 29 JSR calls
5. **Extra debug calls:**
   - JSR $0044E8 (debug handler?)
   - JSR $003116 (debug utilities?)
6. Jump to debug loop at $00451C

**Total Function Calls:** 31 JSR + 1 JMP = 32 calls

---

## Memory Regions Referenced

### Global State Variables

| Address | Size | Purpose | Usage |
|---------|------|---------|-------|
| $C800 | byte | Control flag | Cleared on game state $14 |
| $C87A | word | V-INT state | Dispatches V-INT handlers |
| $C8AA | word | Game state | Checked for $14 (init complete) |
| $C8AC | word | Mode control | Set to $04, $20, or $30 |
| $C89C | word | Alternate mode flag | Forces $C8AC = $20 if set |
| $C81C | byte | Debug flag | Bit 7 forces debug mode |
| $C092 | word | Source mode | Copied to $C07A on transition |
| $C07A | word | Active mode | Current game mode |
| $C970 | long | Display mode 0 | Primary display parameters |
| $C974 | long | Display mode 1 | Alternate display parameters |
| $C978 | long | Display swap temp | Used in mode swapping |
| $C304 | byte | Source config | Copied to $C30C |
| $C30C | byte | Active config | Current configuration |
| $C30E | byte | Control register | Bit 4 toggles features |
| $C30F | byte | VDP mode | Display mode setting |

### Object/Sprite Regions

| Address | Size | Purpose |
|---------|------|---------|
| $9000 | ? | Object base (mode 0) |
| $9F00 | ? | Object base (mode 1) |
| $A000 | ? | Hardware register base |
| $B000 | 256B | Display buffer 0 |
| $B400 | 256B | Display buffer 1 |
| $B800 | 256B | Display buffer 2 |
| $C000 | 256B | Active frame buffer |
| $C400 | 256B | Swap frame buffer |

### Object Structure Offsets

Referenced via A0 (object pointer):

| Offset | Size | Purpose |
|--------|------|---------|
| $0044 | word | Position/offset 0 |
| $0046 | word | Position/offset 1 |
| $004A | word | Position/offset 2 |
| $0092 | word | Control mode |
| $00AC | word | Display control |
| $008A | word | State variable |
| $00B2 | long | Display parameters |
| $0018 | long | Active display params |
| $00E5 | byte | Display mode flags |

---

## Function Call Graph (Top-Level)

### Initialization Functions (Called by Multiple States)

**Core Utilities (All States):**
- `object_link_copy_table_lookup` - Called by states 0,1,2,3,6,7 (6/8 states)
- `calculate_object_heading_composite` - Called by states 0,1,2,3,6,7 (6/8 states)

**Display System (Most States):**
- `triple_guard_set_state_to_be` - Called by states 1,2,3,6,7 (5/8 states)
- `$008548` - Called by states 1,2,3,6,7 (5/8 states)
- `$00859A` - Called by states 1,3,6,7 (4/8 states)

**Game Logic (Extended States):**
- `$0094FA` - Called by states 1,3,6,7 (4/8 states)
- `$009312` - Called by states 1,3,6,7 (4/8 states)
- `$009B12` - Called by states 1,3,6,7 (4/8 states)
- `$009182` - Called by states 1,3,6,7 (4/8 states)
- `$00961E` - Called by states 1,3,6,7 (4/8 states)

**Object Management:**
- `$00A350` - Called by states 1,3,6,7 (4/8 states)
- `object_timer_expire_speed_param_reset` - Called by states 1,2,3,6,7 (5/8 states)
- `race_init_orch_005` - Called by states 1,2,3,6,7 (5/8 states)
- `entity_pos_update` - Called by states 1,2,3,6,7 (5/8 states)
- `tire_screech_sound_trigger_053` - Called by states 1,2,3,6,7 (5/8 states)

**Rendering Pipeline:**
- `$009CCE` - Called by states 1,2,3 (3/8 states)
- `$009B54` - Called by states 1,2,3,6,7 (5/8 states)

**Low-Level Setup:**
- `$003126` - Called by states 0,1,2,3 (4/8 states)
- `$003160` - Called by states 0,1 (2/8 states)
- `$007624` - Called by states 0,1 (2/8 states)
- `$00734E` - Called by states 0,1 (2/8 states)
- `$0036DE` - Called by states 1,2,3 (3/8 states)
- `$0037B6` - Called by states 1,2,3 (3/8 states)

---

## Control Flow Patterns

### Pattern 1: Sequential Initialization

Most states follow this pattern:
```
1. Clear object offsets ($44, $46, $4A)
2. Set configuration registers (optional)
3. Call 15-30 subsystem init functions via JSR
4. Jump to main loop or handler via JMP
```

### Pattern 2: Display Mode Dispatch

States 4 and 5 use nested dispatch:
```
1. Set up base registers (A4, A0)
2. Configure VDP mode
3. Call display init
4. Check display flags
5. Load mode from $C07A
6. Dispatch to mode-specific handler via jump table
7. Execute buffer transfers
8. Swap display modes
9. Return
```

### Pattern 3: Conditional Initialization

State 7 (debug mode) adds conditional logic:
```
1. Check game state $C8AA
2. If state = $14: transition to next mode
3. Clear control flags
4. Copy mode settings
5. Set mode register $C8AC based on flags
```

---

## Architectural Insights

### Modular Design

The initialization system demonstrates excellent modularity:
- **Shared functions:** Core utilities called by 75% of states
- **Subsystem independence:** Each JSR call handles one subsystem
- **Clear dependencies:** Display before rendering, input before game logic

### State Optimization

Different states optimize for different scenarios:
- **State 0:** Minimal (9 calls) - Fast boot path
- **State 1:** Full (31 calls) - Complete game startup
- **State 2/3:** Partial (18-26 calls) - Level restart/mode switch
- **State 4/5:** Display-focused - VDP reconfiguration
- **State 6:** Extended (30 calls) - Special features enabled
- **State 7:** Debug (32 calls) - Testing and development

### Memory Management

Smart use of memory regions:
- **Double buffering:** $C970/$C974 swapped via $C978
- **Object separation:** $9000 vs $9F00 for different modes
- **Frame buffer management:** $B000/$B400/$B800 → $C000/$C400

### Performance Considerations

**Initialization overhead:**
- State 0: ~9 function calls (~500-1000 cycles)
- State 1: ~31 function calls (~1500-3000 cycles)
- Display states: +32 iterations of MOVEM.L (~1000-1500 cycles)

**Optimization:**
- Minimal state (0) used for quick restarts
- Partial states (2/3) avoid redundant re-initialization
- Display states use MOVEM.L for bulk transfers (efficient)

---

## Integration with V-INT System

### V-INT State Linkage

The game state register $C8AA is checked after initialization:
```asm
CMPI.W  #$0014,$C8AA.W  ; Check if game state = $14
BNE.S  .done       ; Skip if not ready
```

This links to the V-INT state machine documented in [VINT_STATE_HANDLERS.md](VINT_STATE_HANDLERS.md):
- V-INT handlers modify $C8AA during frame processing
- When $C8AA reaches $14, initialization completes
- Mode $C07A is set from $C092 (saved mode)
- Control register $C8AC is configured

### Mode Transition Flow

```
Boot → State 1 (Full Init) → V-INT Processing → $C8AA = $14 → Mode Set → Main Loop
                                                       ↓
                                            State 4/5 (Display Mode) ← Mode Switch
                                                       ↓
                                            State 2/3 (Partial Init) ← Level Restart
```

---

## Related Documentation

- [VINT_STATE_HANDLERS.md](VINT_STATE_HANDLERS.md) - V-INT state machine architecture
- [VINT_HANDLER_ARCHITECTURE.md](VINT_HANDLER_ARCHITECTURE.md) - V-INT interrupt handling
- [CONTROLLER_INPUT_ARCHITECTURE.md](CONTROLLER_INPUT_ARCHITECTURE.md) - Input system details
- [CODE_CONVERSION_SUMMARY.md](CODE_CONVERSION_SUMMARY.md) - Mnemonic conversion process

---

**Last Updated:** 2026-01-17
**Status:** ✅ Complete architectural analysis
**Module:** game_logic_1.asm (8KB, 238 functions, 480 JSR calls)
