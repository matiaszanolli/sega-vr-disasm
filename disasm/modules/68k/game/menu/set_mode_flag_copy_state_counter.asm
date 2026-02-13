; ============================================================================
; Set Mode Flag and Copy State Counter
; ROM Range: $0146BC-$0146CA (14 bytes)
; ============================================================================
; Sets bit 0 of the mode flag at $C30E, then copies the state value
; from $C096 to the V-INT state variable at $C07A.
;
; Memory:
;   $FFFFC30E = mode flag (bit 0 set)
;   $FFFFC096 = source state value (word)
;   $FFFFC07A = V-INT state counter (word, written)
; Entry: none | Exit: flag set, state copied | Uses: none
; ============================================================================

set_mode_flag_copy_state_counter:
        bset    #0,($FFFFC30E).w                ; $0146BC: $08F8 $0000 $C30E — set mode flag bit 0
        move.w  ($FFFFC096).w,($FFFFC07A).w     ; $0146C2: $31F8 $C096 $C07A — copy state counter
        rts                                     ; $0146C8: $4E75
