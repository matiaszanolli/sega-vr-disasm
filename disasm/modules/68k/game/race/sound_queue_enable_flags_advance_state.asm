; ============================================================================
; Sound Queue + Enable Flags + Advance State
; ROM Range: $005822-$00584A (40 bytes)
; ============================================================================
; Calls the sound queue sub at $002474, enables SH2 flag ($C809),
; display mode flag ($C80A), sets sync bit 7 ($C80E), enables
; command flag ($C802), sets comm signal ($C822) to $F3, and
; advances the sub-sequence timer ($C8C5) by 4.
;
; Memory:
;   $FFFFC809 = SH2 enable flag (byte, set to $01)
;   $FFFFC80A = display mode flag (byte, set to $01)
;   $FFFFC80E = sync/transition flags (byte, bit 7 set)
;   $FFFFC802 = command flag (byte, set to $01)
;   $FFFFC822 = comm signal (byte, set to $F3)
;   $FFFFC8C5 = sub-sequence timer (byte, advanced by 4)
; Entry: none | Exit: flags set, state advanced | Uses: none
; ============================================================================

sound_queue_enable_flags_advance_state:
        dc.w    $4EBA,$CC50                     ; BSR.W $002474 ; $005822: — call sound queue sub
        move.b  #$01,($FFFFC809).w              ; $005826: $11FC $0001 $C809 — enable SH2 flag
        move.b  #$01,($FFFFC80A).w              ; $00582C: $11FC $0001 $C80A — enable display mode
        bset    #7,($FFFFC80E).w                ; $005832: $08F8 $0007 $C80E — set sync bit 7
        move.b  #$01,($FFFFC802).w              ; $005838: $11FC $0001 $C802 — enable command flag
        move.b  #$F3,($FFFFC822).w              ; $00583E: $11FC $00F3 $C822 — comm signal = $F3
        addq.b  #4,($FFFFC8C5).w                ; $005844: $5838 $C8C5 — advance sub-sequence timer
        rts                                     ; $005848: $4E75

