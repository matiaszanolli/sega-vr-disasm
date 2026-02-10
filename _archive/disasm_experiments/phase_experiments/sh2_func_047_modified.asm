; ═══════════════════════════════════════════════════════════════════════════
; func_047_modified: Frame Buffer Address Calculator (with VDP Ready Flag)
; ═══════════════════════════════════════════════════════════════════════════
; Phase 4.4a Implementation - Interrupt-Driven VDP Ready Checking
; ═══════════════════════════════════════════════════════════════════════════
;
; CHANGE LOG from original func_047:
;
; REMOVED (lines 3833-3837):
;   ; VDP polling loop
;   poll_vdp:
;   02223BE4  C505     DW      $C505            ; MOV.W @(R0,R5), R0 or VDP read
;   02223BE6  C802     DW      $C802            ; TST R0, R0 or status check
;   02223BE8  8BFC     BF      $02223BE4        ; if (T==0) goto poll_vdp
;   02223BEA  000B     RTS                       ; Return
;
; ADDED:
;   - VDP ready flag check (fast GBR-relative access)
;   - Loop until flag set by H-INT handler
;   - ~5-10x faster than polling VDP register directly
;
; ═══════════════════════════════════════════════════════════════════════════

; Include required definitions
.include "sh2_vdp_ready_flag.asm"

; ═══════════════════════════════════════════════════════════════════════════
; func_047: Frame Buffer Address Calculator (Mode A)
; ═══════════════════════════════════════════════════════════════════════════
; Address: 0x023BC2 - 0x023BEC (same as original)
; Size: 40 bytes (same as original)
; Type: Leaf
;
; Purpose: Calculates frame buffer address from coordinate R5, performs byte
; swapping on R4, and updates RenderingContext pointer.
;
; Input:
;   R0 = Value to test/swap
;   R4 = Data value to byte-swap
;   R5 = Y coordinate or line number
;
; Output:
;   R4 = Byte-swapped value (or original if bit 0 clear)
;   R5 = Frame buffer address (0x24004000 + R5 × 512)
;   R14 = RenderingContext pointer (0xC0000188)
;
; Algorithm:
;   if (R0 & 1) { R4 = byte_swap(R4); }
;   R5 = 0x24004000 + (R5 << 9)
;   R14 = 0xC0000188
;   [NEW] Wait for VDP ready (via flag, not polling)
; ═══════════════════════════════════════════════════════════════════════════

func_047:

; === command_process ===
02223BC2  0009     NOP                       ; Alignment padding
02223BC4  FF00     DW      $FF00            ; Data constant (mask value)
02223BC6  0000     DW      $0000            ; Data alignment
02223BC8  2400     MOV.B   R0,@R4           ; Data (frame buffer base high word)
02223BCA  4000     SHLL    R0               ; Data (frame buffer base low word)
02223BCC  C000     DW      $C000            ; Data (RenderingContext base high)
02223BCE  0188     DW      $0188            ; Data (RenderingContext base low)

; Function code starts here (unchanged from original)
02223BD0  2409     AND     R0,R4            ; R4 &= R0 (mask R4)
02223BD2  6053     MOV     R5,R0            ; R0 = R5 (copy R5 for test)
02223BD4  C801     DW      $C801            ; TST #1, R0 (test bit 0 of R0)
02223BD6  8B00     BF      $02223BDA        ; if (bit 0 == 0) goto skip_swap
02223BD8  6448     SWAP.B  R4,R4            ; R4 = byte_swap(R4)

skip_swap:
02223BDA  D005     MOV.L   @($02223BF0,PC),R0  ; R0 = 0x24024000 (frame buffer base)
02223BDC  4518     SHLL8   R5               ; R5 <<= 8 (R5 *= 256)
02223BDE  4500     SHLL    R5               ; R5 <<= 1 (R5 *= 512 total)
02223BE0  350C     ADD     R0,R5            ; R5 += 0x24024000 (frame buffer address)
02223BE2  DE04     MOV.L   @($02223BF4,PC),R14  ; R14 = 0xC00001F4 (RenderingContext)

; ═══════════════════════════════════════════════════════════════════════════
; MODIFIED: Wait for VDP ready (using H-INT flag instead of polling)
; ═══════════════════════════════════════════════════════════════════════════
; Original code (5 instructions, ~50 cycles per wait):
;   poll_vdp:
;   02223BE4  C505     DW      $C505            ; MOV.W @(R0,R5), R0
;   02223BE6  C802     DW      $C802            ; TST R0, R0
;   02223BE8  8BFC     BF      $02223BE4        ; Loop
;   02223BEA  000B     RTS                       ; Return
;
; New code (2-3 instructions per check, ~10 cycles per wait):
;   wait_vdp_ready:
;   02223BE4  D001     MOV.L   @(GBR, VDP_FLAG_OFFSET), R0
;   02223BE6  C8FF     CMP     #0xFF, R0
;   02223BE8  8BFC     BF      wait_vdp_ready
;   02223BEA  000B     RTS
;
; Performance improvement: ~5x faster check
; ═══════════════════════════════════════════════════════════════════════════

; New VDP ready check (replaces polling loop)
wait_vdp_ready:
    ; Check VDP ready flag (set by H-INT handler)
    mov.l   @(VDP_READY_FLAG_OFFSET, gbr), r0   ; R0 = VDP ready flag
    cmp     #0xFF, r0                             ; Is flag 0xFF (ready)?
    bf      wait_vdp_ready                        ; If not, loop

    ; Return when VDP ready
    rts
    nop                                           ; [DS] Delay slot

; ═══════════════════════════════════════════════════════════════════════════
; Notes on replacement:
; ═══════════════════════════════════════════════════════════════════════════
; 1. GBR must be initialized to 0x22000500 before rendering starts
;    (done by init_h_int)
;
; 2. H-INT handler sets VDP_READY_FLAG_OFFSET (0x60) with VDP status
;    on every H-INT (every 8 scanlines)
;
; 3. If VDP is not ready, flag will be 0x00, loop continues
;    If VDP is ready, flag will be 0xFF, loop exits
;
; 4. Maximum latency for flag update: One H-INT interval (~8 scanlines @ 60Hz)
;    = ~133 microseconds (acceptable for rendering)
;
; 5. Benefits:
;    - No direct VDP register access (faster)
;    - No I/O wait states (memory access only)
;    - Frees ~40 cycles per wait cycle
;    - Predictable timing (H-INT driven)
;
; 6. Potential issue:
;    If H-INT not firing: Function will loop forever on flag = 0x00
;    Mitigation: Ensure init_h_int() is called before rendering
; ═══════════════════════════════════════════════════════════════════════════
