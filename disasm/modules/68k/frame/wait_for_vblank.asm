; ============================================================================
; Wait For V-Blank
; ROM Range: $004998-$0049AA (18 bytes)
; ============================================================================
; Waits for V-blank by setting flag and spinning until V-INT clears it.
; Lowers interrupt priority to level 3 to allow V-INT.
;
; Entry: none
; Uses: SR (temporarily set to $2300)
; ============================================================================

wait_for_vblank:
        dc.w    $31FC,$0004,$C87A     ; MOVE.W #$0004,($C87A).W - set wait flag
        dc.w    $46FC,$2300           ; MOVE #$2300,SR - enable interrupts
.spin:
        dc.w    $4A78,$C87A           ; TST.W ($C87A).W
        bne.s   .spin                 ; Wait until V-INT clears flag
        rts
