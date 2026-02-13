; ============================================================================
; Conditional Scene Transition (State $C1)
; ROM Range: $003E7E-$003EA2 (36 bytes)
; ============================================================================
; Checks if scene state ($C8AA) exceeds 20. If not, returns.
; Otherwise sends SH2 command data $222F038A to $FF6988, sets
; state variable ($C8A4) to $C1, clears scene state, and advances
; dispatch index ($C8AC) by 4.
;
; Memory:
;   $FFFFC8AA = scene state (word, tested, then cleared)
;   $00FF6988 = SH2 shared command data (long, set to $222F038A)
;   $FFFFC8A4 = state variable (byte, set to $C1)
;   $FFFFC8AC = state dispatch index (word, advanced by 4)
; Entry: none | Exit: scene transitioned or no-op | Uses: none
; ============================================================================

conditional_scene_transition_003e7e:
        cmpi.w  #$0014,($FFFFC8AA).w            ; $003E7E: $0C78 $0014 $C8AA — scene state > 20?
        ble.s   .done                           ; $003E84: $6F1A — no → return
        move.l  #$222F038A,$00FF6988            ; $003E86: $23FC $222F $038A $00FF $6988 — SH2 command
        move.b  #$C1,($FFFFC8A4).w              ; $003E90: $11FC $00C1 $C8A4 — state = $C1
        move.w  #$0000,($FFFFC8AA).w            ; $003E96: $31FC $0000 $C8AA — clear scene state
        addq.w  #4,($FFFFC8AC).w                ; $003E9C: $5878 $C8AC — advance dispatch index
.done:
        rts                                     ; $003EA0: $4E75

