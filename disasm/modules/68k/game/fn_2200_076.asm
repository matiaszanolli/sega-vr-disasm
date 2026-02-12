; ============================================================================
; Conditional Scene Transition (State $C3)
; ROM Range: $003EC6-$003EF6 (48 bytes)
; ============================================================================
; Checks if scene state ($C8AA) exceeds 20. If not, returns.
; Otherwise sends SH2 command $222EEF3A to $FF6988, sets state
; variable ($C8A4) to $C3, clears scene state, sets bit 4 of
; control flag ($C30E) and $B4EE, and advances dispatch index.
;
; Memory:
;   $FFFFC8AA = scene state (word, tested, then cleared)
;   $00FF6988 = SH2 shared command (long, set to $222EEF3A)
;   $FFFFC8A4 = state variable (byte, set to $C3)
;   $FFFFC30E = control flag (byte, bit 4 set)
;   $FFFFB4EE = secondary flag (byte, bit 4 set)
;   $FFFFC8AC = state dispatch index (word, advanced by 4)
; Entry: none | Exit: scene transitioned or no-op | Uses: none
; ============================================================================

fn_2200_076:
        cmpi.w  #$0014,($FFFFC8AA).w            ; $003EC6: $0C78 $0014 $C8AA — scene state > 20?
        ble.s   .done                           ; $003ECC: $6F26 — no → return
        move.l  #$222EEF3A,$00FF6988            ; $003ECE: $23FC $222E $EF3A $00FF $6988 — SH2 command
        move.b  #$C3,($FFFFC8A4).w              ; $003ED8: $11FC $00C3 $C8A4 — state = $C3
        move.w  #$0000,($FFFFC8AA).w            ; $003EDE: $31FC $0000 $C8AA — clear scene state
        bset    #4,($FFFFC30E).w                ; $003EE4: $08F8 $0004 $C30E — set control bit 4
        bset    #4,($FFFFB4EE).w                ; $003EEA: $08F8 $0004 $B4EE — set secondary flag bit 4
        addq.w  #4,($FFFFC8AC).w                ; $003EF0: $5878 $C8AC — advance dispatch index
.done:
        rts                                     ; $003EF4: $4E75

