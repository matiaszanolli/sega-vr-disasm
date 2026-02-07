; ============================================================================
; Counter Decrement Flag Set
; ROM Range: $002200-$00220A (12 bytes)
; ============================================================================
; Increments a byte counter at $C828 and sets bit 1 of flag byte at $C80B.
;
; Entry: none
; Uses: none (only modifies memory)
; ============================================================================

counter_decrement_flag_set:
        dc.w    $5238,$C828           ; ADDQ.B #1,($C828).W
        dc.w    $08F8,$0001,$C80B     ; BSET #1,($C80B).W
        rts
