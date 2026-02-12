; ============================================================================
; Conditional State Set + Enable Flags + SH2 Call (with ST)
; ROM Range: $0137C0-$0137F4 (52 bytes)
; ============================================================================
; Tests D2. If zero, returns. Otherwise sets state variable ($C8A4)
; to $A8, sets $A018 to $FF (ST), enables SH2 flag ($C809),
; display mode ($C80A), command flag ($C802), sets sync bit 7
; ($C80E), calls SH2 routine, and sets $A028 to $0002.
;
; Memory:
;   $FFFFC8A4 = state variable (byte, set to $A8)
;   $FFFFA018 = P1 data (byte, set to $FF via ST)
;   $FFFFC809 = SH2 enable flag (byte, set to $01)
;   $FFFFC80A = display mode flag (byte, set to $01)
;   $FFFFC80E = sync/transition flags (byte, bit 7 set)
;   $FFFFC802 = command flag (byte, set to $01)
;   $FFFFA028 = player data (word, set to $0002)
; Entry: D2 = condition value | Exit: flags set or no-op | Uses: D2
; ============================================================================

fn_12200_033:
        tst.w   d2                              ; $0137C0: $4A42 — test condition
        beq.s   .done                           ; $0137C2: $672E — zero → skip
        move.b  #$A8,($FFFFC8A4).w              ; $0137C4: $11FC $00A8 $C8A4 — state = $A8
        st      ($FFFFA018).w                   ; $0137CA: $50F8 $A018 — set P1 data = $FF
        move.b  #$01,($FFFFC809).w              ; $0137CE: $11FC $0001 $C809 — enable SH2 flag
        move.b  #$01,($FFFFC80A).w              ; $0137D4: $11FC $0001 $C80A — enable display mode
        bset    #7,($FFFFC80E).w                ; $0137DA: $08F8 $0007 $C80E — set sync bit 7
        move.b  #$01,($FFFFC802).w              ; $0137E0: $11FC $0001 $C802 — enable command flag
        jsr     $0088205E                       ; $0137E6: $4EB9 $0088 $205E — call SH2 routine
        move.w  #$0002,($FFFFA028).w            ; $0137EC: $31FC $0002 $A028 — set player data
.done:
        rts                                     ; $0137F2: $4E75

