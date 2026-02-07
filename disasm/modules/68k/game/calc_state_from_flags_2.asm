; ============================================================================
; Calculate State from Flags (Copy 2)
; ROM Range: $0036C8-$0036DC (22 bytes)
; ============================================================================
; Identical to calc_state_from_flags. Second copy for different code path.
;
; Entry: none
; Uses: D0
; ============================================================================

calc_state_from_flags_2:
        dc.w    $1038,$C8AB           ; MOVE.B ($C8AB).W,D0
        andi.b  #$03,d0               ; Mask to 2 bits
        add.b   d0,d0                 ; x2
        add.b   d0,d0                 ; x4
        addi.b  #$0C,d0               ; Add base offset
        dc.w    $11C0,$C305           ; MOVE.B D0,($C305).W
        rts
