; ============================================================================
; Conditional Scene Transition (State $C2)
; ROM Range: $003EA2-$003EC6 (36 bytes)
; ============================================================================
; Checks if scene state ($C8AA) exceeds 20. If not, returns.
; Otherwise sends SH2 command data $222F002C to $FF6988, sets
; state variable ($C8A4) to $C2, clears scene state, and advances
; dispatch index ($C8AC) by 4.
;
; Memory:
;   $FFFFC8AA = scene state (word, tested, then cleared)
;   $00FF6988 = SH2 shared command data (long, set to $222F002C)
;   $FFFFC8A4 = state variable (byte, set to $C2)
;   $FFFFC8AC = state dispatch index (word, advanced by 4)
; Entry: none | Exit: scene transitioned or no-op | Uses: none
; ============================================================================

conditional_scene_transition_003ea2:
        cmpi.w  #$0014,($FFFFC8AA).w            ; $003EA2: $0C78 $0014 $C8AA — scene state > 20?
        ble.s   .done                           ; $003EA8: $6F1A — no → return
        move.l  #$222F002C,$00FF6988            ; $003EAA: $23FC $222F $002C $00FF $6988 — SH2 command
        move.b  #$C2,($FFFFC8A4).w              ; $003EB4: $11FC $00C2 $C8A4 — state = $C2
        move.w  #$0000,($FFFFC8AA).w            ; $003EBA: $31FC $0000 $C8AA — clear scene state
        addq.w  #4,($FFFFC8AC).w                ; $003EC0: $5878 $C8AC — advance dispatch index
.done:
        rts                                     ; $003EC4: $4E75

