; ============================================================================
; Counter Check Flag — Mode Advance
; ROM Range: $008D06-$008D12 (12 bytes)
; ============================================================================
;
; PURPOSE
; -------
; Decrements a countdown counter at $C8F6. When it reaches zero,
; advances the mode counter at $C896 by 2.
;
; MEMORY VARIABLES
; ----------------
;   $FFFFC8F6  Countdown counter (byte, decremented by 1)
;   $FFFFC896  Mode counter (byte, advanced by 2 when countdown expires)
;
; Entry: No register inputs
; Exit:  Counter decremented; mode advanced if counter reached zero
; Uses:  (none modified beyond RAM writes)
; ============================================================================

counter_check_flag_8200:
        subq.b  #1,($FFFFC8F6).w               ; $008D06: $5338 $C8F6 — decrement countdown
        bne.s   .done                           ; $008D0A: $6604 — still counting
        addq.b  #2,($FFFFC896).w               ; $008D0C: $5438 $C896 — countdown expired: advance mode
.done:
        rts                                     ; $008D10: $4E75
