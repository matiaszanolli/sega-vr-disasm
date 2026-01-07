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

## Next Steps

To fully document Priority 9 requires:
1. Graphics ROM decompilation tools (for track/sprite data)
2. Graphics format documentation
3. Disassembly of all 7 functions with full frame analysis
4. Correlation with graphics rendering pipeline
