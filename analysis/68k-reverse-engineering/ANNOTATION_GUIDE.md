# SH2 3D Engine Annotation Guide

Instructions for systematically annotating the Virtua Racing Deluxe SH2 rendering engine.

## Context

- **ROM**: Virtua Racing Deluxe (USA).32x (3MB)
- **Region**: SH2 3D engine at ROM offset 0x23000-0x25000 (8KB)
- **Functions**: 109 total, only 5 annotated so far
- **Goal**: Understand every function's purpose before optimization

## Tools Available

### Disassembler
```bash
python3 tools/sh2_disasm.py "Virtua Racing Deluxe (USA).32x" <offset> <instruction_count>
```
- `offset`: Hex ROM offset (e.g., 0x23500)
- `instruction_count`: Number of instructions to disassemble (e.g., 50)

### Reference Files
- `disasm/sh2_3d_engine_callgraph.txt` - Which functions call which
- `disasm/sh2_3d_engine_structures.txt` - Loop and structure analysis
- `disasm/sh2_3d_engine_annotated.asm` - Existing annotations (append here)
- `analysis/SH2_3D_ENGINE_DATA_STRUCTURES.md` - Known data structures

## Function List

From call graph, convert func_XXX to ROM offset:
```
func_000: 0x2300A    func_020: 0x23468    func_040: 0x2385C    func_060: 0x23DC4
func_001: 0x2301C    func_021: 0x234C0    func_041: 0x238D6    func_061: 0x23E32
func_002: 0x23066    func_022: 0x234EC    func_042: 0x2395C    func_062: 0x23E5C
func_003: 0x230CC    func_023: 0x23500    func_043: 0x239AA    func_063: 0x23E88
func_004: 0x230DC    func_024: 0x235F4    func_044: 0x239CA    func_064: 0x23EC6
func_005: 0x230E6    func_025: 0x23632    func_045: 0x23A64    func_065: 0x23F2C
func_006: 0x23114    func_026: 0x23642    func_046: 0x23B3C    func_066: 0x23FC4
func_007: 0x23176    func_027: 0x2367A    func_047: 0x23BC2    func_067: 0x23FF2
func_008: 0x231A2    func_028: 0x23682    func_048: 0x23BEC    func_068: 0x24058
func_009: 0x231E4    func_029: 0x23686    func_049: 0x23C42    func_069: 0x24082
func_010: 0x23202    func_030: 0x236CA    func_050: 0x23C4C    func_070: 0x240FC
func_011: 0x2321C    func_031: 0x236D4    func_051: 0x23C60    func_071: 0x241CC
func_012: 0x23268    func_032: 0x236D8    func_052: 0x23CA2    func_072: 0x24204
func_013: 0x232C4    func_033: 0x236F8    func_053: 0x23CAE    func_073: 0x24224
func_014: 0x23308    func_034: 0x2375C    func_054: 0x23CB2    func_074: 0x24272
func_015: 0x23340    func_035: 0x237A8    func_055: 0x23CDA    func_075: 0x242A0
func_016: 0x2335A    func_036: 0x237D2    func_056: 0x23D1A    func_076: 0x242D2
func_017: 0x23388    func_037: 0x2381C    func_057: 0x23D3C    func_077: 0x242F2
func_018: 0x233A2    func_038: 0x23834    func_058: 0x23D52    func_078: 0x24320
func_019: 0x2340C    func_039: 0x2383A    func_059: 0x23D6C    func_079: 0x24366

func_080-108: Continue from 0x243BC onwards
```

## Register Conventions (CRITICAL)

| Register | Typical Usage |
|----------|---------------|
| R0 | Temp, return value, calculations |
| R1-R4 | Temp, coordinates, comparisons |
| R5 | Alternate output buffer |
| R6 | Loop counter, render buffer |
| R7 | Loop counter |
| R8 | Object/polygon data pointer |
| R9 | Destination buffer (frame buffer) |
| R10 | Source data pointer |
| R11 | Accumulated results |
| R12 | Rendering parameter/flags |
| R13 | Command stream ptr OR stride value |
| **R14** | **RenderingContext pointer** (0xC0000700) |
| R15 | Stack pointer |

## Known Data Structures

### RenderingContext (R14) - 56 bytes at 0xC0000700
```
+0x00: unknown
+0x04: accumulated flags
+0x14: viewport inner X bound
+0x18: viewport inner Y bound
+0x1C: viewport outer X bound
+0x20: viewport outer Y bound
+0x24: render params (read/write)
+0x28: packed coord 1 (output)
+0x2C: packed coord 2 (output)
+0x30: packed coord 3 (output)
+0x34: packed coord 4 (output)
```

## SH2 Instruction Quick Reference

### Common Instructions
```
MOV.L @(disp,Rn),Rm  - Load 32-bit from Rn+disp*4
MOV.L Rm,@(disp,Rn)  - Store 32-bit to Rn+disp*4
MOV.L @Rn+,Rm        - Load and post-increment Rn
ADD Rm,Rn            - Rn = Rn + Rm
ADD #imm,Rn          - Rn = Rn + sign_extend(imm)
CMP/GT Rm,Rn         - T = (Rn > Rm) signed
CMP/EQ Rm,Rn         - T = (Rn == Rm)
BT label             - Branch if T=1
BF label             - Branch if T=0
BSR label            - Branch to subroutine (saves PR)
RTS                  - Return from subroutine
JSR @Rn              - Jump to address in Rn (indirect call)
DT Rn                - Rn--; T = (Rn == 0)
SHLL16 Rn            - Rn <<= 16
SHLR Rn              - Rn >>= 1 (logical)
MAC.L @Rm+,@Rn+      - MAC += *Rm++ * *Rn++ (64-bit accumulate)
STS MACH,Rn          - Rn = MAC[63:32]
STS MACL,Rn          - Rn = MAC[31:0]
XTRCT Rm,Rn          - Rn = (Rm[15:0] << 16) | Rn[31:16]
CLRMAC               - MAC = 0
STS.L PR,@-R15       - Push return address
LDS.L @R15+,PR       - Pop return address
```

## Annotation Template

Use this format when annotating a function:

```asm
; ═══════════════════════════════════════════════════════════════════════════
; func_XXX: [Descriptive Name]
; ═══════════════════════════════════════════════════════════════════════════
; Address: 0x022XXXXX - 0x022XXXXX
; Size: XX bytes
; Type: [Leaf | Hub | Recursive | Indirect-caller]
; Called by: [list callers from call graph]
; Calls: [list callees from call graph]
;
; Purpose: [1-3 sentence description of what the function does]
;
; Input:
;   RX = [description]
;   RY = [description]
;
; Output:
;   RX = [description] OR writes to [memory location]
;
; Registers Modified: R0, R1, ...
; ═══════════════════════════════════════════════════════════════════════════

func_XXX:
XXXXXXXX  XXXX     INSTRUCTION    ; Comment explaining this line
```

## Analysis Methodology

### Step 1: Get the disassembly
```bash
python3 tools/sh2_disasm.py "Virtua Racing Deluxe (USA).32x" 0x23XXX 30
```

### Step 2: Identify function boundaries
- Look for `RTS` (return) - marks function end
- Look for `STS.L PR,@-R15` - marks function start (saving return address)
- Cross-reference with call graph for exact boundaries

### Step 3: Determine function type
- **Leaf**: No BSR/JSR instructions (primitive operation)
- **Hub**: Multiple BSR/JSR instructions (dispatcher)
- **Recursive**: Calls itself
- **Indirect-caller**: Uses `JSR @Rn` (function pointer)

### Step 4: Trace data flow
- What registers are inputs? (used before being written)
- What registers are outputs? (written and used by caller)
- What memory is accessed? (R14 context, frame buffer, etc.)

### Step 5: Identify patterns
- **Loop**: Look for `DT Rn` + `BF` backward branch
- **Copy**: `MOV.L @Rn+,Rm` followed by `MOV.L Rm,@Rn`
- **Transform**: MAC.L sequences = matrix math
- **Conditional**: CMP + BT/BF = visibility test or branch

### Step 6: Name the function
Based on what it does:
- `coord_pack` - combines coordinates
- `matrix_mul` - matrix multiplication
- `visibility_test` - frustum culling
- `scanline_fill` - fills scanlines
- `vertex_transform` - transforms vertices
- `list_traverse` - walks linked list

## Priority Order

Annotate in this order for maximum understanding:

### Priority 1: Rendering Primitives (called by func_023)
- func_024, func_026 (setup functions)
- func_029 (first renderer)
- func_032, func_033 (quad/tri renderers)
- func_036 (complex polygon)

### Priority 2: Recursive Functions (tree/list traversal)
- func_020 (self-recursive)
- func_043 (self-recursive)
- func_044 (self-recursive, multiple indirect calls)
- func_094 (self-recursive)

### Priority 3: Indirect Call Dispatchers
- func_078, func_079 (6 indirect calls each - likely polygon type dispatch)
- func_100, func_101, func_105 (indirect calls with processing)

### Priority 4: Supporting Functions
- func_060-063 (call func_065, likely texture/data setup)
- func_068-072 (consecutive, likely related pipeline stage)

### Priority 5: Remaining Leaf Functions
- Small utility functions
- Group by size and pattern similarity

## Output Location

Append all annotations to:
```
disasm/sh2_3d_engine_annotated.asm
```

Keep the existing format and section separators.

## Quality Checklist

Before marking a function as annotated:
- [ ] Correct address range from call graph
- [ ] All instructions have comments
- [ ] Input/output registers documented
- [ ] Function purpose described
- [ ] Called-by and calls-to listed
- [ ] Any loops explained
- [ ] Any memory accesses to R14 context noted
- [ ] Type correctly identified (leaf/hub/etc.)

## Example: Good Annotation

See func_016, func_065, func_006 in `sh2_3d_engine_annotated.asm` for examples of proper annotation style with:
- Clear purpose statement
- Input/output documentation
- Line-by-line comments
- Analysis section explaining the algorithm
- Cycle count estimates where relevant

## Common Patterns to Recognize

### Pattern: VBlank Wait
```asm
loop:
    MOV.W @(offset,R5),R0  ; Read VDP status
    TST #bit,R0            ; Test ready bit
    BT loop                ; Loop until ready
```

### Pattern: Fixed-Point Multiply
```asm
    MAC.L @R4+,@R5+        ; Accumulate products
    MAC.L @R4+,@R5+
    MAC.L @R4+,@R5+
    STS MACH,R0            ; Get high 32 bits
    STS MACL,R1            ; Get low 32 bits
    XTRCT R0,R1            ; Extract middle 32 bits (16.16 result)
```

### Pattern: Coordinate Packing
```asm
    SHLL16 R1              ; Move to upper 16 bits
    OR R0,R1               ; Combine with lower 16 bits
    MOV.L R1,@(offset,R14) ; Store packed coord
```

### Pattern: Strided Copy Loop
```asm
loop:
    MOV.L @R0+,R2          ; Read source
    MOV.L R2,@R1           ; Write dest
    ADD R13,R1             ; Advance by stride
    DT R7                  ; Decrement counter
    BF loop                ; Loop if not zero
```

## Notes

1. The 0xC0000XXX addresses are cache-through - hardware register writes
2. The 0x24000000 region is frame buffer
3. The 0x22000000 region is SDRAM (code and data)
4. Function boundaries from call graph are authoritative
5. When uncertain about purpose, note it as "Unknown - needs runtime analysis"
