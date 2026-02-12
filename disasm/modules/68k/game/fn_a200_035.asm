; ============================================================================
; Reset Scene and Menu State
; ROM Range: $00BCCA-$00BCDA (16 bytes)
; ============================================================================
; Clears the scene state ($C8AA) and menu sub-state ($C084), then
; sets the state variable at $C07A to $001C.
;
; Memory:
;   $FFFFC8AA = scene state (word, cleared)
;   $FFFFC084 = menu sub-state (word, cleared)
;   $FFFFC07A = state parameter (word, set to $001C)
; Entry: none | Exit: states reset | Uses: none
; ============================================================================

fn_a200_035:
        clr.w   ($FFFFC8AA).w                   ; $00BCCA: $4278 $C8AA — clear scene state
        clr.w   ($FFFFC084).w                   ; $00BCCE: $4278 $C084 — clear menu sub-state
        move.w  #$001C,($FFFFC07A).w           ; $00BCD2: $31FC $001C $C07A — set state param
        rts                                     ; $00BCD8: $4E75
