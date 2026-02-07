; ============================================================================
; Joypad Read Port (Generic Protocol)
; ROM Range: $001992-$0019E8 (88 bytes)
; ============================================================================
; Generic joypad port reader with configurable I/O protocol.
; Uses a 6-byte protocol table and a port address lookup table
; (both located after the RTS in the section data area).
; Reads 8 button bits via TH-toggle sequences.
;
; Entry: D0 = port index (0-2)
; Exit: D0 = 8-bit button data
; Uses: D0, D1, D2, A0, A1 (D1/D2/A1 saved/restored)
; Hardware: $A11100 (Z80 bus), I/O ports
; ============================================================================

joypad_read_port:
        move.w  #$0100,$00A11100        ; Request Z80 bus
.wait_bus:
        btst    #0,$00A11100            ; Check bus grant
        bne.s   .wait_bus               ; Wait until granted
        movem.l d1/d2/a1,-(a7)          ; Save registers
        add.w   d0,d0                   ; D0 *= 2
        add.w   d0,d0                   ; D0 *= 4 (longword index)
        dc.w    $41FA,$0044             ; LEA port_table(PC),A0
        movea.l 0(a0,d0.w),a0           ; Load port base address
        dc.w    $43FA,$0034             ; LEA protocol_table(PC),A1
        move.b  (a1),$0006(a0)          ; Write control byte to port+6
        moveq   #0,d0                   ; Clear result
        moveq   #8,d1                   ; 8 bits to read
; --- Bit read loop ---
.read_loop:
        move.b  (a1)+,(a0)              ; Write protocol byte to port
        nop                             ; Timing delays
        nop
        nop
        nop
        move.b  (a0),d2                 ; Read port data
        and.b   (a1)+,d2                ; Mask with protocol byte
        beq.w   .bit_clear              ; If masked bit clear, skip
        or.b    d1,d0                   ; Set bit in result
.bit_clear:
        lsr.b   #1,d1                   ; Shift bit position right
        bne.s   .read_loop              ; Loop until all 8 bits read
; --- Cleanup ---
        clr.b   $0006(a0)               ; Clear port control register
        movem.l (a7)+,d1/d2/a1          ; Restore registers
        move.w  #$0000,$00A11100        ; Release Z80 bus
        rts
