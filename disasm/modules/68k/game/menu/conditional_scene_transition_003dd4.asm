; ============================================================================
; Conditional Scene Transition (State $A7)
; ROM Range: $003DD4-$003E08 (52 bytes)
; ============================================================================
; Checks if scene state ($C8AA) exceeds 20. If not, returns.
; Otherwise sends two SH2 commands ($222F29EE to $FF69C8,
; $222F1716 to $FF6998), clears scene state, sets state variable
; ($C8A4) to $A7, sets bit 4 of control flag ($C30E), and
; advances dispatch index ($C8AC) by 4.
;
; Memory:
;   $FFFFC8AA = scene state (word, tested, then cleared)
;   $00FF69C8 = SH2 shared command 1 (long, set to $222F29EE)
;   $00FF6998 = SH2 shared command 2 (long, set to $222F1716)
;   $FFFFC8A4 = state variable (byte, set to $A7)
;   $FFFFC30E = control flag (byte, bit 4 set)
;   $FFFFC8AC = state dispatch index (word, advanced by 4)
; Entry: none | Exit: scene transitioned or no-op | Uses: none
; ============================================================================

conditional_scene_transition_003dd4:
        cmpi.w  #$0014,($FFFFC8AA).w            ; $003DD4: $0C78 $0014 $C8AA — scene state > 20?
        ble.s   .done                           ; $003DDA: $6F2A — no → return
        move.l  #$222F29EE,$00FF69C8            ; $003DDC: $23FC $222F $29EE $00FF $69C8 — SH2 cmd 1
        move.l  #$222F1716,$00FF6998            ; $003DE6: $23FC $222F $1716 $00FF $6998 — SH2 cmd 2
        move.w  #$0000,($FFFFC8AA).w            ; $003DF0: $31FC $0000 $C8AA — clear scene state
        move.b  #$A7,($FFFFC8A4).w              ; $003DF6: $11FC $00A7 $C8A4 — state = $A7
        bset    #4,($FFFFC30E).w                ; $003DFC: $08F8 $0004 $C30E — set control bit 4
        addq.w  #4,($FFFFC8AC).w                ; $003E02: $5878 $C8AC — advance dispatch index
.done:
        rts                                     ; $003E06: $4E75

