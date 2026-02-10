; ============================================================================
; Sound PSG Write
; ROM Range: $0314DC-$0314F4 (26 bytes)
; ============================================================================
; Sets A5+$01 to $E0 (PSG latch byte), reads stream byte to A5+$25,
; then if bit 2 of (A5) is clear, writes the byte to PSG port $C00011.
;
; Entry: A4 = data stream, A5 = channel state
; Uses: none
; Fields modified: A5+$01, A5+$25
; Hardware: $C00011 (PSG data port)
; ============================================================================

sound_psg_write:
        move.b  #$E0,$0001(a5)          ; Set latch byte to $E0
        move.b  (a4)+,$0025(a5)         ; Read stream byte to volume field
        btst    #2,(a5)                 ; Test mute bit
        bne.s   .return                 ; If muted, skip PSG write
        move.b  -$0001(a4),PSG    ; Write volume to PSG port
.return:
        rts
