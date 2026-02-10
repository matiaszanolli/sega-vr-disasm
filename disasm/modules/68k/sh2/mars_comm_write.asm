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
        btst    #0,COMM1_LO            ; Check SH2 handshake flag
        beq.s   .wait_handshake         ; Spin until set
        bclr    #0,COMM1_LO            ; Clear handshake
        move.w  #$0000,($FFFFC8A8).w   ; Clear command staging
        move.b  ($FFFFC8A9).w,COMM0_LO ; Write command code to COMM0 low
        move.b  ($FFFFC8A8).w,COMM0_HI ; Write command flag to COMM0 high
        move.b  #$00,COMM1_LO          ; Clear handshake register
        rts
