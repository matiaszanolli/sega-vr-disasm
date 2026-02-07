; ============================================================================
; MARS Communication Write
; ROM Range: $002890-$0028C0 (50 bytes)
; ============================================================================
; Writes a command to SH2 via communication registers (COMM0/COMM1).
; Implements spin-wait handshake protocol for 68K->SH2 command dispatch.
;
; Entry: Command bytes in $C8A8/$C8A9
; Uses: none (only modifies MARS registers and RAM)
; ============================================================================

mars_comm_write:
.wait_handshake:
        btst    #0,$00A15123          ; Check SH2 handshake flag
        beq.s   .wait_handshake       ; Spin until set
        bclr    #0,$00A15123          ; Clear handshake
        dc.w    $31FC,$0000,$C8A8     ; MOVE.W #$0000,($C8A8).W
        dc.w    $13F8,$C8A9,$00A1,$5121  ; MOVE.B ($C8A9).W,$00A15121
        dc.w    $13F8,$C8A8,$00A1,$5120  ; MOVE.B ($C8A8).W,$00A15120
        move.b  #$00,$00A15123        ; Clear handshake register
        rts
