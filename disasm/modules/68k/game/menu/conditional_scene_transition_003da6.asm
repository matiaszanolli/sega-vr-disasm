; ============================================================================
; Conditional Scene Transition (State $A6)
; ROM Range: $003DA6-$003DD4 (46 bytes)
; ============================================================================
; Checks if scene state ($C8AA) exceeds 20. If not, returns.
; Otherwise sets up SH2 object at $FF69C0 (command $09 at +$00,
; data $222F1D4A at +$08), clears scene state, sets state
; variable ($C8A4) to $A6, and advances dispatch index.
;
; Memory:
;   $FFFFC8AA = scene state (word, tested, then cleared)
;   $00FF69C0 = SH2 object (byte +$00 set to $09, long +$08 set)
;   $FFFFC8A4 = state variable (byte, set to $A6)
;   $FFFFC8AC = state dispatch index (word, advanced by 4)
; Entry: none | Exit: scene transitioned or no-op | Uses: A1, A6
; ============================================================================

conditional_scene_transition_003da6:
        cmpi.w  #$0014,($FFFFC8AA).w            ; $003DA6: $0C78 $0014 $C8AA — scene state > 20?
        ble.s   .done                           ; $003DAC: $6F24 — no → return
        lea     $00FF69C0,a1                    ; $003DAE: $43F9 $00FF $69C0 — SH2 object base
        move.b  #$09,$0000(a1)                  ; $003DB4: $137C $0009 $0000 — command $09
        move.l  #$222F1D4A,$0008(a1)            ; $003DBA: $2B7C $222F $1D4A $0008 — data at +$08
        move.w  #$0000,($FFFFC8AA).w            ; $003DC2: $31FC $0000 $C8AA — clear scene state
        move.b  #$A6,($FFFFC8A4).w              ; $003DC8: $11FC $00A6 $C8A4 — state = $A6
        addq.w  #4,($FFFFC8AC).w                ; $003DCE: $5878 $C8AC — advance dispatch index
.done:
        rts                                     ; $003DD2: $4E75

