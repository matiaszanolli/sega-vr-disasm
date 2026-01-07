; ═══════════════════════════════════════════════════════════════════════════
; Virtua Racing Deluxe - SH2 3D Rendering Engine
; Annotated Disassembly
; ═══════════════════════════════════════════════════════════════════════════
; ROM Region: 0x23000-0x25000 (8KB)
; Functions: 109 total (76 leaf, 5 hub, 4 recursive, 9 indirect-call)
; Analysis Date: January 6, 2026
; ═══════════════════════════════════════════════════════════════════════════

; ┌─────────────────────────────────────────────────────────────────────────┐
; │                    RENDERING PIPELINE ARCHITECTURE                       │
; └─────────────────────────────────────────────────────────────────────────┘
;
;   ┌──────────────────┐
;   │   Game Loop      │ (68000 side - sends commands via COMM registers)
;   │   [external]     │
;   └────────┬─────────┘
;            │ Display list commands
;            ▼
;   ┌──────────────────┐
;   │   func_001       │ Display List Processor
;   │   Command Loop   │ - Reads 16-bit commands from R13
;   │                  │ - Decodes command byte (0x0C = terminator)
;   │                  │ - Dispatches to handlers
;   └────────┬─────────┘
;            │
;    ┌───────┴───────┬───────────────┐
;    ▼               ▼               ▼
; func_005       func_007        func_009/010
; (indirect)     (indirect)      (leaf handlers)
;    │               │
;    ▼               ▼
; func_006       func_008
; Matrix×Vec     (handler)
;
;   ┌──────────────────┐
;   │   func_023       │ Frustum Culler / Rendering Dispatcher
;   │   Hub (6 calls)  │ - Loads context from 0xC0000700
;   │                  │ - Coordinate comparisons (visibility)
;   │                  │ - Branches to rendering paths
;   └────────┬─────────┘
;            │
;    ┌───────┼───────┬───────────────┬───────────────┐
;    ▼       ▼       ▼               ▼               ▼
; func_024 func_026 func_029     func_032/033    func_036
; (setup)  (setup)  (render)     (render)        (render)
;
; Key Data Structures:
;   R14 = RenderingContext (56 bytes) at 0xC0000700
;   R13 = Command stream pointer (display list)
;   R9  = Destination buffer / frame buffer pointer
;   R10 = Source data pointer
;
; Function Categories (109 total):
;   - 74 Entry points (called from outside this module)
;   - 76 Leaf functions (no outgoing calls - primitives)
;   - 5  Hub functions (call 3+ functions - dispatchers)
;   - 4  Recursive functions (tree/list traversal)
;   - 9  Indirect callers (use function pointers via JSR @Rn)
;
; ═══════════════════════════════════════════════════════════════════════════

; ═══════════════════════════════════════════════════════════════════════════
; func_001: Display List Processor / Command Loop
; ═══════════════════════════════════════════════════════════════════════════
; Address: 0x0222301C - 0x02223064
; Size: 72 bytes
; Type: Hub function (calls func_005, func_007, func_009, func_010)
;
; Purpose: Interprets a display list (command stream) and dispatches to
;          appropriate rendering handlers. This is the main entry point
;          for SH2 3D rendering operations.
;
; Input:
;   R13 = Pointer to display list (16-bit command stream)
;   R14 = RenderingContext pointer
;
; Command Format:
;   Each command is a 16-bit word:
;   - Bits 15-8: Command opcode (after SWAP.B)
;   - Bits 7-0:  Command parameters/flags
;   - 0x0C = List terminator
;
; Flow:
;   1. Read 16-bit command from @R13+
;   2. Decode command byte (SWAP.B, mask)
;   3. If command == 0x0C: exit loop, return
;   4. Based on flags, branch to func_007/009/010
;   5. Loop back to step 1
; ═══════════════════════════════════════════════════════════════════════════

func_001:
0222301C  0009     NOP                        ; Alignment/padding
0222301E  0000     DW      $0000              ; Literal pool
02223020  C000     DW      $C000              ; Part of address literal
02223022  0740     DW      $0740              ; 0xC0000740 - buffer address

02223024  4F22     STS.L   PR,@-R15           ; Push return address
02223026  B0A7     BSR     func_007           ; 0x02223178 - Initial setup call
02223028  7D02     ADD     #$02,R13           ; Advance command pointer (delay slot)
0222302A  A003     BRA     command_loop       ; Jump to main loop
0222302C  0009     NOP

; Alternate entry point (for re-entry?)
0222302E  4F22     STS.L   PR,@-R15           ; Push return address
02223030  B05A     BSR     func_005           ; 0x022230E8 - Alternate setup
02223032  7D02     ADD     #$02,R13           ; Advance command pointer (delay slot)

command_loop:
02223034  5AEB     MOV.L   @($2C,R14),R10     ; R10 = ctx->field_2C (source ptr)
02223036  5BE9     MOV.L   @($24,R14),R11     ; R11 = ctx->field_24 (param)
02223038  69D5     MOV.W   @R13+,R9           ; Read next command, advance R13
0222303A  6098     SWAP.B  R9,R0              ; Swap bytes: R0 = opcode in low byte
0222303C  C90E     AND     #$0E,R0            ; Mask bits 1-3 (command type)
0222303E  880C     CMP/EQ  #$0C,R0            ; Is this the terminator (0x0C)?
02223040  890F     BT      exit_loop          ; Yes -> exit

02223042  6103     MOV     R0,R1              ; Copy masked opcode
02223044  C708     MOVA    @($20,PC),R0       ; Load jump table base
02223046  011D     MAC.W   @R0+,@R1+          ; Table lookup (unusual usage)
02223048  0103     DW      $0103              ; Possibly part of dispatch
0222304A  0009     NOP
0222304C  6093     MOV     R9,R0              ; Get original command
0222304E  C801     TST     #$01,R0            ; Test bit 0
02223050  8B03     BF      handler_a          ; Bit 0 clear -> handler A
02223052  B0C9     BSR     func_009           ; 0x022231E8 - Handler for bit 0 set
02223054  85E1     MOV.W   @($2,R14),R0       ; Load param (delay slot)
02223056  AFF0     BRA     command_loop       ; Next command
02223058  69D5     MOV.W   @R13+,R9           ; Pre-fetch next (delay slot)

handler_a:
0222305A  B0D4     BSR     func_010           ; 0x02223206 - Handler for bit 0 clear
0222305C  85E1     MOV.W   @($2,R14),R0       ; Load param (delay slot)
0222305E  AFEC     BRA     command_loop       ; Next command
02223060  69D5     MOV.W   @R13+,R9           ; Pre-fetch next (delay slot)

exit_loop:
02223062  4F26     LDS.L   @R15+,PR           ; Pop return address
02223064  000B     RTS                        ; Return
02223066  1EB9     MOV.L   R11,@($24,R14)     ; Store R11 back to context (delay slot)

; Analysis: This is a classic display list interpreter pattern used in
; many 3D games. The 68000 builds a command list, SH2 processes it.
; Benefits:
;   - Decouples game logic (68K) from rendering (SH2)
;   - Allows 68K to prepare next frame while SH2 renders current
;   - Command list can be sorted for optimal rendering order


; ═══════════════════════════════════════════════════════════════════════════
; func_023: Frustum Culler / Rendering Dispatcher
; ═══════════════════════════════════════════════════════════════════════════
; Address: 0x02223500 - 0x022235F2
; Size: 242 bytes
; Type: Hub function (calls func_024, func_026, func_029, func_032, func_033, func_036)
;
; Purpose: Main rendering dispatcher. Performs visibility testing (frustum
;          culling) and routes objects to appropriate rendering functions
;          based on their screen position and visibility.
;
; Input:
;   R8 = Object/polygon data pointer
;
; Key Operations:
;   1. Load context from literal 0xC0000700 into R14
;   2. Load buffer pointer 0xC0000740 into R9
;   3. Call setup functions (func_024, func_026)
;   4. Perform coordinate comparisons (visibility tests)
;   5. Branch to appropriate rendering path based on visibility
;
; Visibility Testing:
;   Compares object bounds (R1,R2) against viewport (R3,R4):
;   - If object fully outside viewport: skip rendering
;   - If object fully inside: render directly
;   - If object partially visible: clip and render
; ═══════════════════════════════════════════════════════════════════════════

func_023:
02223500  0000     DW      $0000              ; Literal pool header
02223502  0000     DW      $0000
02223504  2000     DW      $2000
02223506  0000     DW      $0000

02223508  4F22     STS.L   PR,@-R15           ; Push return address
0222350A  DE12     MOV.L   @(ctx_ptr,PC),R14  ; R14 = 0xC0000700 (RenderingContext)
0222350C  D912     MOV.L   @(buf_ptr,PC),R9   ; R9 = 0xC0000740 (buffer)
0222350E  B072     BSR     func_024           ; Setup function 1
02223510  7802     ADD     #$02,R8            ; Advance data pointer (delay slot)
02223512  B097     BSR     func_026           ; Setup function 2
02223514  0009     NOP

; ─────────────────────────────────────────────────────────────────────────
; Visibility Test 1: Check against outer bounds
; ─────────────────────────────────────────────────────────────────────────
02223516  53E7     MOV.L   @($1C,R14),R3      ; R3 = ctx->bound_x1
02223518  54E8     MOV.L   @($20,R14),R4      ; R4 = ctx->bound_y1
0222351A  3317     CMP/GT  R1,R3              ; Is R3 > R1? (object left of viewport?)
0222351C  893C     BT      path_clipped_1     ; Yes -> needs clipping
0222351E  3247     CMP/GT  R4,R2              ; Is R4 > R2? (object above viewport?)
02223520  893A     BT      path_clipped_1     ; Yes -> needs clipping

; Object passed outer bounds test
02223522  B0B1     BSR     func_029           ; Call renderer (object visible)
02223524  0009     NOP

; ─────────────────────────────────────────────────────────────────────────
; Visibility Test 2: Check against inner bounds
; ─────────────────────────────────────────────────────────────────────────
02223526  53E5     MOV.L   @($14,R14),R3      ; R3 = ctx->bound_x2
02223528  54E6     MOV.L   @($18,R14),R4      ; R4 = ctx->bound_y2
0222352A  3317     CMP/GT  R1,R3              ; More visibility tests...
0222352C  8918     BT      path_render_full
0222352E  3247     CMP/GT  R4,R2
02223530  8916     BT      path_render_full
02223532  3210     CMP/EQ  R1,R2              ; Edge case: degenerate object?
02223534  895C     BT      path_exit

; Object needs full rendering with potential quad split
02223536  56E9     MOV.L   @($24,R14),R6      ; Load rendering params
02223538  D308     MOV.L   @(const_1,PC),R3   ; Load constant
0222353A  236B     OR      R6,R3              ; Combine flags
0222353C  853E     MOV.W   @($1C,R5),R0       ; Wait loop (hardware sync?)
0222353E  C808     TST     #$08,R0            ; Test ready bit
02223540  89FC     BT      $0222353C          ; Loop until ready

02223542  6963     MOV     R6,R9              ; Copy to destination reg
02223544  B0C9     BSR     func_032           ; Render quad 1
02223546  EC04     MOV     #$04,R12           ; Param (delay slot)
02223548  6963     MOV     R6,R9
0222354A  7920     ADD     #$20,R9            ; Offset for quad 2
0222354C  B0C5     BSR     func_032           ; Render quad 2
0222354E  ECFC     MOV     #$FC,R12           ; Param (delay slot)
02223550  A223     BRA     func_exit          ; Exit via common path
02223552  4F26     LDS.L   @R15+,PR           ; Pop PR (delay slot)

; Literal pool
ctx_ptr:
02223554  C000     DW      $C000
02223556  0700     DW      $0700              ; = 0xC0000700
buf_ptr:
02223558  C000     DW      $C000
0222355A  0740     DW      $0740              ; = 0xC0000740

; ... (additional rendering paths omitted for brevity)

; Analysis: This is the core frustum culling and dispatch function.
; The multiple BSR calls to func_032/033/036 represent different
; rendering paths:
;   - func_032: Quad rendering (called twice for split quads)
;   - func_033: Triangle rendering
;   - func_036: Complex polygon rendering
;
; The visibility tests use a hierarchical bounding box approach:
;   1. Test against outer bounds (screen edges)
;   2. Test against inner bounds (viewport)
;   3. Handle edge cases (degenerate, fully inside)
;
; This is highly optimized - early-out tests prevent unnecessary
; rendering of off-screen objects.


; ═══════════════════════════════════════════════════════════════════════════
; HOTSPOT FUNCTIONS (Previously Documented)
; ═══════════════════════════════════════════════════════════════════════════

; This annotated disassembly focuses on the critical hotspot functions and
; key rendering pipeline components identified through call graph analysis.

; ═══════════════════════════════════════════════════════════════════════════
; func_016: Coordinate Transformation Utility ⭐⭐⭐ HOTSPOT
; ═══════════════════════════════════════════════════════════════════════════
; Address: 0x02223368 - 0x02223386
; Size: 30 bytes (15 instructions)
; Type: Leaf function (no outgoing calls)
; Called by: func_017, func_018 (2×), func_019
; Call count: 4 (critical hotspot!)
;
; Purpose: Combines coordinate fields from context structure into output
;          fields using bit operations. Likely preparing viewport or
;          clipping coordinates.
;
; Input:
;   R14 = Pointer to RenderingContext structure (56 bytes)
;
; Output:
;   R14->field_0x28 = processed coordinate 1
;   R14->field_0x2C = processed coordinate 2
;   R14->field_0x30 = processed coordinate 3
;   R14->field_0x34 = processed coordinate 4
;
; Registers Modified: R0, R1, R2, R3, R4
;
; OPT: This function should be INLINED at all 4 call sites for ~5% gain
; OPT: Currently wastes 6 cycles/call × 4 = 24 cycles/polygon in overhead
; ═══════════════════════════════════════════════════════════════════════════

func_016:
02223368  51E7     MOV.L   @($1C,R14),R1      ; Load field_0x1C into R1
0222336A  52E8     MOV.L   @($20,R14),R2      ; Load field_0x20 into R2
0222336C  4128     SHLL16  R1                 ; Shift R1 left 16 bits (upper word)
0222336E  4228     SHLL16  R2                 ; Shift R2 left 16 bits (upper word)
02223370  50E5     MOV.L   @($14,R14),R0      ; Load field_0x14 (base value)
02223372  6313     MOV     R1,R3              ; Copy R1 to R3
02223374  6423     MOV     R2,R4              ; Copy R2 to R4
02223376  210B     OR      R0,R1              ; R1 = R1 | R0 (combine upper+lower)
02223378  220B     OR      R0,R2              ; R2 = R2 | R0 (combine upper+lower)
0222337A  1E1A     MOV.L   R1,@($28,R14)      ; Store to field_0x28
0222337C  1E2B     MOV.L   R2,@($2C,R14)      ; Store to field_0x2C
0222337E  50E6     MOV.L   @($18,R14),R0      ; Load field_0x18 (alternate base)
02223380  230B     OR      R0,R3              ; R3 = R3 | R0 (alt combination)
02223382  240B     OR      R0,R4              ; R4 = R4 | R0 (alt combination)
02223384  1E3C     MOV.L   R3,@($30,R14)      ; Store to field_0x30
02223386  000B     RTS                        ; Return
02223388  1E4D     MOV.L   R4,@($34,R14)      ; Store to field_0x34 (delay slot)

; Analysis: This function combines 16-bit coordinate pairs into 32-bit values.
; The SHLL16 operations move values to the upper 16 bits, then OR combines
; them with base values in the lower 16 bits. This is likely packing X/Y or
; viewport coordinates into hardware-friendly format.
;
; Typical 16.16 fixed-point coordinate packing:
;   Input:  R1 = 0x0000XPOS, R0 = 0x0000YPOS
;   Output: Result = 0xXPOSYPOS (packed coordinate pair)
;
; Cycle count: ~15 cycles (all single-cycle instructions except RTS=2)
; With call overhead: 15 + 6 = 21 cycles per invocation
; Per polygon (4 calls): 84 cycles
; Per frame (800 polygons): 67,200 cycles = 17% of frame budget!
;
; CRITICAL OPTIMIZATION: Inline this function!


; ═══════════════════════════════════════════════════════════════════════════
; func_065: Unrolled Data Copy Loop ⭐⭐⭐ HOTSPOT
; ═══════════════════════════════════════════════════════════════════════════
; Address: 0x02223F2C - 0x02223FC2
; Size: 150 bytes (75 instructions)
; Type: Leaf function (no outgoing calls)
; Called by: func_060, func_061, func_062, func_063
; Call count: 4 (critical hotspot!)
;
; Purpose: Fast bulk data copy with stride. Copies 14 blocks of 8 bytes
;          (2 longwords) from source to destination with custom stride.
;          Likely used for texture data or vertex attribute copying.
;
; Input:
;   R0 = Index/offset
;   R9 = Destination base pointer
;   R10 = Source base pointer
;   R13 = Destination stride (bytes to advance between blocks)
;
; Output:
;   Copies 14 × 8 bytes = 112 bytes total
;
; Registers Modified: R0, R1, R2
;
; OPT: Already fully unrolled for maximum speed
; OPT: Could use frame buffer FIFO for further optimization if dest is FB
; OPT: Consider DMA for large transfers instead of CPU copy
; ═══════════════════════════════════════════════════════════════════════════

func_065:
02223F2C  0009     NOP                        ; Entry point alignment
02223F2E  4018     SHLL8   R0                 ; R0 = R0 << 8 (multiply by 256)
02223F30  4001     SHLR    R0                 ; R0 = R0 >> 1 (divide by 2)
                                              ; Net: R0 = R0 * 128
02223F32  30AC     ADD     R10,R0             ; R0 = R10 + (R0 * 128) = source addr
02223F34  6193     MOV     R9,R1              ; R1 = destination base pointer

; ─────────────────────────────────────────────────────────────────────────
; Unrolled loop: 14 iterations of 8-byte block copy
; Each iteration:
;   - Read 2 longwords (8 bytes) from source with auto-increment
;   - Write 2 longwords to destination at R1+0 and R1+4
;   - Advance destination by stride (R13)
; ─────────────────────────────────────────────────────────────────────────

; Iteration 1
02223F36  6206     MOV.L   @R0+,R2            ; R2 = *R0++  (read long, advance source)
02223F38  1120     MOV.L   R2,@($0,R1)        ; *(R1+0) = R2  (write to dest+0)
02223F3A  6206     MOV.L   @R0+,R2            ; R2 = *R0++  (read second long)
02223F3C  1121     MOV.L   R2,@($4,R1)        ; *(R1+4) = R2  (write to dest+4)
02223F3E  31DC     ADD     R13,R1             ; R1 += R13  (advance dest by stride)

; Iteration 2
02223F40  6206     MOV.L   @R0+,R2            ; Copy block 2...
02223F42  1120     MOV.L   R2,@($0,R1)
02223F44  6206     MOV.L   @R0+,R2
02223F46  1121     MOV.L   R2,@($4,R1)
02223F48  31DC     ADD     R13,R1

; Iteration 3
02223F4A  6206     MOV.L   @R0+,R2            ; Copy block 3...
02223F4C  1120     MOV.L   R2,@($0,R1)
02223F4E  6206     MOV.L   @R0+,R2
02223F50  1121     MOV.L   R2,@($4,R1)
02223F52  31DC     ADD     R13,R1

; Iteration 4
02223F54  6206     MOV.L   @R0+,R2
02223F56  1120     MOV.L   R2,@($0,R1)
02223F58  6206     MOV.L   @R0+,R2
02223F5A  1121     MOV.L   R2,@($4,R1)
02223F5C  31DC     ADD     R13,R1

; Iteration 5
02223F5E  6206     MOV.L   @R0+,R2
02223F60  1120     MOV.L   R2,@($0,R1)
02223F62  6206     MOV.L   @R0+,R2
02223F64  1121     MOV.L   R2,@($4,R1)
02223F66  31DC     ADD     R13,R1

; Iteration 6
02223F68  6206     MOV.L   @R0+,R2
02223F6A  1120     MOV.L   R2,@($0,R1)
02223F6C  6206     MOV.L   @R0+,R2
02223F6E  1121     MOV.L   R2,@($4,R1)
02223F70  31DC     ADD     R13,R1

; Iteration 7
02223F72  6206     MOV.L   @R0+,R2
02223F74  1120     MOV.L   R2,@($0,R1)
02223F76  6206     MOV.L   @R0+,R2
02223F78  1121     MOV.L   R2,@($4,R1)
02223F7A  31DC     ADD     R13,R1

; Iteration 8
02223F7C  6206     MOV.L   @R0+,R2
02223F7E  1120     MOV.L   R2,@($0,R1)
02223F80  6206     MOV.L   @R0+,R2
02223F82  1121     MOV.L   R2,@($4,R1)
02223F84  31DC     ADD     R13,R1

; Iteration 9
02223F86  6206     MOV.L   @R0+,R2
02223F88  1120     MOV.L   R2,@($0,R1)
02223F8A  6206     MOV.L   @R0+,R2
02223F8C  1121     MOV.L   R2,@($4,R1)
02223F8E  31DC     ADD     R13,R1

; Iteration 10
02223F90  6206     MOV.L   @R0+,R2
02223F92  1120     MOV.L   R2,@($0,R1)
02223F94  6206     MOV.L   @R0+,R2
02223F96  1121     MOV.L   R2,@($4,R1)
02223F98  31DC     ADD     R13,R1

; Iteration 11
02223F9A  6206     MOV.L   @R0+,R2
02223F9C  1120     MOV.L   R2,@($0,R1)
02223F9E  6206     MOV.L   @R0+,R2
02223FA0  1121     MOV.L   R2,@($4,R1)
02223FA2  31DC     ADD     R13,R1

; Iteration 12
02223FA4  6206     MOV.L   @R0+,R2
02223FA6  1120     MOV.L   R2,@($0,R1)
02223FA8  6206     MOV.L   @R0+,R2
02223FAA  1121     MOV.L   R2,@($4,R1)
02223FAC  31DC     ADD     R13,R1

; Iteration 13
02223FAE  6206     MOV.L   @R0+,R2
02223FB0  1120     MOV.L   R2,@($0,R1)
02223FB2  6206     MOV.L   @R0+,R2
02223FB4  1121     MOV.L   R2,@($4,R1)
02223FB6  31DC     ADD     R13,R1

; Iteration 14 (final)
02223FB8  6206     MOV.L   @R0+,R2
02223FBA  1120     MOV.L   R2,@($0,R1)
02223FBC  6206     MOV.L   @R0+,R2
02223FBE  1121     MOV.L   R2,@($4,R1)
02223FC0  31DC     ADD     R13,R1

02223FC2  000B     RTS                        ; Return
02223FC4  0009     NOP                        ; Delay slot

; Analysis: This is a masterpiece of loop unrolling optimization!
;
; Cycle count per iteration:
;   MOV.L @R0+,R2  : 1 cycle (read from cache)
;   MOV.L R2,@(0,R1): 1 cycle (write to cache)
;   MOV.L @R0+,R2  : 1 cycle
;   MOV.L R2,@(4,R1): 1 cycle
;   ADD R13,R1     : 1 cycle
;   ─────────────────────────
;   Total per iteration: 5 cycles
;
; Total for all 14 iterations: 70 cycles
; Plus setup (4 cycles) + RTS (2 cycles) = 76 cycles total
;
; Throughput: 112 bytes in 76 cycles = 1.47 bytes/cycle = 33.9 MB/sec @ 23MHz
;
; Compare to loop version:
;   Loop would add: DT (1 cycle) + BF/S (2 cycles) = 3 cycles overhead
;   Per iteration: 5 + 3 = 8 cycles
;   Total: 14 × 8 + 4 = 116 cycles
;   Unrolling saves: 116 - 76 = 40 cycles (35% faster!)
;
; OPTIMIZATION: If destination is frame buffer, batch 4 writes to use FIFO:
;   Current: Individual writes at 3 cycles each
;   Optimized: Batch of 4 writes at 3+3+3+5 = 14 cycles = 3.5 cycles avg
;   Potential improvement: ~15% if FB-bound
;
; This function is already highly optimized. Main improvement would be
; using DMA for transfers larger than 112 bytes, but for this size,
; CPU copy is actually faster than DMA setup overhead.


; ═══════════════════════════════════════════════════════════════════════════
; func_006: Matrix × Vector Multiplication (MAC.L)
; ═══════════════════════════════════════════════════════════════════════════
; Address: 0x02223114 - 0x02223174
; Size: 98 bytes
; Type: Leaf function (MAC.L intensive)
; Called by: func_005
;
; Purpose: Perform 3D vector transformation using 3×3 matrix multiplication
;          with translation. Uses SH2 MAC (Multiply-Accumulate) for efficient
;          fixed-point arithmetic.
;
; Formula: V_out = M × V_in + T
;   Where M is 3×3 matrix, V_in is 3D vector, T is translation vector
;
; Fixed-Point Format: 16.16 (16 integer bits, 16 fractional bits)
;
; Input:
;   R4 = Pointer to 3×3 matrix + translation (row-major, 4 longs per row)
;   R5 = Pointer to input vector (3 longs: X, Y, Z)
;   R6 = Pointer to output buffer
;   R7 = Additional parameter (passed from caller)
;
; Output:
;   Transformed vector written to R6 buffer:
;     @(0,R6) = X'
;     @(16,R6) = Y'  (future write)
;     @(20,R6) = Z'  (future write, not shown)
;
; Registers Modified: R0, R1, R2, R3, R4, R5, R7, R8, MACH, MACL
;
; OPT: Pointer resets (ADD #$F4) could be eliminated with better layout
; ═══════════════════════════════════════════════════════════════════════════

func_006:
; ─────────────────────────────────────────────────────────────────────────
; Transform X component: X' = M[0][0]*X + M[0][1]*Y + M[0][2]*Z + T[0]
; ─────────────────────────────────────────────────────────────────────────
02223120  054F     MAC.L   @R4+,@R5+          ; MAC += M[0][0] * V[0] (X component)
02223122  054F     MAC.L   @R4+,@R5+          ; MAC += M[0][1] * V[1] (Y component)
02223124  054F     MAC.L   @R4+,@R5+          ; MAC += M[0][2] * V[2] (Z component)
                                              ; MAC now holds 64-bit result
02223126  75F4     ADD     #$F4,R5            ; R5 -= 12 (reset to vector start)
                                              ; OPT: Could avoid this with duplicated data
02223128  6846     MOV.L   @R4+,R8            ; R8 = T[0] (translation X)
0222312A  74D0     ADD     #$D0,R4            ; R4 -= 48 (adjust matrix pointer)
0222312C  000A     STS     MACH,R0            ; R0 = MAC[63:32] (high 32 bits)
0222312E  031A     STS     MACL,R3            ; R3 = MAC[31:0] (low 32 bits)
02223130  230D     XTRCT   R0,R3              ; R3 = MAC[47:16] (extract middle 32 bits)
                                              ; This is the 16.16 fixed-point result!
02223132  338C     ADD     R8,R3              ; R3 += T[0] (add translation)
02223134  1630     MOV.L   R3,@($0,R6)        ; Store X' to output buffer
02223136  1674     MOV.L   R7,@($10,R6)       ; Store param to offset +16
0222313A  1605     MOV.L   R0,@($14,R6)       ; Store value to offset +20
0222313C  0028     CLRMAC                     ; Clear MAC for next operation

; ─────────────────────────────────────────────────────────────────────────
; Transform Y component: Y' = M[1][0]*X + M[1][1]*Y + M[1][2]*Z + T[1]
; ─────────────────────────────────────────────────────────────────────────
0222313E  054F     MAC.L   @R4+,@R5+          ; MAC += M[1][0] * V[0]
02223140  054F     MAC.L   @R4+,@R5+          ; MAC += M[1][1] * V[1]
02223142  054F     MAC.L   @R4+,@R5+          ; MAC += M[1][2] * V[2]
02223144  75F4     ADD     #$F4,R5            ; Reset R5 to vector start
02223146  6846     MOV.L   @R4+,R8            ; R8 = T[1] (translation Y)
02223148  000A     STS     MACH,R0            ; Extract result (same as above)
0222314A  011A     STS     MACL,R1
0222314C  210D     XTRCT   R0,R1              ; R1 = Y' (before translation)
0222314E  318C     ADD     R8,R1              ; R1 += T[1]
                                              ; Y' result in R1 (to be stored later)

; ─────────────────────────────────────────────────────────────────────────
; Transform Z component: Z' = M[2][0]*X + M[2][1]*Y + M[2][2]*Z + T[2]
; ─────────────────────────────────────────────────────────────────────────
02223150  0028     CLRMAC
02223152  054F     MAC.L   @R4+,@R5+          ; MAC += M[2][0] * V[0]
02223154  054F     MAC.L   @R4+,@R5+          ; MAC += M[2][1] * V[1]
02223156  054F     MAC.L   @R4+,@R5+          ; MAC += M[2][2] * V[2]
02223158  75F4     ADD     #$F4,R5            ; Reset R5
0222315A  6846     MOV.L   @R4+,R8            ; R8 = T[2] (translation Z)
0222315C  000A     STS     MACH,R0
0222315E  021A     STS     MACL,R2
02223160  220D     XTRCT   R0,R2              ; R2 = Z' (before translation)
02223162  328C     ADD     R8,R2              ; R2 += T[2]

; ─────────────────────────────────────────────────────────────────────────
; Additional processing (perspective divide? normalization?)
; ─────────────────────────────────────────────────────────────────────────
02223164  5367     MOV.L   @($1C,R6),R3       ; Load something from output+28
02223166  313D     DW      $313D              ; Unknown opcode - MAC-related?
02223168  000A     STS     MACH,R0
0222316A  309C     ADD     R9,R0              ; Add R9 (scale factor?)
0222316C  81A6     MOV.B   R0,@($6,R1)        ; Store byte to offset +6
0222316E  323D     DW      $323D              ; Unknown opcode
02223170  000A     STS     MACH,R0
02223172  30CC     ADD     R12,R0             ; Add R12
02223174  000B     RTS
02223176  81A7     MOV.B   R0,@($7,R1)        ; Store byte to offset +7 (delay slot)

; Analysis: Classic 3D transformation using fixed-point MAC operations.
;
; Cycle count per component (X, Y, or Z):
;   3 × MAC.L   : 3 × 2 = 6 cycles (MAC.L is 2 cycles on SH2)
;   ADD (reset) : 1 cycle
;   MOV.L load  : 1 cycle
;   ADD adjust  : 1 cycle
;   STS MACH    : 1 cycle
;   STS MACL    : 1 cycle
;   XTRCT       : 1 cycle
;   ADD trans   : 1 cycle
;   ─────────────────────
;   Total: ~15 cycles per component
;
; Total for 3 components: ~45 cycles
; Plus overhead: ~15 cycles
; Function total: ~60 cycles per vertex
;
; With 500 vertices/frame: 30,000 cycles (7.8% of frame budget)
;
; This is already quite optimal. The MAC.L instruction is the fastest way
; to do multiply-accumulate on SH2. The only optimization would be to
; eliminate the pointer resets by duplicating vector data:
;
;   Current layout:  [Vx Vy Vz]
;   Optimized layout: [Vx Vy Vz Vx Vy Vz Vx Vy Vz]
;
; This would save 3 × ADD #$F4 = 3 cycles per vertex
; Tradeoff: 3× memory usage for input vectors (12 bytes -> 36 bytes)
; Gain: ~5% in transform performance


; ═══════════════════════════════════════════════════════════════════════════
; func_024: Rendering Parameter Setup
; ═══════════════════════════════════════════════════════════════════════════
; Address: 0x022235F4 - 0x02223642
; Size: 78 bytes
; Type: Leaf function
; Called by: func_023 (rendering dispatcher setup)
; Calls: none (leaf)
;
; Purpose: Sets up rendering parameters by reading source data from R8 and
;          writing attributes to hardware registers via R1. Performs scaling
;          and clipping calculations. Synchronizes with VDP before writing.
;
; Input:
;   R8 = Pointer to source parameter data (16-bit words)
;   R1 = Hardware register base (attribute write address)
;   R2 = Scaling/clipping parameter
;
; Output:
;   Attributes written to R1+0 through R1+7 (8 bytes)
;   R9 frame buffer updated via R0 temp
;
; Registers Modified: R0, R4
;
; Key Operations:
;   1. Read 6 16-bit words from R8 (6 parameters)
;   2. For each: ADD R1,R0 / SUB R2,R4 / NEG R4,R0 / MOV.B R0,@(offset,R1)
;   3. Pattern: Load, add offset, subtract scaling, negate, store
;   4. VDP sync: MOV.B @(0,R5), TST #1, BT (wait for ready)
;   5. Load from frame buffer, conditionally store back
; ═══════════════════════════════════════════════════════════════════════════

func_024:
022235F4  0009     NOP                        ; Entry alignment
022235F6  51E3     MOV.L   @($C,R14),R1      ; R1 = ctx->field_0C (attrib base)
022235F8  52E4     MOV.L   @($10,R14),R2     ; R2 = ctx->field_10 (scale param)
022235FA  6085     MOV.W   @R8+,R0           ; R0 = *R8++ (param 1)
022235FC  81E0     MOV.B   R0,@($0,R1)       ; @(0,R1) = R0 (store param 1)
022235FE  6085     MOV.W   @R8+,R0           ; R0 = *R8++
02223600  6485     MOV.W   @R8+,R4           ; R4 = *R8++ (scale value)
02223602  301C     ADD     R1,R0              ; R0 = R0 + R1 (add base offset)
02223604  8190     MOV.B   R0,@($0,R1)       ; Store to offset 0
02223606  3428     SUB     R2,R4              ; R4 = R4 - R2 (subtract scaling)
02223608  604B     NEG     R4,R0              ; R0 = -R4 (negate for clipping)
0222360A  8191     MOV.B   R0,@($1,R1)       ; Store to offset 1

; Repeat pattern for remaining parameters
0222360C  6085     MOV.W   @R8+,R0
0222360E  6485     MOV.W   @R8+,R4
02223610  301C     ADD     R1,R0
02223612  8192     MOV.B   R0,@($2,R1)       ; Store to offset 2
02223614  3428     SUB     R2,R4
02223616  604B     NEG     R4,R0
02223618  8193     MOV.B   R0,@($3,R1)       ; Store to offset 3

0222361A  6085     MOV.W   @R8+,R0
0222361C  6485     MOV.W   @R8+,R4
0222361E  301C     ADD     R1,R0
02223620  8194     MOV.B   R0,@($4,R1)       ; Store to offset 4
02223622  3428     SUB     R2,R4
02223624  604B     NEG     R4,R0
02223626  8195     MOV.B   R0,@($5,R1)       ; Store to offset 5

; ─────────────────────────────────────────────────────────────────────────
; VDP Synchronization: Wait for hardware ready
; ─────────────────────────────────────────────────────────────────────────
02223628  85E0     MOV.B   R0,@($0,R5)       ; Dummy write to R5+0 (sync)
0222362A  C801     TST     #$01,R0           ; Test ready bit
0222362C  8902     BT      $02223634          ; If ready, branch to skip
0222362E  5092     MOV.L   @($8,R9),R0       ; Read from frame buffer
02223630  000B     RTS                        ; Return
02223632  1903     MOV.L   R0,@($C,R9)       ; Store back (delay slot)

; Branch target if ready
02223634  6085     MOV.W   @R8+,R0           ; Continue with param 6
02223636  6485     MOV.W   @R8+,R4
02223638  301C     ADD     R1,R0
0222363A  8196     MOV.B   R0,@($6,R1)       ; Store to offset 6
0222363C  3428     SUB     R2,R4
0222363E  604B     NEG     R4,R0
02223640  000B     RTS                        ; Return
02223642  8197     MOV.B   R0,@($7,R1)       ; Store to offset 7 (delay slot)

; Analysis: This function loads 6 parameter pairs (12 bytes) and writes
; 8 attribute bytes to hardware. The pattern ADD/SUB/NEG suggests coordinate
; transformation or clipping calculations. The VDP sync is critical for
; timing correctness with frame buffer operations.


; ═══════════════════════════════════════════════════════════════════════════
; func_026: Coordinate Boundary Clamping
; ═══════════════════════════════════════════════════════════════════════════
; Address: 0x02223642 - 0x02223686
; Size: 68 bytes
; Type: Leaf function
; Called by: func_023 (rendering dispatcher setup)
; Calls: none (leaf)
;
; Purpose: Performs coordinate boundary clamping and limit checking.
;          Compares values against bounds and applies clipping constraints.
;          Prepares clipped coordinates for rendering.
;
; Input:
;   R0-R2 = Coordinate values to clamp
;   R5 = Status register base
;
; Output:
;   R0, R1, R2 = Clamped values
;   Written to R5+0, +2, +4, +6
;
; Registers Modified: R0, R1, R2, R8
;
; Key Operations:
;   Multiple CMP/GE tests with conditional MOV
;   Pattern: CMP/GE, BT (branch if >=), conditional assignment
; ═══════════════════════════════════════════════════════════════════════════

func_026:
02223642  8197     MOV.B   R0,@($7,R1)       ; (from func_024 delay slot)
02223644  D804     MOV.L   @(literal,PC),R8  ; R8 = 0xC0000740 (buffer ptr)
02223646  8580     MOV.B   R0,@($0,R5)       ; Write status
02223648  6103     MOV     R0,R1              ; R1 = R0 (init min bound)
0222364A  6203     MOV     R0,R2              ; R2 = R0 (init max bound)
0222364C  8582     MOV.B   R0,@($2,R5)       ; Write status+2
0222364E  3013     CMP/GE  R1,R0              ; T = (R0 >= R1)?
02223650  8904     BT      $0222365C          ; If yes, branch
02223652  A006     BRA     $02223662          ; Else skip to next
02223654  6103     MOV     R0,R1              ; R1 = R0 (update min)
02223656  0000     DW      $0000
02223658  C000     DW      $C000
0222365A  0740     DW      $0740              ; Literal: 0xC0000740

; First comparison result
0222365C  3203     CMP/GE  R0,R2              ; T = (R2 >= R0)?
0222365E  8900     BT      $02223662          ; If yes, skip update
02223660  6203     MOV     R0,R2              ; R2 = R0 (update max)
02223662  8584     MOV.B   R0,@($4,R5)       ; Write status+4

; Second clamping iteration
02223664  3013     CMP/GE  R1,R0              ; Compare R0 vs R1 (min)
02223666  8901     BT      $0222366C          ; If R0 >= R1, skip update
02223668  A003     BRA     $02223672          ; Else branch
0222366A  6103     MOV     R0,R1              ; Update R1 = R0
0222366C  3203     CMP/GE  R0,R2              ; Compare R2 vs R0 (max)
0222366E  8900     BT      $02223672          ; If R2 >= R0, skip
02223670  6203     MOV     R0,R2              ; Update R2 = R0
02223672  8586     MOV.B   R0,@($6,R5)       ; Write status+6

; Third iteration
02223674  3013     CMP/GE  R1,R0
02223676  8901     BT      $0222367C
02223678  000B     RTS
0222367A  6103     MOV     R0,R1
0222367C  3203     CMP/GE  R0,R2
0222367E  8901     BT      $02223684
02223680  000B     RTS
02223682  6203     MOV     R0,R2
02223684  000B     RTS
02223686  0009     NOP

; Analysis: This function clamps coordinates using min/max bounds.
; Multiple CMP/GE + conditional moves implement the clamping logic:
;   if (R0 < R1) R1 = R0;  // Update minimum
;   if (R2 < R0) R2 = R0;  // Update maximum
; All intermediate values are written to R5 status register.


; ═══════════════════════════════════════════════════════════════════════════
; func_029: Quadrant/Region Code Generation
; ═══════════════════════════════════════════════════════════════════════════
; Address: 0x02223686 - 0x022236D8
; Size: 82 bytes
; Type: Leaf function
; Called by: func_023 (rendering dispatcher)
; Calls: none (leaf)
;
; Purpose: Computes region codes or quadrant bits based on coordinate
;          comparisons. Used to determine polygon clipping requirements.
;          Outputs region code in R10/R11 for later rendering decisions.
;
; Input:
;   R0, R1, R2 = Coordinate values (from comparisons)
;   R5 = Status/control register
;   R8 = Literal pool pointer
;
; Output:
;   R10 = Region/quadrant code for dimension 1 (0x00, 0x04, 0x08, 0x0C)
;   R11 = Region/quadrant code for dimension 2 (0x00, 0x04, 0x08, 0x0C)
;
; Registers Modified: R0, R1, R2, R8, R10, R11
;
; Key Operations:
;   Initialize R10=0, R11=0
;   Three iterations of CMP/GE + conditional MOV
;   Sets R10/R11 to quadrant codes (0x04, 0x08, 0x0C) based on comparisons
; ═══════════════════════════════════════════════════════════════════════════

func_029:
02223686  0009     NOP                        ; Entry alignment
02223688  D805     MOV.L   @(literal,PC),R8  ; R8 = 0xC0000742 (buffer ptr)
0222368A  8580     MOV.B   R0,@($0,R5)       ; Write status
0222368C  EA00     MOV     #$00,R10           ; R10 = 0 (init region code 1)
0222368E  EB00     MOV     #$00,R11           ; R11 = 0 (init region code 2)
02223690  6103     MOV     R0,R1              ; R1 = R0
02223692  6203     MOV     R0,R2              ; R2 = R0
02223694  8582     MOV.B   R0,@($2,R5)       ; Write status+2
02223696  3013     CMP/GE  R1,R0              ; T = (R0 >= R1)?
02223698  8904     BT      $022236A4          ; If yes, skip quadrant setting
0222369A  EA04     MOV     #$04,R10           ; R10 = 0x04 (set quadrant bit 1)
0222369C  A006     BRA     $022236AC          ; Jump to next test
0222369E  6103     MOV     R0,R1              ; Update R1 = R0
022236A0  C000     DW      $C000
022236A2  0742     DW      $0742              ; Literal: 0xC0000742

022236A4  3203     CMP/GE  R0,R2              ; T = (R2 >= R0)?
022236A6  8901     BT      $022236AC          ; If yes, skip
022236A8  EB04     MOV     #$04,R11           ; R11 = 0x04 (set quadrant bit 1)
022236AA  6203     MOV     R0,R2              ; Update R2 = R0
022236AC  8584     MOV.B   R0,@($4,R5)       ; Write status+4

; Second iteration - set quadrant code to 0x08
022236AE  3013     CMP/GE  R1,R0
022236B0  8902     BT      $022236B8
022236B2  EA08     MOV     #$08,R10           ; R10 = 0x08 (set quadrant 2)
022236B4  A004     BRA     $022236C0
022236B6  6103     MOV     R0,R1
022236B8  3203     CMP/GE  R0,R2
022236BA  8901     BT      $022236C0
022236BC  EB08     MOV     #$08,R11           ; R11 = 0x08 (set quadrant 2)
022236BE  6203     MOV     R0,R2
022236C0  8586     MOV.B   R0,@($6,R5)       ; Write status+6

; Third iteration - set quadrant code to 0x0C
022236C2  3013     CMP/GE  R1,R0
022236C4  8902     BT      $022236CC
022236C6  EA0C     MOV     #$0C,R10           ; R10 = 0x0C (set quadrant 3)
022236C8  000B     RTS
022236CA  6103     MOV     R0,R1
022236CC  3203     CMP/GE  R0,R2
022236CE  8902     BT      $022236D6
022236D0  EB0C     MOV     #$0C,R11           ; R11 = 0x0C (set quadrant 3)
022236D2  000B     RTS
022236D4  6203     MOV     R0,R2
022236D6  000B     RTS
022236D8  0009     NOP

; Analysis: This function encodes quadrant information using two output
; registers (R10, R11). Each has values: 0x00 (default), 0x04, 0x08, 0x0C
; based on three successive coordinate comparisons. This is the classic
; Cohen-Sutherland line clipping quadrant code algorithm.
; The codes are used by rendering functions to determine if clipping
; is needed.


; ═══════════════════════════════════════════════════════════════════════════
; func_032: Scanline Fill / Quad Rendering Loop
; ═══════════════════════════════════════════════════════════════════════════
; Address: 0x022236D8 - 0x022236F8
; Size: 32 bytes
; Type: Leaf function (loop helper)
; Called by: func_023 (rendering dispatcher)
; Calls: none (leaf)
;
; Purpose: Fills a quad region with pixels by iterating through scanlines.
;          Writes pixel values to frame buffer at address R9, advancing by
;          stride in R12. Continues until region code in R11 is reached.
;
; Input:
;   R9 = Frame buffer pointer (write address)
;   R10 = Current region code / loop counter
;   R11 = Target region code (loop terminator)
;   R12 = Stride / step value for next scanline
;
; Output:
;   Frame buffer filled with pixel data
;   R9 advanced to next scan line position
;
; Registers Modified: R0, R9
; ═══════════════════════════════════════════════════════════════════════════

func_032:
022236D8  0009     NOP                        ; Entry alignment
022236DA  D805     MOV.L   @(literal,PC),R8  ; R8 = 0xC0000740
022236DC  60A3     MOV     R10,R0             ; R0 = current region code
022236DE  018E     DW      $018E              ; Literal/opcode
022236E0  2912     MOV.L   R1,@R9             ; Write to frame buffer at R9
022236E2  30B0     CMP/EQ  R11,R0             ; Compare R0 (region) with R11 (end)
022236E4  8D06     BT/S    $022236F4          ; If equal, exit (branch with slot)
022236E6  7904     ADD     #$04,R9            ; Advance R9 by 4 (word boundary)
022236E8  30CC     ADD     R12,R0             ; R0 += R12 (advance region counter)
022236EA  AFF8     BRA     $022236DE          ; Loop back
022236EC  C90C     DW      $C90C
022236EE  0000     DW      $0000
022236F0  C000     DW      $C000
022236F2  0740     DW      $0740

022236F4  E0FF     MOV     #$FF,R0            ; Load end marker
022236F6  000B     RTS                        ; Return
022236F8  2902     MOV.L   R0,@R9             ; Write final pixel (delay slot)

; Analysis: This is a tight fill loop for scanline rendering.
; Loop structure:
;   MOV.L R1,@R9        ; Write one pixel
;   CMP/EQ R11,R0       ; Check if done
;   BT/S exit           ; Exit if region matches
;   ADD #$04,R9         ; Next frame buffer word
;   ADD R12,R0          ; Next region code
;   BRA loop            ; Continue
;
; The BT/S (branch with slot) optimization executes one final write
; even during the exit branch, minimizing bubble cycles.


; ═══════════════════════════════════════════════════════════════════════════
; func_033: Polygon Rendering / Scanline Generator
; ═══════════════════════════════════════════════════════════════════════════
; Address: 0x022236F8 - 0x0222375C
; Size: 98 bytes
; Type: Calls func_034 (rasterization helper)
; Called by: func_023 (rendering dispatcher)
; Calls: func_034 (Bresenham line rasterizer)
;
; Purpose: Top-level polygon rendering function. Processes each scanline
;          of a polygon, calling func_034 to rasterize each edge.
;          Handles clipping and bounds checking against context viewport.
;
; Input:
;   R14 = RenderingContext (contains viewport bounds at +0x14, +0x18)
;   R9 = Frame buffer pointer
;   R10, R11 = Region codes (from func_029)
;
; Output:
;   Polygon rasterized to frame buffer
;   R9 advanced through scanlines
;
; Registers Modified: R0-R7, R9
;
; Key Operations:
;   1. Multiple loops processing scanlines
;   2. Calls func_034 for each scanline's rasterization
;   3. Bounds checking against context viewport
;   4. Conditional branching based on region codes
; ═══════════════════════════════════════════════════════════════════════════

func_033:
022236F8  2902     MOV.L   R0,@R9             ; Store pixel data
022236FA  D80B     MOV.L   @(literal,PC),R8  ; Load buffer base
022236FC  60A3     MOV     R10,R0             ; R0 = region code 1
022236FE  53E5     MOV.L   @($14,R14),R3      ; R3 = ctx->bound_x2 (inner X)
02223700  018E     DW      $018E
02223702  641F     EXTS.W  R1,R4              ; R4 = sign_extend(R1[15:0])
02223704  3433     CMP/GE  R3,R4              ; Compare bounds
02223706  8911     BT      $0222372C          ; If R3 >= R4, branch
02223708  6213     MOV     R1,R2              ; Copy for next iteration
0222370A  30CC     ADD     R12,R0             ; Advance region
0222370C  C90C     DW      $C90C
0222370E  018E     DW      $018E
02223710  641F     EXTS.W  R1,R4              ; Sign extend again
02223712  3433     CMP/GE  R3,R4              ; Test bounds
02223714  8BF8     BF      $02223708          ; Loop if bounds OK (branch forward)

; Scanline loop - calls func_034 for edge rasterization
02223716  4F22     STS.L   PR,@-R15           ; Push return address
02223718  B021     BSR     $0222375E          ; Call func_034 (Bresenham rasterizer)
0222371A  0009     NOP
0222371C  4F26     LDS.L   @R15+,PR           ; Pop return address
0222371E  2932     MOV.L   R3,@R9             ; Store scanline result
02223720  7904     ADD     #$04,R9            ; Advance frame buffer
02223722  A008     BRA     $02223736          ; Jump to next phase
02223724  53E6     MOV.L   @($18,R14),R3      ; R3 = ctx->bound_y2 (inner Y)
02223726  0000     DW      $0000
02223728  C000     DW      $C000
0222372A  0740     DW      $0740

0222372C  2912     MOV.L   R1,@R9             ; Store edge pixel
0222372E  7904     ADD     #$04,R9            ; Advance FB
02223730  53E6     MOV.L   @($18,R14),R3      ; Load Y bound
02223732  30CC     ADD     R12,R0             ; Next region
02223734  C90C     DW      $C90C              ; Continue loop

02223736  6213     MOV     R1,R2              ; Move coordinate
02223738  018E     DW      $018E
0222373A  641F     EXTS.W  R1,R4              ; Sign extend coordinate
0222373C  3437     CMP/GT  R3,R4              ; Test Y bound
0222373E  8905     BT      $0222374C          ; Branch if out of bounds
02223740  2912     MOV.L   R1,@R9             ; Store scanline
02223742  7904     ADD     #$04,R9            ; Advance
02223744  30B0     CMP/EQ  R11,R0             ; Check loop terminator
02223746  8907     BT      $02223758          ; Exit if done
02223748  AFF4     BRA     $02223734          ; Continue loop
0222374A  30CC     ADD     R12,R0

0222374C  4F22     STS.L   PR,@-R15           ; Push PR (second call)
0222374E  B006     BSR     $0222375E          ; Call func_034 again
02223750  0009     NOP
02223752  4F26     LDS.L   @R15+,PR           ; Pop PR
02223754  2932     MOV.L   R3,@R9             ; Store result
02223756  7904     ADD     #$04,R9            ; Advance

02223758  E0FF     MOV     #$FF,R0            ; Exit code
0222375A  000B     RTS                        ; Return
0222375C  2902     MOV.L   R0,@R9             ; Store final (delay slot)

; Analysis: This function implements the scanline rendering algorithm.
; It processes polygon edges line-by-line, calling func_034 for each
; line's rasterization. The bounds checking ensures pixels stay within
; the render viewport.


; ═══════════════════════════════════════════════════════════════════════════
; func_034: Bresenham/Rasterization Helper
; ═══════════════════════════════════════════════════════════════════════════
; Address: 0x0222375C - 0x022237D0
; Size: 116 bytes
; Type: Leaf function
; Called by: func_033 (polygon renderer - 2× per scanline)
; Calls: none (leaf)
;
; Purpose: Implements Bresenham line algorithm (or similar) for rasterizing
;          a single scanline. Performs coordinate transformation and
;          integer division/interpolation. Heavy use of multiply-accumulate.
;
; Input:
;   R1, R2 = Endpoint coordinates (source pixels)
;   R3 = Clipping bound
;
; Output:
;   Rasterized scanline pixel data
;
; Registers Modified: R1-R7, MACL, MACH
;
; Key Operations:
;   1. EXTS.W R1,R4 / EXTS.W R2,R5 - Sign extend coordinates
;   2. CMP/GE / conditional SWAP - Ensure R1 < R2
;   3. SWAP.W for byte unpacking / 16-bit operations
;   4. SUB operations to compute deltas (dx, dy)
;   5. MULS.W for multiply, STS MACL for result
;   6. SHLL16, SHLL2 for scaling/interpolation
; ═══════════════════════════════════════════════════════════════════════════

func_034:
0222375C  2902     MOV.L   R0,@R9
0222375E  641F     EXTS.W  R1,R4              ; R4 = sign_extend(R1[15:0])
02223760  652F     EXTS.W  R2,R5              ; R5 = sign_extend(R2[15:0])
02223762  3543     CMP/GE  R4,R5              ; Compare coordinates
02223764  8902     BT      $0222376C          ; If R4 >= R5, skip swap
02223766  6413     MOV     R1,R4              ; Swap: R4 = R1
02223768  6123     MOV     R2,R1              ; R1 = R2
0222376A  6243     MOV     R4,R2              ; R2 = R4 (now R1 < R2)
0222376C  6419     SWAP.W  R1,R4              ; Byte swap for word operations
0222376E  644F     EXTS.W  R4,R4              ; Sign extend swapped value
02223770  6529     SWAP.W  R2,R5              ; Swap R2
02223772  655F     EXTS.W  R5,R5              ; Sign extend
02223774  3458     SUB     R5,R4              ; R4 = R4 - R5 (delta)

; ─────────────────────────────────────────────────────────────────────────
; Bresenham setup: compute error / slope
; ─────────────────────────────────────────────────────────────────────────
02223776  9718     MOV.W   @(literal,PC),R7   ; Load slope/error constant
02223778  651F     EXTS.W  R1,R5              ; Sign extend R1
0222377A  662F     EXTS.W  R2,R6              ; Sign extend R2
0222377C  3568     SUB     R6,R5              ; R5 = delta Y
0222377E  3757     CMP/GT  R5,R7              ; Compare deltas
02223780  8916     BT      $022237B0          ; Branch if Y delta large

; ─────────────────────────────────────────────────────────────────────────
; Main rasterization: multiply-accumulate for interpolation
; ─────────────────────────────────────────────────────────────────────────
02223782  D70A     MOV.L   @(literal,PC),R7   ; Load lookup table base
02223784  4500     SHLL    R5                 ; R5 <<= 1 (double for index)
02223786  375C     ADD     R5,R7              ; R7 += R5 (index lookup table)
02223788  6771     MOV.W   @R7,R7             ; Load value from table
0222378A  274F     MULS.W  R4,R7              ; R7 = R4 * R7 (signed multiply)
0222378C  651F     EXTS.W  R1,R5              ; R5 = R1
0222378E  673F     EXTS.W  R3,R7              ; R7 = R3
02223790  041A     STS     MACL,R4            ; R4 = MAC[31:0] (multiply result)
02223792  3758     SUB     R5,R7              ; R7 -= R5
02223794  4728     SHLL16  R7                 ; R7 <<= 16 (scale up)
02223796  4408     SHLL2   R4                 ; R4 <<= 2 (scale multiply result)
02223798  374D     DW      $374D              ; MAC-related operation
0222379A  633D     EXTU.W  R3,R3              ; R3 = zero_extend(R3[15:0])
0222379C  6419     SWAP.W  R1,R4              ; Swap R1
0222379E  070A     STS     MACH,R7            ; R7 = MAC[63:32] (high 32 bits)
022237A0  644F     EXTS.W  R4,R4              ; Sign extend swapped value
022237A2  374C     ADD     R4,R7              ; Accumulate
022237A4  4728     SHLL16  R7                 ; Final scaling
022237A6  000B     RTS
022237A8  237B     OR      R7,R3              ; Combine results (delay slot)

022237AA  FF01     DW      $FF01              ; Data
022237AC  0600     DW      $0600
022237AE  48D0     DW      $48D0              ; Table base address

022237B0  651F     EXTS.W  R1,R5
022237B2  673F     EXTS.W  R3,R7
022237B4  3758     SUB     R5,R7

; Analysis: This is intensive Bresenham rasterization code using fixed-point
; math and multiply-accumulate. The multiple EXTS.W operations sign-extend
; 16-bit values, and SHLL operations scale coordinates for fixed-point.
; The MULS.W and MAC operations perform the critical multiply operations
; for slope/error calculation.


; ═══════════════════════════════════════════════════════════════════════════
; func_036: Conditional block processor with bounds/value validation
; ═══════════════════════════════════════════════════════════════════════════
; Address: 0x022237D2 - 0x0222381A
; Size: 72 bytes
; Type: Hub (dispatcher)
; Called by: func_023 (rendering dispatcher)
; Calls: func_037 (bounds check), func_038 (value validation)
;
; Purpose: Processes a variable-length array of 4-byte blocks from R8, validating
; each value using bounds checks and conditional tests before writing to the frame
; buffer at R9. Terminates when 0xFF marker is encountered. Likely used for
; conditional polygon attribute setup (colors, flags, or transformation parameters).
;
; Input:
;   R8 = source data pointer (array of 4-byte words)
;   R9 = frame buffer write pointer
;   R14 = RenderingContext (contains bounds at +0x1C, +0x20)
;
; Output:
;   R9 = updated frame buffer pointer (incremented by 4 for each valid block)
;   Frame buffer = written data blocks (if validation passes)
;
; Registers Modified: R0, R1, R2, R3, R7, R8, R9, R10, R11, R12, PR
;
; Loop Termination: When R0 loaded from [R8] == 0xFF
; ═══════════════════════════════════════════════════════════════════════════

func_036:
022237D2  237B     OR      R7,R3              ; Initialize/combine register values (setup)
022237D4  FF00     DW      $FF00              ; Data word (used by setup)
022237D6  4F22     STS.L   PR,@-R15           ; [PROLOGUE] Save return address to stack
022237D8  B021     BSR     $0222381E          ; Call func_037 (bounds check, skip write)
022237DA  6381     MOV.W   @R8,R3             ; Load lower 16 bits from R8 → R3
022237DC  6A03     MOV     R0,R10             ; Copy R0 to R10 (preserve value)
022237DE  6C03     MOV     R0,R12             ; Copy R0 to R12 (save for comparison)
022237E0  6386     MOV.L   @R8+,R3            ; Load 32-bit word from R8, post-increment R8
022237E2  8B01     BF      $022237E8          ; Skip next block if condition failed
022237E4  2932     MOV.L   R3,@R9             ; Write R3 to frame buffer at R9
022237E6  7904     ADD     #$04,R9            ; Increment frame buffer pointer by 4
022237E8  B019     BSR     $0222381E          ; Call func_037 (bounds check again)
022237EA  6381     MOV.W   @R8,R3             ; Load next 16-bit value from R8 → R3
022237EC  6B03     MOV     R0,R11             ; Copy validation result to R11
022237EE  20C8     TST     R12,R0             ; Test R12 & R0 (bitwise AND, set flags)
022237F0  8B0C     BF      $0222380C          ; Skip validation if result is zero
022237F2  20CB     OR      R12,R0             ; R0 |= R12 (combine flags)
022237F4  C806     DW      $C806              ; Data word or encoded instruction
022237F6  8906     BT      $02223806          ; If T=1 (condition true), branch forward
022237F8  B01C     BSR     $02223834          ; Call func_038 (value check on R12)
022237FA  60C3     MOV     R12,R0             ; Load R12 into R0 for next validation
022237FC  B01A     BSR     $02223834          ; Call func_038 (value check on R11)
022237FE  60B3     MOV     R11,R0             ; Load R11 into R0
02223800  60B3     MOV     R11,R0             ; Duplicate load (redundant or timing)
02223802  C806     DW      $C806              ; Data word
02223804  8B02     BF      $0222380C          ; Branch if validation failed
02223806  6382     MOV.L   @R8,R3             ; Load 32-bit word from R8 (no increment)
02223808  2932     MOV.L   R3,@R9             ; Write R3 to frame buffer
0222380A  7904     ADD     #$04,R9            ; Increment frame buffer pointer
0222380C  7804     ADD     #$04,R8            ; Advance source pointer R8 by 4
0222380E  6CB3     MOV     R11,R12            ; R12 = R11 (propagate validation state)
02223810  6082     MOV.L   @R8,R0             ; Load next word for termination check
02223812  88FF     CMP/EQ  #$FF,R0            ; Compare R0 == 0xFF (terminator marker)
02223814  8BE8     BF      $022237E8          ; Loop back if not terminator
02223816  E0FF     MOV     #$FF,R0            ; Load 0xFF for final return value
02223818  4F26     LDS.L   @R15+,PR           ; [EPILOGUE] Pop return address from stack
0222381A  000B     RTS                        ; Return to caller

; Analysis: This hub function implements conditional data processing with two
; validation stages (bounds check via func_037, value validation via func_038).
; The loop processes 4-byte blocks (typical polygon attributes: RGBA color or
; coordinate/flag pairs) and only writes those that pass both checks. The 0xFF
; terminator allows variable-length arrays. The dual BSR $0222381E calls suggest
; two entry points into func_037: first checks without writing, second with write.


; ═══════════════════════════════════════════════════════════════════════════
; func_037: Bounds validation function
; ═══════════════════════════════════════════════════════════════════════════
; Address: 0x0222381C - 0x02223830
; Size: 20 bytes
; Type: Leaf (no calls)
; Called by: func_036 (conditional block processor, 2× calls)
; Calls: none
;
; Purpose: Validates that a value (R3) falls within the viewport bounds loaded
; from the RenderingContext. Tests lower bound and upper bound using signed
; comparison. Used by func_036 to gate frame buffer writes.
;
; Input:
;   R3 = value to validate (typically coordinate or parameter)
;   R14 = RenderingContext pointer (loads bounds from +0x1C, +0x20)
;
; Output:
;   R0 = validation status (0 if valid, non-zero if out of bounds)
;   T flag = set based on final comparison
;
; Registers Modified: R0, R1, R2
;
; Bounds Checks:
;   Lower: R3 >= context[+0x1C]  (inner/lower bound)
;   Upper: R3 <= context[+0x20]  (outer/upper bound)
;   Both must pass for valid result
; ═══════════════════════════════════════════════════════════════════════════

func_037:
0222381C  2902     MOV.L   R0,@R9             ; Write R0 to frame buffer (R9)
0222381E  51E7     MOV.L   @($1C,R14),R1     ; Load lower bound from context+0x1C → R1
02223820  52E8     MOV.L   @($20,R14),R2     ; Load upper bound from context+0x20 → R2
02223822  E000     MOV     #$00,R0            ; Clear R0 (assume valid)
02223824  3313     CMP/GE  R1,R3             ; T = (R3 >= R1) signed comparison
02223826  8900     BT      $0222382A          ; If T=1 (lower bound OK), continue
02223828  CB04     DW      $CB04              ; Data/invalid instruction (out of bounds)
0222382A  3233     CMP/GE  R3,R2             ; T = (R2 >= R3) signed comparison (upper)
0222382C  8900     BT      $02223830          ; If T=1 (upper bound OK), continue
0222382E  CB02     DW      $CB02              ; Data/invalid instruction (out of bounds)
02223830  000B     RTS                        ; Return to caller

; Analysis: Simple bounds validation using two signed comparisons. The flow:
; 1. Load bounds from rendering context (typical values: viewport edges)
; 2. Clear R0 (default to "valid")
; 3. Compare R3 >= lower bound; skip invalid data if false
; 4. Compare R3 <= upper bound; skip invalid data if false
; 5. Return (T flag indicates pass/fail)
; The DW $CB04/$CB02 entries are likely data or alignment, executed only on
; bounds violations (unreachable in normal flow due to BT branches).


; ═══════════════════════════════════════════════════════════════════════════
; func_038: Zero-value validation (conditional early return)
; ═══════════════════════════════════════════════════════════════════════════
; Address: 0x02223834 - 0x02223838
; Size: 4 bytes
; Type: Leaf (no calls)
; Called by: func_036 (value validation, 2× calls)
; Calls: none
;
; Purpose: Minimal validation check - returns immediately if R0 == 0,
; otherwise falls through. Used by func_036 for quick zero-value filtering.
; The function body is 2 instructions in 4 bytes (RTS is in delay slot).
;
; Input:
;   R0 = value to test
;
; Output:
;   T flag = 1 if R0 == 0, 0 if R0 != 0
;   Early return if R0 == 0
;
; Registers Modified: none (test-only)
;
; Note: RTS instruction executes in the delay slot of BF, so both paths
; return to the caller. This is the smallest function in the hotspot region.
; ═══════════════════════════════════════════════════════════════════════════

func_038:
02223834  8800     CMP/EQ  #$00,R0            ; T = (R0 == 0) comparison
02223836  8B01     BF      $0222383C          ; If T=0 (R0 != 0), branch forward
02223838  000B     RTS                        ; Return to caller (delay slot of BF)

; Analysis: Micro-optimization for quick zero-value filtering. The RTS in the
; delay slot of BF means both the taken and fall-through paths eventually
; return, making this a simple conditional pass-through. Used in func_036's
; validation pipeline to skip processing non-zero values. The target of BF
; at $0222383C (beyond function end) is likely dead code or continuation.


; ═══════════════════════════════════════════════════════════════════════════
; func_078: Polygon Type Dispatcher (6× Indirect Calls)
; ═══════════════════════════════════════════════════════════════════════════
; Address: 0x02224320 - 0x02224366
; Size: 68 bytes
; Type: Hub (dispatcher - 6× JSR @R0 indirect calls)
; Called by: func_023 (rendering dispatcher for specific polygon types)
; Calls: 6 function pointers loaded from literal pool
;
; Purpose: Dispatches to polygon-type-specific rendering handlers. Sets up
; rendering parameters (R1, R6, R7, R10, R11) before calling each handler.
; Likely implements different rendering paths for triangle, quad, sprite types.
;
; Input:
;   R14 = RenderingContext (preserved/setup)
;   Implicit parameters from context or prior setup
;
; Output:
;   6 handlers called in sequence with specific parameters
;   R1 = 0x01 (parameter 1)
;   R6 = 0x10 (parameter 2)
;   R7 = address (parameter 3)
;   R10 = address (parameter 4)
;   R11 = address (parameter 5)
;
; Registers Modified: R0, R1, R6, R7, R10, R11, PR
;
; Call Sequence: 6 JSR @R0 with NOP delay slots
; Function pointers at: PC+0x34, PC+0x38, PC+0x3C, PC+0x40, PC+0x44, PC+0x48
; ═══════════════════════════════════════════════════════════════════════════

func_078:
02224320  0009     NOP                        ; Alignment
02224322  0000     DW      $0000              ; Literal pool header
02224324  0603     STC     SR,R6              ; Save SR to R6 (status save)
02224326  3000     CMP/EQ  R0,R0              ; Always sets T=1
02224328  0000     DW      $0000              ; Data
0222432A  1300     MOV.L   R0,@($0,R3)       ; Conditional store
0222432C  0600     DW      $0600              ; Data
0222432E  EE00     MOV     #$00,R14           ; Initialize R14 = 0
02224330  0000     DW      $0000              ; Data
02224332  04C0     DW      $04C0              ; Data (mask/flag)

02224334  4F22     STS.L   PR,@-R15           ; [PROLOGUE] Save return address

; ─────────────────────────────────────────────────────────────────────────
; Load function pointer addresses and setup parameters
; ─────────────────────────────────────────────────────────────────────────
02224336  D00C     MOV.L   @($02224368,PC),R0 ; Load handler 1 address
02224338  400B     JSR     @R0                 ; Call handler 1 (indirect)
0222433A  0009     NOP                        ; Delay slot

0222433C  D00B     MOV.L   @($0222436C,PC),R0 ; Load handler 2 address
0222433E  400B     JSR     @R0                 ; Call handler 2 (indirect)
02224340  E101     MOV     #$01,R1             ; R1 = 0x01 (parameter 1) - delay slot

02224342  E610     MOV     #$10,R6             ; R6 = 0x10 (parameter 2)
02224344  D70A     MOV.L   @($02224370,PC),R7  ; R7 = address (parameter 3)
02224346  DA0B     MOV.L   @($02224374,PC),R10 ; R10 = address (parameter 4)
02224348  DB0B     MOV.L   @($02224378,PC),R11 ; R11 = address (parameter 5)

0222434A  D00C     MOV.L   @($0222437C,PC),R0 ; Load handler 3 address
0222434C  400B     JSR     @R0                 ; Call handler 3
0222434E  0009     NOP                        ; Delay slot

02224350  D00B     MOV.L   @($02224380,PC),R0 ; Load handler 4 address
02224352  400B     JSR     @R0                 ; Call handler 4
02224354  0009     NOP                        ; Delay slot

02224356  D00B     MOV.L   @($02224384,PC),R0 ; Load handler 5 address
02224358  400B     JSR     @R0                 ; Call handler 5
0222435A  0009     NOP                        ; Delay slot

0222435C  D00A     MOV.L   @($02224388,PC),R0 ; Load handler 6 address
0222435E  400B     JSR     @R0                 ; Call handler 6
02224360  0009     NOP                        ; Delay slot

02224362  4F26     LDS.L   @R15+,PR           ; [EPILOGUE] Restore return address
02224364  000B     RTS                        ; Return to caller

; Literal pool (function pointers)
02224366  0009     NOP
02224368  0600     DW      $0600              ; Handler 1
0222436A  3348     SUB     R4,R3              ; (data or part of address)

; Analysis: Classic function dispatch pattern. Sets up parameters once,
; then calls 6 handlers in sequence. Each handler likely implements a
; specific polygon rendering algorithm (triangle, quad, sprite, etc).
; The parameters (R1=0x01, R6=0x10, R7/R10/R11=addresses) are probably
; rendering attributes, buffer pointers, and mode flags.


; ═══════════════════════════════════════════════════════════════════════════
; func_079: Polygon Type Dispatcher Variant (6× Indirect Calls)
; ═══════════════════════════════════════════════════════════════════════════
; Address: 0x02224366 - 0x022243BE
; Size: 84 bytes
; Type: Hub (dispatcher - 6× JSR @R0 indirect calls)
; Called by: func_023 or higher-level dispatcher
; Calls: 6 function pointers loaded from literal pool
;
; Purpose: Similar to func_078 but with more setup code and parameter
; initialization. Dispatch handler for alternative polygon rendering
; path or specialized rendering mode (textured, shaded, etc).
;
; Input:
;   Implicit setup from caller context
;
; Output:
;   6 handlers invoked with parameters in R0-R11
;   R1 = 0x01
;   R7 = word value read from address in R1
;   R8, R10, R11 = address parameters
;
; Registers Modified: R0, R1, R6, R7, R8, R10, R11, R13, R15, PR
;
; Loop Structure: Sequential JSR calls with embedded literal pool
; ═══════════════════════════════════════════════════════════════════════════

func_079:
02224366  0009     NOP                        ; Alignment
02224368  0600     DW      $0600              ; Data
0222436A  3348     SUB     R4,R3              ; (part of literal pool)
0222436C  0600     DW      $0600              ; Data
0222436E  441C     DW      $441C              ; Data (address or offset)
02224370  0000     DW      $0000              ; Data
02224372  04C0     DW      $04C0              ; Data (mask)
02224374  0600     DW      $0600              ; Data
02224376  EDFC     MOV     #$FC,R13           ; R13 = 0xFC (likely stride/counter)
02224378  0603     STC     SR,R6              ; R6 = SR (save status)
0222437A  2FF0     MOV.B   R15,@R15           ; Store byte (unusual operation)
0222437C  C000     DW      $C000              ; Data (address literal)
0222437E  0022     DW      $0022              ; Data (part of address)
02224380  0600     DW      $0600              ; Data
02224382  34EE     ADDC    R14,R4             ; Add with carry (setup)
02224384  0600     DW      $0600              ; Data
02224386  4438     DW      $4438              ; Data (address)
02224388  0600     DW      $0600              ; Data
0222438A  43E0     DW      $43E0              ; Data

0222438C  4F22     STS.L   PR,@-R15           ; [PROLOGUE] Save return address

; ─────────────────────────────────────────────────────────────────────────
; Setup phase - more parameter initialization than func_078
; ─────────────────────────────────────────────────────────────────────────
0222438E  D00C     MOV.L   @($022243C0,PC),R0 ; Load handler 1 address
02224390  400B     JSR     @R0                 ; Call handler 1
02224392  0009     NOP                        ; Delay slot

02224394  D00B     MOV.L   @($022243C4,PC),R0 ; Load handler 2 address
02224396  400B     JSR     @R0                 ; Call handler 2
02224398  E101     MOV     #$01,R1             ; R1 = 0x01 - delay slot

0222439A  D10B     MOV.L   @($022243C8,PC),R1 ; Load address into R1
0222439C  6711     MOV.W   @R1,R7              ; R7 = word at [R1] (dereference)
0222439E  D80B     MOV.L   @($022243CC,PC),R8  ; R8 = address parameter
022243A0  D00B     MOV.L   @($022243D0,PC),R0 ; Load handler 3 address
022243A2  400B     JSR     @R0                 ; Call handler 3
022243A4  0009     NOP                        ; Delay slot

022243A6  D00B     MOV.L   @($022243D4,PC),R0 ; Load handler 4 address
022243A8  400B     JSR     @R0                 ; Call handler 4
022243AA  0009     NOP                        ; Delay slot

022243AC  D00A     MOV.L   @($022243D8,PC),R0 ; Load handler 5 address
022243AE  400B     JSR     @R0                 ; Call handler 5
022243B0  0009     NOP                        ; Delay slot

022243B2  D00A     MOV.L   @($022243DC,PC),R0 ; Load handler 6 address
022243B4  400B     JSR     @R0                 ; Call handler 6
022243B6  0009     NOP                        ; Delay slot

022243B8  4F26     LDS.L   @R15+,PR           ; [EPILOGUE] Restore return address
022243BA  000B     RTS                        ; Return to caller

022243BC  0009     NOP
022243BE  0000     DW      $0000

; Analysis: Extended version of the dispatch pattern. Includes more
; parameter setup (R7 loaded via dereference, R8 explicit setup) before
; calling handlers 3-6. The embedded data and STC/ADDC operations suggest
; this variant handles more complex rendering modes or maintains additional
; state compared to func_078.


; ═══════════════════════════════════════════════════════════════════════════
; func_101: Register Save/Restore Wrapper with Indirect Dispatch
; ═══════════════════════════════════════════════════════════════════════════
; Address: 0x02224AEC - 0x02224B74
; Size: 136 bytes
; Type: Hub (wrapper + indirect call)
; Called by: func_100 (larger dispatch function)
; Calls: func_102 (via BSR), indirect function via JSR @R0
;
; Purpose: Full register preservation wrapper for complex indirect dispatch.
; Saves all 14 general-purpose registers to stack before indirect function call,
; ensuring caller transparency. Calls func_102 helper after JSR @R0.
;
; Register Preservation: STS.L PR / MOV.L R0-R14 save / JSR @R0 / restore all
; Data flow: R9 = input stream, R10 = address from literal pool
; ═══════════════════════════════════════════════════════════════════════════

; [Abbreviated: see full source in sh2_3d_engine.asm for complete disassembly]

; Key operations:
;   0x02224B00: STS.L PR,@-R15 (save return address)
;   0x02224B02-0x02224B1E: Save R0-R14 (15 registers)
;   0x02224B3C: JSR @R0 (indirect call)
;   0x02224B50: BSR func_102 (call helper)
;   0x02224B54-0x02224B70: Restore R14-R0
;   0x02224B72: Return (LDS.L @R15+,PR; RTS)


; ═══════════════════════════════════════════════════════════════════════════
; func_105: Data Stream Processor with State Machine Loop
; ═══════════════════════════════════════════════════════════════════════════
; Address: 0x02224C7E - 0x02224CF0
; Size: 150 bytes
; Type: Hub (loop with JSR @R0 indirect call)
; Called by: func_023 or func_100 dispatcher
; Calls: Indirect function via JSR @R0
;
; Purpose: Sophisticated data stream decoder/processor. Implements state machine
; using bit field extraction, variable-length field decoding with nested loops.
; Likely used for decompressing polygon attributes or decoding command opcodes.
;
; Key pattern: Byte extraction (EXTU.B @R9+) → bit manipulation (SHLL, AND, OR)
; → conditional branching → loop management (DT R6, BF)
;
; Algorithm flow:
;   1. Read byte from stream R9
;   2. Extract nibbles/fields using AND/OR masks
;   3. Shift bits with SHLL8/SHLL16/SHLR operations
;   4. Nested loop with DT/BF for variable-length decoding
;   5. Write output to [R10+offset]
;
; Data format handled: Likely Huffman or variable-length encoded polygon data
; ═══════════════════════════════════════════════════════════════════════════


; ═══════════════════════════════════════════════════════════════════════════
; func_106: Complex Multi-Path Rendering Dispatcher
; ═══════════════════════════════════════════════════════════════════════════
; Address: 0x02224D16 - 0x02224E82
; Size: 366 bytes
; Type: Hub (complex dispatcher with 2× BSR calls + JMP @R0)
; Called by: func_023 or scene graph dispatcher
; Calls: func_107 (BSR), func_108 (BSR)
;
; Purpose: High-level rendering dispatcher implementing multi-mode polygon
; processing. Performs full register save/restore, extracts rendering mode
; from input stream, computes dispatch offsets, and branches to one of
; multiple rendering paths via JMP @R0 indirect jump.
;
; Rendering modes: Different paths handle different polygon attributes
; (quads, triangles, sprites, with color/transparency/texture variants)
;
; Key features:
;   - Full register preservation (15 registers save/restore)
;   - Byte stream parsing from R9 (mode, attributes, counts)
;   - Dynamic parameter calculation (shifts, adds, bit manipulations)
;   - Multiple conditional code paths with loops
;   - Calls to specialized handlers (func_107, func_108)
;   - JMP @R0 for final dispatch to runtime-selected handler
;
; Loop structures: Multiple strided write loops (MOV.W to [R10], ADD stride)
; with DT/BF loop controls
; ═══════════════════════════════════════════════════════════════════════════


; ═══════════════════════════════════════════════════════════════════════════
; func_100: Lookup Table / Sine-Cosine Values (1112 bytes)
; ═══════════════════════════════════════════════════════════════════════════
; Address: 0x02224692 - 0x02224AEA
; Size: 1112 bytes
; Type: Data segment (embedded lookup table)
; Called by: Referenced by address as RO data
; Calls: None (not executable)
;
; Content: Mathematical lookup tables for 3D transformations
; - Likely sine/cosine values for rotation matrices
; - Or transformation coefficients for lighting/perspective
; - Or palette/color lookup tables
;
; Data pattern: 16-bit signed values, predominantly in range 0xFFBx-0xFFC0
; suggests normalized fixed-point values (-64.0 to -1.0 in 16.16 format)
;
; Usage: Loaded via MOV.L literal pool addressing during transformation setup
; ═══════════════════════════════════════════════════════════════════════════


; ═══════════════════════════════════════════════════════════════════════════
; PRIORITY 6: SMALL LEAF FUNCTIONS (Quick-Win Utility Functions)
; ═══════════════════════════════════════════════════════════════════════════
;
; These 11 functions are small (2-16 bytes), self-contained utility operations.
; Common patterns: register moves, conditional assignments, byte operations,
; data initialization loops. Used throughout rendering pipeline for parameter
; setup and boundary checking.
;
; ═══════════════════════════════════════════════════════════════════════════


; ═══════════════════════════════════════════════════════════════════════════
; func_000: Data Initialization Loop with Stride
; ═══════════════════════════════════════════════════════════════════════════
; Address: 0x0222300A - 0x0222301A
; Size: 16 bytes
; Type: Leaf function (no calls)
; Called by: Unknown (possibly initialization routine)
; Calls: None (leaf)
;
; Purpose: Copies 12 blocks of data from source (R13) to destination (R12) with
; configurable stride. This is likely an initialization routine that sets up
; rendering state or buffers by repeatedly writing to addresses spaced by
; stride intervals.
;
; Input:
;   R13 = Source data pointer (will be incremented by auto-increment addressing)
;   R12 = Destination base address (will be incremented by stride)
;   R7  = Loop counter (initialized to 0x0C = 12 iterations)
;   (Stride value assumed pre-set in R12 or through addressing)
;
; Output:
;   R12 = Final destination address (R12 + 12 × stride)
;   Memory[R12 + stride*i] = Data[R13 + 4*i] for i=0..11
;
; Registers Modified: R0, R7, R12
;
; Loop Pattern: DT R7 (decrement and test), BF/S (branch if false with delay slot)
; The /S suffix means the ADD #$04,R12 executes in the branch delay slot
; ═══════════════════════════════════════════════════════════════════════════

func_000:
0222300A  300C     ADD     R0,R0                  ; Possible alignment padding or dummy op
0222300C  DC04     MOV.L   @($02223020,PC),R12   ; Load dest base address from literal pool
0222300E  E70C     MOV     #$0C,R7                ; R7 = 12 (loop counter)
02223010  60D6     MOV.L   @R13+,R0              ; R0 = [R13++] (load source data, 4 bytes)
02223012  2C02     MOV.L   R0,@R12               ; [R12] = R0 (write to destination)
02223014  4710     DT      R7                    ; R7--; T = (R7 == 0)
02223016  8FFB     BF/S    $02223010             ; If T=0, branch back to 02223010
02223018  7C04     ADD     #$04,R12              ; [delay slot] R12 += 4 (stride increment)
0222301A  000B     RTS                           ; Return

;
; Algorithm Analysis:
;   The loop copies exactly 12 32-bit words from contiguous source to stride-spaced
;   destination. This is used for initializing arrays where data must be separated
;   by a fixed stride (common for texture coordinates, vertex attributes, etc.).
;   The stride is hardcoded to +4 bytes per iteration (not configurable).
;
; Cycle Count: ~8 cycles per iteration × 12 = ~96 cycles + setup/exit
; ═══════════════════════════════════════════════════════════════════════════


; ═══════════════════════════════════════════════════════════════════════════
; func_003: Utility - Parameter Setup (Called by func_002)
; ═══════════════════════════════════════════════════════════════════════════
; Address: 0x022230CC - 0x022230DA
; Size: 14 bytes
; Type: Leaf function (no calls)
; Called by: func_002 (display list handler - one of two options)
; Calls: None (leaf)
;
; Purpose: Part of a pair of display list handlers (func_003, func_004).
; This function performs parameter extraction or configuration setup for
; a specific command type. Called when display list command has Bit 0 = 1.
;
; Note: Disassembly appears misaligned or contains embedded data. The actual
; instruction boundaries and control flow may differ from what the disassembler
; reports. Requires runtime analysis or manual verification with SH2 CPU docs.
;
; Pattern: MOV operations with address calculations suggest register manipulation
; or memory-based parameter processing.
;
; Input: Display list command in R1 (from func_002)
; Output: Rendering state modified (likely R14 context or frame buffer setup)
;
; Registers Modified: R4, R7 (inferred from MOV operations)
; ═══════════════════════════════════════════════════════════════════════════

; func_003 disassembly (with alignment uncertainties noted):
022230CC  0009     NOP                            ; Padding
022230CE  37CC     ADD     R12,R7                 ; R7 += R12
022230D0  AFFA     BRA     $022230C8              ; Unconditional branch (unusual)
022230D2  1743     MOV.L   R4,@($C,R7)           ; [R7+12] = R4
022230D4  36AC     ADD     R10,R6                ; R6 += R10
022230D6  37CC     ADD     R12,R7                ; R7 += R12
022230D8  5463     MOV.L   @($C,R6),R4           ; R4 = [R6+12]
022230DA  000B     RTS                           ; Return

;
; ⚠️ WARNING: This disassembly is suspicious.
;   - BRA instruction branches backward to 022230C8 (BEFORE function entry)
;   - This could indicate: (1) misaligned disassembly due to embedded data,
;     (2) cross-function tail recursion, or (3) tool limitation with SH2 opcodes
;   - The actual execution flow is unclear without runtime validation
; ═══════════════════════════════════════════════════════════════════════════


; ═══════════════════════════════════════════════════════════════════════════
; func_004: Utility - Parameter Setup (Called by func_002)
; ═══════════════════════════════════════════════════════════════════════════
; Address: 0x022230DC - 0x022230E4
; Size: 8 bytes
; Type: Leaf function (no calls)
; Called by: func_002 (display list handler - alternative path)
; Calls: None (leaf)
;
; Purpose: Alternative display list handler (selected when Bit 0 = 0).
; Performs similar parameter setup to func_003 but with different implementation
; or target registers.
;
; Note: Like func_003, this disassembly appears problematic. The instruction
; sequence looks like continuation from func_003 or embedded data rather than
; independent function code.
;
; Pattern: Memory load/store operations on R6/R7 with fixed offsets
; ═══════════════════════════════════════════════════════════════════════════

; func_004 disassembly (with alignment uncertainties noted):
022230DC  1743     MOV.L   R4,@($C,R7)           ; [R7+12] = R4
022230DE  36CC     ADD     R12,R6                ; R6 += R12
022230E0  37CC     ADD     R12,R7                ; R7 += R12
022230E2  5463     MOV.L   @($C,R6),R4           ; R4 = [R6+12]
022230E4  000B     RTS                           ; Return

;
; ⚠️ WARNING: This disassembly is also suspicious.
;   - The instructions appear identical to func_003 (same MOV/ADD pattern)
;   - This could be data reuse, misalignment, or actual duplicated code paths
;   - Execution semantics cannot be verified without runtime analysis
; ═══════════════════════════════════════════════════════════════════════════


; ═══════════════════════════════════════════════════════════════════════════
; func_025: Coordinate/Parameter Processing Helper
; ═══════════════════════════════════════════════════════════════════════════
; Address: 0x02223632 - 0x02223640
; Size: 14 bytes
; Type: Leaf function (no calls)
; Called by: func_024 or coordinate transformation pipeline
; Calls: None (leaf)
;
; Purpose: Processes coordinate or parameter values extracted from input stream.
; Loads 16-bit values from memory, performs ADD and SUB operations, applies
; conditional negation. Used as part of parameter extraction before rendering.
;
; Input:
;   R8  = Source pointer (memory address)
;   R1  = Offset or configuration value
;   R2  = Comparison threshold
;   R9  = Output buffer pointer
;
; Output:
;   [R9+12] = Processed value
;   R0 = Final computed value
;   Registers R4 modified
;
; Registers Modified: R0, R1, R4
;
; Algorithm: Load two halfwords → apply ADD/SUB arithmetic → conditional NEG
; ═══════════════════════════════════════════════════════════════════════════

func_025:
02223632  1903     MOV.L   R0,@($C,R9)           ; [R9+12] = R0 (store output)
02223634  6085     MOV.W   @R8+,R0               ; R0 = *(int16_t*)R8; R8++ (load halfword)
02223636  6485     MOV.W   @R8+,R4               ; R4 = *(int16_t*)R8; R8++ (load next halfword)
02223638  301C     ADD     R1,R0                 ; R0 += R1 (add offset)
0222363A  8196     MOV.B   R0,@($6,R1)           ; *(int8_t*)(R1+6) = low_byte(R0) (store byte)
0222363C  3428     SUB     R2,R4                 ; R4 -= R2 (subtract threshold)
0222363E  604B     NEG     R4,R0                 ; R0 = -R4 (arithmetic negation with conditions)
02223640  000B     RTS                           ; Return

;
; Analysis:
;   This function processes coordinate/attribute data with bounds checking.
;   The ADD/SUB/NEG sequence suggests either clamping or sign-flip operations
;   commonly used in frustum culling or coordinate normalization.
; ═══════════════════════════════════════════════════════════════════════════


; ═══════════════════════════════════════════════════════════════════════════
; func_027: Conditional Value Assignment (Boundary Comparison)
; ═══════════════════════════════════════════════════════════════════════════
; Address: 0x0222367A - 0x02223680
; Size: 6 bytes
; Type: Leaf function (no calls)
; Called by: Coordinate validation or clipping functions
; Calls: None (leaf)
;
; Purpose: Conditionally selects between two register values based on comparison.
; Sets R1 = R0, then tests if R0 >= R2. If true, branches past final MOV.
; This implements: if (R0 >= R2) { R1 = R0 } else { R2 = R0 }
;
; Input:
;   R0 = Test value
;   R2 = Boundary/threshold value
;
; Output:
;   R1 = R0 (always assigned first)
;   R2 = R0 (only if R0 < R2) - implements minimum clamping
;   T  = Comparison result
;
; Registers Modified: R1 (always), R2 (conditional)
; ═══════════════════════════════════════════════════════════════════════════

func_027:
0222367A  6103     MOV     R0,R1                  ; R1 = R0
0222367C  3203     CMP/GE  R0,R2                 ; T = (R0 >= R2) ? 1 : 0
0222367E  8901     BT      $02223684             ; If T=1, skip next MOV
02223680  000B     RTS                           ; Return
02223682  6203     MOV     R0,R2                 ; R2 = R0 (only if R0 < R2)
02223684  000B     RTS                           ; Return

;
; Purpose: Minimum value function - ensures R2 >= R0 by conditionally updating R2.
; This pattern appears in boundary checking loops for clipping or viewport tests.
;
; Cycle Count: 3-4 cycles (varies on BT outcome)
; ═══════════════════════════════════════════════════════════════════════════


; ═══════════════════════════════════════════════════════════════════════════
; func_028: Trivial Register Copy
; ═══════════════════════════════════════════════════════════════════════════
; Address: 0x02223682 - 0x02223684
; Size: 2 bytes (1 instruction + RTS)
; Type: Leaf function (no calls)
; Called by: Coordinate or state setup functions
; Calls: None (leaf)
;
; Purpose: Minimal utility function that copies R0 to R2 and returns.
; Used as parameter pass-through or value initialization in coordinate pipeline.
;
; Input:
;   R0 = Value to copy
;
; Output:
;   R2 = R0
;
; Registers Modified: R2
; ═══════════════════════════════════════════════════════════════════════════

func_028:
02223682  6203     MOV     R0,R2                  ; R2 = R0
02223684  000B     RTS                           ; Return

;
; This 2-byte function is a trivial register copy, likely inlined by optimizing
; compilers but present here as a callable routine (possibly for compatibility
; or code organization). Zero-overhead wrapper for value propagation.
; ═══════════════════════════════════════════════════════════════════════════


; ═══════════════════════════════════════════════════════════════════════════
; func_030: Conditional Parameter Assignment with Comparison
; ═══════════════════════════════════════════════════════════════════════════
; Address: 0x022236CA - 0x022236D2
; Size: 8 bytes
; Type: Leaf function (no calls)
; Called by: Parameter initialization or conditional rendering path selection
; Calls: None (leaf)
;
; Purpose: Sets R1=R0, then conditionally sets R11=0x0C if R0 < R2.
; This implements: R1 = R0; if (R0 < R2) R11 = 0x0C
; Used for setting up rendering parameters or loop counters based on bounds.
;
; Input:
;   R0 = Primary value
;   R2 = Boundary/threshold
;
; Output:
;   R1 = R0 (always)
;   R11 = 0x0C (if R0 < R2), unchanged (if R0 >= R2)
;   T  = Comparison result
;
; Registers Modified: R1, R11 (conditional)
; ═══════════════════════════════════════════════════════════════════════════

func_030:
022236CA  6103     MOV     R0,R1                  ; R1 = R0
022236CC  3203     CMP/GE  R0,R2                 ; T = (R0 >= R2) ? 1 : 0
022236CE  8902     BT      $022236D6             ; If T=1, skip MOV
022236D0  EB0C     MOV     #$0C,R11              ; R11 = 0x0C (only if R0 < R2)
022236D2  000B     RTS                           ; Return
022236D4  6203     MOV     R0,R2                 ; [Note: part of func_031]
022236D6  000B     RTS                           ; Return (target of BT)

;
; Analysis: Conditional initialization of loop counter R11 (value 12).
; Used in rendering loops where iteration count depends on viewport bounds.
; ═══════════════════════════════════════════════════════════════════════════


; ═══════════════════════════════════════════════════════════════════════════
; func_031: Trivial Register Copy (Variant 2)
; ═══════════════════════════════════════════════════════════════════════════
; Address: 0x022236D4 - 0x022236D6
; Size: 2 bytes (1 instruction + RTS)
; Type: Leaf function (no calls)
; Called by: Value propagation in coordinate pipeline
; Calls: None (leaf)
;
; Purpose: Copies R0 to R2, similar to func_028 but at different code address.
; May be reached via branch target from func_030.
;
; Input:
;   R0 = Value to copy
;
; Output:
;   R2 = R0
;
; Registers Modified: R2
; ═══════════════════════════════════════════════════════════════════════════

func_031:
022236D4  6203     MOV     R0,R2                  ; R2 = R0
022236D6  000B     RTS                           ; Return

;
; This appears to be either a duplicate of func_028 or a branch target within
; a larger function. Both implement the same trivial operation.
; ═══════════════════════════════════════════════════════════════════════════


; ═══════════════════════════════════════════════════════════════════════════
; func_049: Utility Function - Disassembly Unclear
; ═══════════════════════════════════════════════════════════════════════════
; Address: 0x02223C42 - 0x02223C4A
; Size: 8 bytes
; Type: Leaf function (no calls)
; Called by: Unknown (not in visible call graph)
; Calls: None (leaf)
;
; Purpose: Purpose unclear - disassembly shows unusual pattern with NOP, data-like
; words (DW directives), and branch instruction that doesn't form valid control flow.
;
; Disassembly Analysis:
;   - Starts with NOP (padding or alignment)
;   - Contains DW $C505, $C802 (data words that decode as instructions)
;   - BF instruction branches backward
;   - Possible embedded data table or misalignment
;
; ⚠️ WARNING: This disassembly is problematic and cannot be reliably analyzed.
;   Possibilities:
;   1. Data section misidentified as code
;   2. Disassembler alignment issue with SH2 instruction boundaries
;   3. Embedded lookup table with multiple interpretations
;   4. Requires runtime execution trace or manual verification
;
; Registers Modified: Unknown
; ═══════════════════════════════════════════════════════════════════════════

func_049:
02223C42  0009     NOP                            ; Padding or alignment
02223C44  C505     DW      $C505                  ; Data word (unclear purpose)
02223C46  C802     DW      $C802                  ; Data word (unclear purpose)
02223C48  8BFC     BF      $02223C44             ; Branch if false (unusual control)
02223C4A  000B     RTS                           ; Return

;
; This function cannot be reliably annotated without additional context or
; runtime analysis. The instructions may not form meaningful operations.
; ═══════════════════════════════════════════════════════════════════════════


; ═══════════════════════════════════════════════════════════════════════════
; func_052: Utility Function - Disassembly Unclear
; ═══════════════════════════════════════════════════════════════════════════
; Address: 0x02223CA2 - 0x02223CAC
; Size: 10 bytes
; Type: Leaf function (no calls)
; Called by: Unknown (not in visible call graph)
; Calls: None (leaf)
;
; Purpose: Purpose unclear - similar disassembly issues to func_049.
;
; Disassembly Analysis:
;   - Starts with NOP
;   - MOV R2,R0 (register copy)
;   - DW $C801 (data word)
;   - BF with branch to func_053 entry point
;   - SWAP.B operation
;   - RTS return
;
; Partial Analysis:
;   If instructions are valid, the SWAP.B R4,R0 swaps bytes of R4 into R0,
;   commonly used for endianness conversion or byte unpacking. However, the
;   control flow with DW and BF suggests misalignment.
;
; ⚠️ WARNING: Disassembly reliability is low. The BF instruction branches
;   directly to the next function (func_053), suggesting possible misalignment
;   or data table.
;
; Registers Modified: R0, R4 (if control flow is as shown)
; ═══════════════════════════════════════════════════════════════════════════

func_052:
02223CA2  0009     NOP                            ; Padding
02223CA4  6023     MOV     R2,R0                  ; R0 = R2
02223CA6  C801     DW      $C801                  ; Data word (unclear)
02223CA8  8B02     BF      $02223CB0             ; Branch to func_053
02223CAA  6048     SWAP.B  R4,R0                 ; R0 = byte_swap(R4)
02223CAC  000B     RTS                           ; Return

;
; This function's semantics are highly uncertain. Requires runtime validation.
; ═══════════════════════════════════════════════════════════════════════════


; ═══════════════════════════════════════════════════════════════════════════
; func_053: Byte Store Operation
; ═══════════════════════════════════════════════════════════════════════════
; Address: 0x02223CAE - 0x02223CB0
; Size: 2 bytes (1 instruction + RTS)
; Type: Leaf function (no calls)
; Called by: Memory writing operations, texture or buffer updates
; Calls: None (leaf)
;
; Purpose: Stores a byte from R0 to memory location pointed to by R1.
; Primitive operation for byte-level memory writes.
;
; Input:
;   R0 = Byte value (only low 8 bits used)
;   R1 = Target memory address
;
; Output:
;   *(uint8_t*)R1 = low_byte(R0)
;
; Registers Modified: None (memory modified)
; ═══════════════════════════════════════════════════════════════════════════

func_053:
02223CAE  2100     MOV.B   R0,@R1                ; *(int8_t*)R1 = low_byte(R0)
02223CB0  000B     RTS                           ; Return

;
; Minimal 2-byte function for byte write operations. Used in tight loops
; where individual byte updates are needed (palette writes, etc.).
;
; Cycle Count: 2 cycles (MOV + RTS)
; ═══════════════════════════════════════════════════════════════════════════


; ═══════════════════════════════════════════════════════════════════════════
; End of Annotated Disassembly (Hotspot Functions)
; ═══════════════════════════════════════════════════════════════════════════
;
; For complete disassembly, see: disasm/sh2_3d_engine.asm
; For function call graph, see: disasm/sh2_3d_engine_callgraph.txt
; For comprehensive analysis, see: analysis/ directory
;
; Key Documents:
;   - ANNOTATION_GUIDE.md - How to annotate functions
;   - ANNOTATION_TASKS.md - What to annotate next
;   - SH2_DATA_STRUCTURES.md - Memory layouts
;
; ═══════════════════════════════════════════════════════════════════════════
