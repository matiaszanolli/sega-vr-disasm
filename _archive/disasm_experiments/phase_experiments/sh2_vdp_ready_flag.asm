; ═══════════════════════════════════════════════════════════════════════════
; VDP Ready Flag - Phase 4.4a Implementation
; ═══════════════════════════════════════════════════════════════════════════
; Purpose: Shared memory location for VDP readiness status
; Used by: H-INT handler (sets), Rendering functions (reads)
; Memory: SDRAM at 0x22000560 (GBR-relative @ offset 0x60)
; ═══════════════════════════════════════════════════════════════════════════

; System register base (GBR is set to 0x22000500 during init)
GBR_BASE                = 0x22000500

; VDP Ready Flag offset (relative to GBR)
; Flag: 0x00 = VDP not ready, 0xFF = VDP ready
VDP_READY_FLAG_OFFSET   = 0x60
VDP_READY_FLAG_ADDR     = GBR_BASE + VDP_READY_FLAG_OFFSET  ; 0x22000560

; VDP Status Values
VDP_STATUS_NOT_READY    = 0x00
VDP_STATUS_READY        = 0xFF

; VDP Hardware Addresses (cache-through)
VDP_STATUS_ADDR         = 0x24000008  ; VDP status register

; H-INT Interval Configuration
H_INT_INTERVAL_LINES    = 8           ; Fire H-INT every 8 scanlines

; ═══════════════════════════════════════════════════════════════════════════
; Initialization Macro - Call from startup code
; ═══════════════════════════════════════════════════════════════════════════
; Usage: INIT_VDP_READY_FLAG
; Clobbers: R0, R1
; ═══════════════════════════════════════════════════════════════════════════

.macro INIT_VDP_READY_FLAG
    ; Initialize VDP ready flag to 0xFF (ready)
    mov.l   #VDP_READY_FLAG_ADDR, r0
    mov     #0xFF, r1
    mov.b   r1, @r0
.endm

; ═══════════════════════════════════════════════════════════════════════════
; Check VDP Ready Macro - Used in rendering functions
; ═══════════════════════════════════════════════════════════════════════════
; Usage: CHECK_VDP_READY r0  (checks status in r0, sets T bit)
; Input: GBR must be initialized to 0x22000500
; Output: r0 = VDP ready status (0xFF if ready, 0x00 if not ready)
;         T bit set if ZERO (not ready), clear if NON-ZERO (ready)
; ═══════════════════════════════════════════════════════════════════════════

.macro CHECK_VDP_READY dst_reg
    mov.l   @(VDP_READY_FLAG_OFFSET, gbr), \dst_reg
    cmp     #0xFF, \dst_reg
    bf      $+0  ; T bit = 1 if NOT ready (cmp failed), 0 if ready
.endm

; ═══════════════════════════════════════════════════════════════════════════
; Wait for VDP Ready - Inline polling using flag
; ═══════════════════════════════════════════════════════════════════════════
; Usage: WAIT_VDP_READY
; Clobbers: R0
; Notes: Spins until flag is 0xFF (ready)
;        Alternative: Use with H-INT for better latency
; ═══════════════════════════════════════════════════════════════════════════

.macro WAIT_VDP_READY
.wait_loop:
    mov.l   @(VDP_READY_FLAG_OFFSET, gbr), r0
    cmp     #0xFF, r0
    bf      .wait_loop  ; Loop until flag is 0xFF
.endm

; Alternative: Wait with H-INT (uses smaller loop)
.macro WAIT_VDP_READY_HINTED
.wait_loop:
    mov.l   @(VDP_READY_FLAG_OFFSET, gbr), r0
    tst     r0, r0
    bf      .wait_loop  ; Loop until flag is non-zero
.endm
