; ============================================================================
; Counter Increment and Flag Set
; ROM Range: $002200-$00220A (12 bytes)
; ============================================================================
;
; PURPOSE
; -------
; Increments a byte counter at $C828 and sets bit 1 of the control flag
; byte at $C80B. Used to signal a state change after counter update.
;
; MEMORY VARIABLES
; ----------------
;   $FFFFC828  Byte counter (incremented by 1)
;   $FFFFC80B  Control flags (bit 1 set)
;
; Entry: No register inputs
; Exit:  Counter incremented, flag bit set
; Uses:  (none modified beyond RAM writes)
; ============================================================================

counter_decrement_flag_set:
        addq.b  #1,($FFFFC828).w               ; $002200: $5238 $C828 — increment counter
        bset    #1,($FFFFC80B).w                ; $002204: $08F8 $0001 $C80B — set control flag bit 1
        rts                                     ; $00220A: $4E75
