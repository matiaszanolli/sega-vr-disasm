; ============================================================================
; Z80 Bus Wait
; ROM Range: $030D1C-$030D4C (50 bytes)
; ============================================================================
; Requests Z80 bus, waits for grant, then checks sound driver status
; at Z80 RAM $A00FFF bit 7. If set (busy), releases bus, waits with
; NOPs, and retries. Returns when sound driver is ready.
;
; Entry: none
; Uses: none (all implicit via hardware registers)
; Hardware: $A11100 (Z80 bus request), $A00FFF (sound driver status)
; ============================================================================

z80_bus_wait:
        move.w  #$0100,Z80_BUSREQ        ; Request Z80 bus
.wait_grant:
        btst    #0,Z80_BUSREQ            ; Check bus grant status
        bne.s   .wait_grant             ; Loop until bus granted
        btst    #7,$00A00FFF            ; Check sound driver busy flag
        beq.s   .done                   ; If not busy, return
        move.w  #$0000,Z80_BUSREQ        ; Release Z80 bus
        nop                             ; Wait for bus release
        nop
        nop
        nop
        nop
        bra.s   z80_bus_wait            ; Retry
.done:
        rts
