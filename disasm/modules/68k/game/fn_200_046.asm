; ============================================================================
; Sound State Init + Clear Comm Variables
; ROM Range: $002066-$00207E (24 bytes)
; ============================================================================
; Initializes sound driver configuration ($8506 = $03 tempo,
; $8504 = $30 volume/mode), then clears comm ready flag ($C822)
; and state variable ($C8A4) to zero.
;
; Memory:
;   $FFFF8506 = sound driver tempo (byte, set to $03)
;   $FFFF8504 = sound driver volume/mode (byte, set to $30)
;   $FFFFC822 = comm/input ready flag (byte, cleared)
;   $FFFFC8A4 = state variable (long, cleared)
; Entry: none | Exit: sound + comm initialized | Uses: D0
; ============================================================================

fn_200_046:
        move.b  #$03,($FFFF8506).w             ; $002066: $11FC $0003 $8506 — sound tempo
        move.b  #$30,($FFFF8504).w             ; $00206C: $11FC $0030 $8504 — sound volume/mode
        moveq   #$00,d0                         ; $002072: $7000 — zero
        move.b  d0,($FFFFC822).w               ; $002074: $11C0 $C822 — clear comm ready flag
        move.l  d0,($FFFFC8A4).w               ; $002078: $21C0 $C8A4 — clear state (long)
        rts                                     ; $00207C: $4E75
