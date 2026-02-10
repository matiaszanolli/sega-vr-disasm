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
        move.w  #$0004,VINT_STATE.w             ; $004998: $31FC $0004 $C87A - set wait flag
        move    #$2300,sr                       ; $00499E: $46FC $2300 - enable interrupts (level 3)
.spin:
        tst.w   VINT_STATE.w                    ; $0049A2: $4A78 $C87A - check flag
        bne.s   .spin                           ; $0049A6: $66FA - wait until V-INT clears it
        rts                                     ; $0049A8: $4E75
