; ============================================================================
; Abort With Flag
; ROM Range: $00BD9E-$00BDA6 (8 bytes)
; ============================================================================
; Pops the caller's return address from stack (ADDQ #4,SP), sets
; flag ($C308).W = 1, then returns to grandparent caller.
; Effect: caller is skipped, flag is set.
;
; Uses: (modifies SP)
; RAM:
;   ($C308).W: Flag byte (set to 1)
; ============================================================================

abort_with_flag:
        addq.w  #4,sp                   ; Pop caller's return address
        move.b  #$01,($FFFFC308).w      ; $11FC $0001 $C308 — set flag
        rts
