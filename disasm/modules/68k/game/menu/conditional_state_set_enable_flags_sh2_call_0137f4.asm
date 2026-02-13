; ============================================================================
; Conditional State Set + Enable Flags + SH2 Call
; ROM Range: $0137F4-$013824 (48 bytes)
; ============================================================================
; Tests D2. If zero, returns. Otherwise sets state variable ($C8A4)
; to $A8, enables SH2 flag ($C809), display mode ($C80A), command
; flag ($C802), sets sync bit 7 ($C80E), calls SH2 routine
; $0088205E, and sets $A028 to $0002.
;
; Memory:
;   $FFFFC8A4 = state variable (byte, set to $A8)
;   $FFFFC809 = SH2 enable flag (byte, set to $01)
;   $FFFFC80A = display mode flag (byte, set to $01)
;   $FFFFC80E = sync/transition flags (byte, bit 7 set)
;   $FFFFC802 = command flag (byte, set to $01)
;   $FFFFA028 = player data (word, set to $0002)
; Entry: D2 = condition value | Exit: flags set or no-op | Uses: D2
; ============================================================================

conditional_state_set_enable_flags_sh2_call_0137f4:
        tst.w   d2                              ; $0137F4: $4A42 — test condition
        beq.s   .done                           ; $0137F6: $672A — zero → skip
        move.b  #$A8,($FFFFC8A4).w              ; $0137F8: $11FC $00A8 $C8A4 — state = $A8
        move.b  #$01,($FFFFC809).w              ; $0137FE: $11FC $0001 $C809 — enable SH2 flag
        move.b  #$01,($FFFFC80A).w              ; $013804: $11FC $0001 $C80A — enable display mode
        bset    #7,($FFFFC80E).w                ; $01380A: $08F8 $0007 $C80E — set sync bit 7
        move.b  #$01,($FFFFC802).w              ; $013810: $11FC $0001 $C802 — enable command flag
        jsr     $0088205E                       ; $013816: $4EB9 $0088 $205E — call SH2 routine
        move.w  #$0002,($FFFFA028).w            ; $01381C: $31FC $0002 $A028 — set player data
.done:
        rts                                     ; $013822: $4E75

