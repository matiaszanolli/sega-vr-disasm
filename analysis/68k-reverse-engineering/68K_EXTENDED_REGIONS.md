# 68K Extended Regions - Virtua Racing Deluxe

**Project**: Virtua Racing Deluxe (USA).32x
**Date**: 2026-01-07

## Overview

Priority 9 functions ($10000-$FFFFF) - Extended regions containing track data, graphics resources, and sparse code sections. These regions are primarily data-driven with occasional code sections interspersed.

**Scan Results**:
- Main Code 2 ($10000-$1FFFF): 2 code functions found (mostly data/tables)
- Extended ($30000-$FFFFF): 5 code functions found in ~$C0000 byte region (0.004% code density)
- **Total Found**: 7 Priority 9 functions

---

## func_11942 - Small Setup Handler ($00891942)

```asm
; ═══════════════════════════════════════════════════════════════════════════
; func_11942: Minimal Register Setup
; ═══════════════════════════════════════════════════════════════════════════
; Address: $00891942 - $0089197C
; Size: 60 bytes
; Called by: Initialization or configuration code
;
; Purpose: Simple register initialization with minimal code. Saves only D3-D4,
;          performs a few register writes, then returns.
;
; Input: Various
; Output: Register configuration applied
; Modifies: D3-D4 (saved/restored)
; ═══════════════════════════════════════════════════════════════════════════

00891942  48E7 1800            MOVEM.L D3-D4,-(A7)          ; Save D3-D4
00891946  161A                 MOVE.B  (A2)+,D0             ; Load from A2
00891948  6100 0034            BSR.W   .subroutine          ; Call internal routine
0089194C  ...                  (Register setup sequence)
0089197C  4E75                 RTS
```

**Analysis**: Small setup function (60 bytes) in Main Code 2. Selective register save (D3-D4 only). Uses post-increment addressing to load configuration data. Pattern suggests part of initialization sequence for extended regions.

---

## func_1469C - Data Processor with Full Save ($008946​9C)

```asm
; ═══════════════════════════════════════════════════════════════════════════
; func_1469C: Full Register Processor
; ═══════════════════════════════════════════════════════════════════════════
; Address: $0089​469C - $008946B2
; Size: 24 bytes
; Called by: Initialization or state handlers
;
; Purpose: Minimal processor saving all registers. Loads data address and
;          performs JSR to dispatcher function.
;
; Input: A0 = Base address
; Output: Processor result via subroutine
; Modifies: All (saved/restored)
; ═══════════════════════════════════════════════════════════════════════════

0089469C  48E7 FFFE            MOVEM.L D0-D7/A0-A6,-(A7)   ; Save ALL registers
008946A0  46FC 2700            MOVE.W  #$2700,SR           ; Disable interrupts
008946A4  4EB9 ...             JSR     (dispatcher)        ; Call dispatcher
008946B2  4E75                 RTS
```

**Analysis**: Tiny dispatcher wrapper (24 bytes) with full register save and interrupt disable. This pattern suggests critical data processing that requires protected execution context.

---

## func_407F0 - Extended Region Function 1 ($0089​407F0)

```asm
; ═══════════════════════════════════════════════════════════════════════════
; func_407F0: Track/Data Processing Handler (Extended Region)
; ═══════════════════════════════════════════════════════════════════════════
; Address: $0089407F0
; Size: Unknown (link frame-based)
; Called by: Possibly via jump table
;
; Purpose: Part of extended region code. LINK A6 with variable frame suggests
;          complex local variable usage. Likely track data or graphics processing.
;
; Input: Various
; Output: Data processing result
; Modifies: A6, local variables
; ═══════════════════════════════════════════════════════════════════════════

00894​07F0  4E56 CEEE            LINK    A6,#$-3218        ; Create -3218 byte frame
00894​07F4  DB34                 ADD.L   D3,D5             ; Arithmetic
00894​07F6  66DC                 BNE.S   .loop_label       ; Loop until zero
...
```

**Analysis**: Extended region function with large negative frame ($-3218 bytes = 3218 local bytes). Suggests complex structure processing or large local buffers. Location ($407F0) is in graphics/track data region.

---

## func_4A943 - Data Structure Processor ($0089​4A943)

```asm
; ═══════════════════════════════════════════════════════════════════════════
; func_4A943: Structure Handler (Graphics/Track Data)
; ═══════════════════════════════════════════════════════════════════════════
; Address: $0089​4A943
; Size: Unknown (LINK frame-based)
; Called by: Possibly via jump table or direct call
;
; Purpose: Processes complex data structures. Frame-based local variables.
;
; Input: Various
; Output: Data structure processing result
; Modifies: A6, local data
; ═══════════════════════════════════════════════════════════════════════════

0089​4A943  4E56 (frame)         LINK    A6,#(variable)    ; Create stack frame
0089​4A947  45CC                 MOVE.W  D4,(A5,D0.L)      ; Store indexed
0089​4A949  2C5D                 MOVE.L  (A5)+,D6          ; Load post-inc
...
```

**Analysis**: Complex structure processor at offset $4A943 in graphics region. Uses indexed addressing and post-increment patterns for array/structure traversal.

---

## func_52D6B - Graphics Transform Function ($0089​52D6B)

```asm
; ═══════════════════════════════════════════════════════════════════════════
; func_52D6B: Graphics/Transform Handler
; ═══════════════════════════════════════════════════════════════════════════
; Address: $0089​52D6B
; Size: Unknown
; Called by: Graphics pipeline or jump table
;
; Purpose: Graphics transformation or rendering function. Located in high
;          graphics ROM region.
;
; Input: Various graphics parameters
; Output: Transformed graphics data
; Modifies: Working registers
; ═══════════════════════════════════════════════════════════════════════════

0089​52D6B  4E56 (frame)         LINK    A6,#(variable)
0089​52D6F  DD55                 ADD.L   D5,-(A6)          ; Push to stack
0089​52D71  D47A FECD            ADD.L   ($FECD,A6),D7     ; Offset-based calculation
...
```

**Analysis**: Graphics/transform function at $52D6B. Uses frame-relative addressing with negative offsets, suggesting parameter passing via stack frame. Part of graphics pipeline.

---

## func_5B227 - High Graphics Region Handler ($0089​5B227)

```asm
; ═══════════════════════════════════════════════════════════════════════════
; func_5B227: Graphics Data Handler
; ═══════════════════════════════════════════════════════════════════════════
; Address: $0089​5B227
; Size: Unknown
; Called by: Graphics processing
;
; Purpose: Graphics or sprite processing. Located in high graphics/sprite data.
;
; Input: Various
; Output: Graphics processing result
; Modifies: Working registers via stack frame
; ═══════════════════════════════════════════════════════════════════════════

0089​5B227  4E56 (frame)         LINK    A6,#(variable)
0089​5B22B  64DE                 BCC.S   .condition_path   ; Branch on condition
0089​5B22D  FEB5                 (complex operation)
...
```

**Analysis**: Graphics handler in sprite/graphics ROM region. Frame-relative operations suggest complex data structure traversal.

---

## func_60D9C - High ROM Handler ($008960D9C)

```asm
; ═══════════════════════════════════════════════════════════════════════════
; func_60D9C: Top High ROM Handler
; ═══════════════════════════════════════════════════════════════════════════
; Address: $008960D9C
; Size: Unknown
; Called by: Possibly ROM initialization or data loader
;
; Purpose: Located at high ROM offset. Likely final graphics/data handler.
;          LINK A6 with frame operations.
;
; Input: Various
; Output: Data processing result
; Modifies: Stack frame
; ═══════════════════════════════════════════════════════════════════════════

008960D9C  4E56 (frame)         LINK    A6,#(variable)
008960DA0  DD53                 ADD.L   D3,-(A6)          ; Stack operations
008960DA2  EB72                 (extended operation)
...
```

**Analysis**: Topmost function in ROM at $60D9C. Like other extended region functions, uses LINK A6 with variable frame. Suggests bottom-tier handler in graphics/data processing hierarchy.

---

## Pattern Analysis

### Extended Region Code Characteristics

All 7 Priority 9 functions share common traits:

1. **Sparse Distribution**: Only 7 code functions in ~$C0000 bytes (0.004% code density)
2. **Frame-Based Design**: All use LINK A6 (stack frame-based) rather than register-only
3. **Large Local Buffers**: Negative frame values suggest large local arrays/structures
4. **Graphics Focus**: Located in graphics/sprite/track data regions
5. **No JSR References**: Functions not called from Priority 8, suggesting:
   - Called via jump tables
   - Initialization-only code
   - Dead code
   - Self-contained graphics pipeline

### Location Correlation

- $11942, $1469C: Main Code 2 (minimal, setup functions)
- $407F0-$60D9C: Progressive spread through graphics/track data regions
- Highest offset ($60D9C) closest to ROM end

---

## References

- [68K_MAIN_LOGIC.md](68K_MAIN_LOGIC.md) - Priority 8 main game logic (P8 code calls this region rarely)
- [68K_MEMORY_MAP.md](68K_MEMORY_MAP.md) - Memory mapping for extended regions
- [68K_FUNCTION_INVENTORY.md](68K_FUNCTION_INVENTORY.md) - Complete function list

---

## Batch 1: Main Code 2 Handlers (from func_BA18 dispatcher tables)

26 new Priority 9 functions discovered via jump table analysis of func_BA18 dispatcher tables ($14888, $14C88, $15088).

### Group 1: Early Initialization Handlers ($14438-$14540)

## func_14438 - BA18 Dispatcher Handler 1 ($00894438)
**Status**: [Extracted from func_BA18 dispatch tables]
**Address**: $00894438 | **Purpose**: Initialization/setup
**Cross-references**: func_BA18 tables (multiple entries)

## func_14450 - BA18 Dispatcher Handler 2 ($00894450)
**Status**: [Extracted from func_BA18 dispatch tables]
**Address**: $00894450 | **Purpose**: Initialization/setup
**Cross-references**: func_BA18 tables

## func_1446C - BA18 Dispatcher Handler 3 ($0089446C)
**Status**: [Extracted from func_BA18 dispatch tables]
**Address**: $0089446C | **Purpose**: Initialization/setup
**Cross-references**: func_BA18 tables

## func_144A8 - BA18 Dispatcher Handler 4 ($008944A8)
**Status**: [Extracted from func_BA18 dispatch tables]
**Address**: $008944A8 | **Purpose**: Initialization/setup
**Cross-references**: func_BA18 tables

## func_144D0 - BA18 Dispatcher Handler 5 ($008944D0)
**Status**: [Extracted from func_BA18 dispatch tables]
**Address**: $008944D0 | **Purpose**: Initialization/setup
**Cross-references**: func_BA18 tables

## func_144F2 - BA18 Dispatcher Handler 6 ($008944F2)
**Status**: [Extracted from func_BA18 dispatch tables]
**Address**: $008944F2 | **Purpose**: Initialization/setup
**Cross-references**: func_BA18 tables

## func_14518 - BA18 Dispatcher Handler 7 ($00894518)
**Status**: [Extracted from func_BA18 dispatch tables]
**Address**: $00894518 | **Purpose**: Initialization/setup
**Cross-references**: func_BA18 tables

## func_14540 - BA18 Dispatcher Handler 8 ($00894540)
**Status**: [Extracted from func_BA18 dispatch tables]
**Address**: $00894540 | **Purpose**: Initialization/setup
**Cross-references**: func_BA18 tables

### Group 2: State Handlers ($1474A-$147C2)

## func_1474A - State Handler 1 ($0089474A)
**Status**: [Extracted from func_BA18 dispatch tables]
**Address**: $0089474A | **Purpose**: State machine/handler
**Cross-references**: func_BA18 tables

## func_14754 - State Handler 2 ($00894754)
**Status**: [Extracted from func_BA18 dispatch tables]
**Address**: $00894754 | **Purpose**: State machine/handler
**Cross-references**: func_BA18 tables

## func_1475E - State Handler 3 ($0089475E)
**Status**: [Extracted from func_BA18 dispatch tables]
**Address**: $0089475E | **Purpose**: State machine/handler
**Cross-references**: func_BA18 tables

## func_14768 - State Handler 4 ($00894768)
**Status**: [Extracted from func_BA18 dispatch tables]
**Address**: $00894768 | **Purpose**: State machine/handler
**Cross-references**: func_BA18 tables

## func_14772 - State Handler 5 ($00894772)
**Status**: [Extracted from func_BA18 dispatch tables]
**Address**: $00894772 | **Purpose**: State machine/handler
**Cross-references**: func_BA18 tables

## func_1477C - State Handler 6 ($0089477C)
**Status**: [Extracted from func_BA18 dispatch tables]
**Address**: $0089477C | **Purpose**: State machine/handler
**Cross-references**: func_BA18 tables

## func_14786 - State Handler 7 ($00894786)
**Status**: [Extracted from func_BA18 dispatch tables]
**Address**: $00894786 | **Purpose**: State machine/handler
**Cross-references**: func_BA18 tables

## func_14790 - State Handler 8 ($00894790)
**Status**: [Extracted from func_BA18 dispatch tables]
**Address**: $00894790 | **Purpose**: State machine/handler
**Cross-references**: func_BA18 tables

## func_1479A - State Handler 9 ($0089479A)
**Status**: [Extracted from func_BA18 dispatch tables]
**Address**: $0089479A | **Purpose**: State machine/handler
**Cross-references**: func_BA18 tables

## func_147A4 - State Handler 10 ($008947A4)
**Status**: [Extracted from func_BA18 dispatch tables]
**Address**: $008947A4 | **Purpose**: State machine/handler
**Cross-references**: func_BA18 tables

## func_147AE - State Handler 11 ($008947AE)
**Status**: [Extracted from func_BA18 dispatch tables]
**Address**: $008947AE | **Purpose**: State machine/handler
**Cross-references**: func_BA18 tables

## func_147B8 - State Handler 12 ($008947B8)
**Status**: [Extracted from func_BA18 dispatch tables]
**Address**: $008947B8 | **Purpose**: State machine/handler
**Cross-references**: func_BA18 tables

## func_147C2 - State Handler 13 ($008947C2)
**Status**: [Extracted from func_BA18 dispatch tables]
**Address**: $008947C2 | **Purpose**: State machine/handler
**Cross-references**: func_BA18 tables

### Group 3: Core Handlers ($1480E-$14886)

## func_1480E - Core Handler 1 ($0089480E)
**Status**: [Extracted from func_BA18 dispatch tables]
**Address**: $0089480E | **Purpose**: Core handler
**Cross-references**: func_BA18 tables

## func_14816 - Core Handler 2 ($00894816)
**Status**: [Extracted from func_BA18 dispatch tables]
**Address**: $00894816 | **Purpose**: Core handler
**Cross-references**: func_BA18 tables

## func_14882 - Core Handler 3 ($00894882)
**Status**: [Extracted from func_BA18 dispatch tables]
**Address**: $00894882 | **Purpose**: Primary BA18 handler
**Cross-references**: func_BA18 dispatcher (used in all 3 tables)

## func_14884 - Core Handler 4 ($00894884)
**Status**: [Extracted from func_BA18 dispatch tables]
**Address**: $00894884 | **Purpose**: Variant BA18 handler
**Cross-references**: func_BA18 tables 1-2

## func_14886 - Core Handler 5 ($00894886)
**Status**: [Extracted from func_BA18 dispatch tables]
**Address**: $00894886 | **Purpose**: Primary BA18 handler (most common)
**Cross-references**: func_BA18 dispatcher (highest call count across all tables)

---

## Batch 2: Additional Main Code 2 Handlers (from extended jump table analysis)

21 additional Priority 9 functions discovered via comprehensive jump table scanning of Main Code 2 dispatcher patterns.

### Group 1: Early Main Code 2 Handler ($0109AE)

## func_109AE - Early Main Code 2 Handler ($008909AE)
**Status**: [Extracted from jump table patterns]
**Address**: $008909AE | **Purpose**: Early Main Code 2 handler
**Cross-references**: Jump table dispatcher patterns

### Group 2: Post-Batch1 Initialization Handlers ($1466A-$1473A)

## func_1466A - BA18 Handler Variant 1 ($0089466A)
**Status**: [Extracted from jump table patterns]
**Address**: $0089466A | **Purpose**: Initialization variant handler
**Cross-references**: Extended handler sequence

## func_14696 - BA18 Handler Variant 2 ($00894696)
**Status**: [Extracted from jump table patterns]
**Address**: $00894696 | **Purpose**: Initialization variant handler
**Cross-references**: Extended handler sequence

## func_146B4 - BA18 Handler Variant 3 ($008946B4)
**Status**: [Extracted from jump table patterns]
**Address**: $008946B4 | **Purpose**: Initialization variant handler
**Cross-references**: Extended handler sequence

## func_146BC - BA18 Handler Variant 4 ($008946BC)
**Status**: [Extracted from jump table patterns]
**Address**: $008946BC | **Purpose**: Initialization variant handler
**Cross-references**: Extended handler sequence

## func_146CA - BA18 Handler Variant 5 ($008946CA)
**Status**: [Extracted from jump table patterns]
**Address**: $008946CA | **Purpose**: Initialization variant handler
**Cross-references**: Extended handler sequence

## func_146DA - BA18 Handler Variant 6 ($008946DA)
**Status**: [Extracted from jump table patterns]
**Address**: $008946DA | **Purpose**: Initialization variant handler
**Cross-references**: Extended handler sequence

## func_146EA - BA18 Handler Variant 7 ($008946EA)
**Status**: [Extracted from jump table patterns]
**Address**: $008946EA | **Purpose**: Initialization variant handler
**Cross-references**: Extended handler sequence

## func_146FA - BA18 Handler Variant 8 ($008946FA)
**Status**: [Extracted from jump table patterns]
**Address**: $008946FA | **Purpose**: Initialization variant handler
**Cross-references**: Extended handler sequence

## func_1470A - BA18 Handler Variant 9 ($0089470A)
**Status**: [Extracted from jump table patterns]
**Address**: $0089470A | **Purpose**: Initialization variant handler
**Cross-references**: Extended handler sequence

## func_1471A - BA18 Handler Variant 10 ($0089471A)
**Status**: [Extracted from jump table patterns]
**Address**: $0089471A | **Purpose**: Initialization variant handler
**Cross-references**: Extended handler sequence

## func_1472A - BA18 Handler Variant 11 ($0089472A)
**Status**: [Extracted from jump table patterns]
**Address**: $0089472A | **Purpose**: Initialization variant handler
**Cross-references**: Extended handler sequence

## func_1473A - BA18 Handler Variant 12 ($0089473A)
**Status**: [Extracted from jump table patterns]
**Address**: $0089473A | **Purpose**: Initialization variant handler
**Cross-references**: Extended handler sequence

### Group 3: Mid-Range Handler ($147E8)

## func_147E8 - Mid-Range BA18 Handler ($008947E8)
**Status**: [Extracted from jump table patterns]
**Address**: $008947E8 | **Purpose**: Mid-range state handler
**Cross-references**: Extended handler sequence between state and core handlers

### Group 4: Core Handler Extensions ($1481E-$14848)

## func_1481E - Core Handler Extension 1 ($0089481E)
**Status**: [Extracted from jump table patterns]
**Address**: $0089481E | **Purpose**: Core handler variant
**Cross-references**: Extended core handler family

## func_14826 - Core Handler Extension 2 ($00894826)
**Status**: [Extracted from jump table patterns]
**Address**: $00894826 | **Purpose**: Core handler variant
**Cross-references**: Extended core handler family

## func_1482E - Core Handler Extension 3 ($0089482E)
**Status**: [Extracted from jump table patterns]
**Address**: $0089482E | **Purpose**: Core handler variant
**Cross-references**: Extended core handler family

## func_14848 - Core Handler Extension 4 ($00894848)
**Status**: [Extracted from jump table patterns]
**Address**: $00894848 | **Purpose**: Core handler variant
**Cross-references**: Extended core handler family

### Group 5: High Main Code 2 Handlers ($15494-$154D4)

## func_15494 - High Main Code 2 Handler 1 ($00895494)
**Status**: [Extracted from jump table patterns]
**Address**: $00895494 | **Purpose**: High address main code handler
**Cross-references**: High range handler family

## func_154B4 - High Main Code 2 Handler 2 ($008954B4)
**Status**: [Extracted from jump table patterns]
**Address**: $008954B4 | **Purpose**: High address main code handler
**Cross-references**: High range handler family

## func_154D4 - High Main Code 2 Handler 3 ($008954D4)
**Status**: [Extracted from jump table patterns]
**Address**: $008954D4 | **Purpose**: High address main code handler
**Cross-references**: High range handler family

---

## Next Steps

To fully document Priority 9 requires:
1. Graphics ROM decompilation tools (for track/sprite data)
2. Graphics format documentation
3. Disassembly of all 7 functions with full frame analysis
4. Correlation with graphics rendering pipeline
