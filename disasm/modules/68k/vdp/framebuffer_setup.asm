; ============================================================================
; Frame Buffer Setup
; ROM Range: $007270-$00727E (16 bytes)
; ============================================================================
; Loads frame buffer base address into A2, calls a setup subroutine,
; then stores D4 to a frame buffer control register.
;
; Entry: D4 = value to store
; Uses: A2
; Calls: Subroutine at $7280 (via BSR.S)
; ============================================================================

framebuffer_setup:
        lea     $FF6064,a2              ; A2 = frame buffer base address
        bsr.s   *+10                    ; Call setup subroutine at $7280
        move.w  d4,$FF633E              ; Store D4 to frame buffer control
        rts
