/*
 * func_067+: VDP and Hardware Functions
 * ROM File Offset: 0x23FC4 - 0x24200+ (~576+ bytes)
 * SH2 Address Range: 0x02223FC4 - 0x02224200+
 *
 * This region contains VDP initialization, hardware register setup,
 * and specialized rendering utilities that interface directly with
 * the 32X VDP hardware.
 */

.section .text
.align 2

/* ═══════════════════════════════════════════════════════════════════════════
 * func_067: RLE-like Data Unpacker
 * Entry: 0x02223FC6
 * Size: ~44 bytes
 *
 * Purpose: Unpack compressed data using run-length encoding variant.
 *          Reads control bytes that specify repeat counts and values.
 *
 * Input:
 *   R14 = Context pointer
 *         @+0x08 = Source data pointer (R8)
 *         @+0x04 = Destination pointer (R9)
 *   R13 = Stride/line offset
 *
 * Algorithm:
 *   1. Load line count from source
 *   2. For each line:
 *      a. Read control word
 *      b. If zero, move to next line
 *      c. Extract count and value
 *      d. Fill count bytes with value
 *   3. Advance destination by R13 each line
 * ═══════════════════════════════════════════════════════════════════════════ */
func_067:
    mov.l   @(8,r14),r8             /* R8 = source pointer */
    mov.l   @(4,r14),r9             /* R9 = dest pointer */
    mov.w   @r8+,r7                 /* R7 = line count */
    mov     r9,r1                   /* R1 = current dest */

.line_loop:
    mov.w   @r8+,r0                 /* R0 = control word */
    cmp/eq  #0,r0                   /* Zero = end of line */
    bt      .next_line

    extu.b  r0,r6                   /* R6 = low byte (count) */
    shlr8   r0                      /* R0 = high byte (value) */
    /* C8FF = TST #$FF,R0 - test if zero fill */
    bt      .zero_fill

.fill_loop:
    dt      r6                      /* Decrement count */
    bf/s    .fill_loop
    mov.b   r0,@-r1                 /* Write value, decrement dest */
    bra     .line_loop
    mov.w   @r8+,r0

.zero_fill:
    bra     .line_loop
    sub     r6,r1                   /* Skip r6 bytes */

.next_line:
    dt      r7                      /* Decrement line count */
    bf/s    .line_loop
    add     r13,r9                  /* Next line = R9 + stride */
    rts
    nop

/* ═══════════════════════════════════════════════════════════════════════════
 * func_068-070: RLE Unpacker Variants
 * Entries: 0x02223FF4, 0x02224002, 0x0222400E
 *
 * Purpose: Alternative entry points for RLE unpacker with different
 *          initialization. Handle mirroring, stride negation, etc.
 * ═══════════════════════════════════════════════════════════════════════════ */
func_068:
    mov.l   @(8,r14),r8
    mov.l   @(4,r14),r9
    add     #2,r8                   /* Skip first word */
    mov.b   r0,@(1,r5)
    mov     r0,r7
    bra     func_067.line_loop
    neg     r13,r13                 /* Negate stride (mirror) */

func_069:
    mov.l   @(8,r14),r8
    mov.l   @(4,r14),r9
    add     #2,r8
    mov.b   r0,@(1,r5)
    bra     func_067.line_loop
    mov     r0,r7

func_070:
    mov.l   @(8,r14),r8
    mov.l   @(4,r14),r9
    mov     #0xFC,r0                /* Adjustment value */
    /* ... continues with variant initialization ... */

/* ═══════════════════════════════════════════════════════════════════════════
 * func_084+: VDP Hardware Initialization
 * Entry: 0x02224084
 * Size: ~200+ bytes
 *
 * Purpose: Initialize VDP registers for 3D rendering mode.
 *          Sets up frame buffer pointers, display parameters,
 *          and rendering modes.
 *
 * VDP Register Writes:
 *   - Many sequential MOV.B R0,@(offset,Rn) to hardware addresses
 *   - Addresses in 0xC0000000 range (VDP register space)
 *   - Values like 0x27, 0x22, 0x30+ for mode settings
 *
 * Pattern:
 *   MOV.L  @(PC),R13              ; Load hardware base
 *   MOV.L  @(PC),R1               ; Load second base
 *   MOV.B  R0,@(2,R4)             ; Status register
 *   SHLL2  R0                     ; Calculate offset
 *   MOV.L  R0,@R13                ; Write to hardware
 *   E0 xx  MOV #xx,R0             ; Load value
 *   80 Dn  MOV.B R0,@(n,R0)       ; Write to register
 *   ... (many similar patterns)
 * ═══════════════════════════════════════════════════════════════════════════ */
func_084_vdp_init:
    mov.l   @(.hw_base_1,pc),r13    /* R13 = 0xC0000100? */
    mov.l   @(.hw_base_2,pc),r1     /* R1 = second hardware base */
    mov.b   r0,@(2,r4)              /* Status register */
    shll2   r0                      /* Scale offset */
    /* Unknown opcode $001E */
    mov.l   r0,@r13                 /* Write to hardware */

    mov     #0,r0
    mov.b   r0,@(2,r1)              /* Clear register */
    mov.b   r0,@(8,r5)
    mov.b   r0,@(3,r1)
    mov.b   r0,@(9,r5)
    mov.b   r0,@(4,r1)

    /* Initialize display mode registers */
    mov     #0,r0
    mov.b   r0,@(10,r0)             /* Mode A */
    mov.b   r0,@(10,r4)
    add     #0x30,r0
    mov.b   r0,@(11,r0)
    mov     #0x27,r0
    mov.b   r0,@(12,r0)
    mov.b   r0,@(11,r4)
    /* ... continues with more register initialization ... */

.align 2
.hw_base_1:
    .long   0xC0000100              /* VDP register base 1 */
.hw_base_2:
    .long   0xC0000200              /* VDP register base 2 */

/* ═══════════════════════════════════════════════════════════════════════════
 * func_097+: Data Unpacking Functions
 *
 * Entry: ~0x02224000
 *
 * These functions decompress model and texture data:
 * - Nested loops (outer R7, inner R2)
 * - 8 bytes per inner iteration
 * - Copies to destination buffer
 * ═══════════════════════════════════════════════════════════════════════════ */

/*
 * Analysis Notes:
 *
 * The func_067+ region contains specialized rendering utilities:
 *
 * 1. RLE Decompression (func_067-070):
 *    - Used for texture and tile data
 *    - Multiple variants for different mirroring modes
 *    - Efficient byte-level unpacking
 *
 * 2. VDP Hardware Init (func_084+):
 *    - Direct hardware register access at 0xC0000xxx
 *    - Sets up display modes, buffer pointers, timing
 *    - Called during frame setup
 *
 * 3. Data Unpacking (func_097+):
 *    - Model vertex and polygon data
 *    - Nested loop structure for 2D arrays
 *    - Copies to SDRAM work buffers
 *
 * Register Conventions:
 *    R4  = VDP status pointer
 *    R5  = Flags/status structure
 *    R13 = Hardware base address
 *    R14 = Context structure pointer
 *
 * The 0xC0000xxx addresses are VDP registers:
 *    0xC0000000-0x0FF: Control registers
 *    0xC0000100-0x1FF: Palette/mode registers
 *    0xC0000700-0x7FF: Display list buffers
 *
 * These functions complete the 3D rendering pipeline from
 * geometry processing (func_001-066) through rasterization
 * to final VDP output.
 *
 * End of VDP/hardware functions
 */
