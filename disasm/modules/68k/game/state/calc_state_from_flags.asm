; ============================================================================
; Calculate State from Flags
; ROM Range: $0034D2-$0034E6 (22 bytes)
; ============================================================================
; Calculates game state from bits 0-1 of flag byte at $C8AB.
; Maps: 0->$0C, 1->$10, 2->$14, 3->$18.
;
; Entry: none
; Uses: D0
; ============================================================================

calc_state_from_flags:
        move.b  ($FFFFC8AB).w,d0        ; $1038 $C8AB
        andi.b  #$03,d0               ; Mask to 2 bits
        add.b   d0,d0                 ; x2
        add.b   d0,d0                 ; x4
        addi.b  #$0C,d0               ; Add base offset
        move.b  d0,($FFFFC305).w        ; $11C0 $C305
        rts
