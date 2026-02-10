; ═══════════════════════════════════════════════════════════════════════════
; H-INT Handler - Phase 4.4a Implementation
; ═══════════════════════════════════════════════════════════════════════════
; Purpose: Interrupt handler for H-INT (Horizontal Blank)
; Function: Reads VDP status and stores in ready flag for rendering functions
; Frequency: Fires every N scanlines (configured via H Count register)
; ═══════════════════════════════════════════════════════════════════════════

; Includes
.include "sh2_vdp_ready_flag.asm"

; ═══════════════════════════════════════════════════════════════════════════
; h_int_handler: H-INT Interrupt Handler
; ═══════════════════════════════════════════════════════════════════════════
; Interrupt Level: 11-12 (H-INT)
; Entry: Automatically called by 32X hardware on H-INT
; Exit: RTE returns to interrupted code
;
; Execution Flow:
;   1. Save R0 and R1 (pushed automatically by processor)
;   2. Read VDP status register
;   3. Store status in ready flag (GBR-relative)
;   4. Clear H-INT interrupt request
;   5. Restore registers and return
;
; Timing: ~20-30 cycles total (minimal overhead)
; ═══════════════════════════════════════════════════════════════════════════

.align 4

h_int_handler:
    ; Note: R0 and R1 automatically pushed by hardware before this handler runs
    ; SR (status register) already set to interrupt level 11/12

    ; Read VDP status register
    mov.l   #VDP_STATUS_ADDR, r0       ; R0 = 0x24000008 (VDP status address)
    mov.b   @r0, r0                     ; R0 = VDP status byte

    ; Store in ready flag (GBR-relative addressing)
    mov.b   r0, @(VDP_READY_FLAG_OFFSET, gbr)  ; [GBR+0x60] = VDP status

    ; Clear H-INT interrupt (must do this before returning)
    ; Writing any value to H-INT Clear register clears the interrupt
    mov.w   #0, @(0x20004018)           ; Clear H-INT at 0x20004018

    ; Return from interrupt
    ; R0 and R1 automatically restored by RTE
    rte
    nop                                  ; [DS] Delay slot (required)

; ═══════════════════════════════════════════════════════════════════════════
; init_h_int: Initialize H-INT Configuration
; ═══════════════════════════════════════════════════════════════════════════
; Purpose: Set up H-INT to fire at regular scanline intervals
; Call: From main startup code (before rendering begins)
; Clobbers: R0, R1, R2
;
; Configuration:
;   - H Count: Every 8 scanlines (configurable)
;   - HEN bit: Enable H-INT during V-blank
;   - H mask bit: Enable H-INT in interrupt mask
; ═══════════════════════════════════════════════════════════════════════════

.align 4

init_h_int:
    push.l  r15                         ; Save return address

    ; Step 1: Initialize GBR to system register base
    mov.l   #GBR_BASE, r0
    ldc     r0, gbr                     ; Set GBR = 0x22000500

    ; Step 2: Initialize VDP ready flag
    INIT_VDP_READY_FLAG

    ; Step 3: Set H Count register (every 8 scanlines)
    mov.l   #0x20004004, r0             ; H Count register address
    mov.w   #H_INT_INTERVAL_LINES, r1   ; Interval = 8 lines
    mov.w   r1, @r0                     ; Write to H Count register

    ; Step 4: Enable HEN bit (H-INT valid during V-blank)
    mov.l   #0x20004000, r0             ; Interrupt mask register address
    mov.w   @r0, r1                     ; Read current value
    or      #0x0080, r1                 ; Set HEN bit (bit 7)
    mov.w   r1, @r0                     ; Write back

    ; Step 5: Enable H-INT in interrupt mask
    mov.l   #0x20004000, r0
    mov.w   @r0, r1                     ; Read current value
    or      #0x0004, r1                 ; Set H bit (bit 2) = enable H-INT
    mov.w   r1, @r0                     ; Write back

    ; Step 6: Enable SH2 interrupts (SR bit)
    mov     #0x20, r0                   ; SR mask: enable interrupts level 0x20
    ldc     r0, sr                      ; Set SR to enable interrupts

    ; Return
    pop.l   r15                         ; Restore return address
    rts
    nop                                  ; [DS] Delay slot

; ═══════════════════════════════════════════════════════════════════════════
; Interrupt Vector Table Entry
; ═══════════════════════════════════════════════════════════════════════════
; Location: 0x00000000 (interrupt vector base)
; Entry point for H-INT: Vector offset 0x2C (level 11)
;
; Note: Must be included in main vector table during ROM assembly
; Example:
;   .org 0x2C
;   .long h_int_handler
; ═══════════════════════════════════════════════════════════════════════════
