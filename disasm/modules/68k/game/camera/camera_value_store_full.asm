; ============================================================================
; Camera Value Store Full
; ROM Range: $008D38-$008D52 (26 bytes)
; ============================================================================
;
; PURPOSE
; -------
; Sets the working yaw to a fixed value ($EC0A), copies it to both
; viewport backup and shared memory, then advances the mode counter.
;
; MEMORY VARIABLES
; ----------------
;   $FFFFC894  Working yaw (word, set to $EC0A)
;   $FFFFC0BE  Viewport yaw backup (word, written)
;   $00FF3028  Shared memory yaw (word, written for SH2)
;   $FFFFC896  Mode counter (byte, advanced by 2)
;
; Entry: No register inputs
; Exit:  Yaw set to $EC0A, copied, mode counter advanced
; Uses:  (none modified beyond RAM writes)
; ============================================================================

camera_value_store_full:
        move.w  #$EC0A,($FFFFC894).w            ; $008D38: $31FC $EC0A $C894 — set fixed yaw value
        move.w  ($FFFFC894).w,($FFFFC0BE).w      ; $008D3E: $31F8 $C894 $C0BE — copy to viewport backup
        move.w  ($FFFFC894).w,($00FF3028).l       ; $008D44: $33F8 $C894 $00FF $3028 — copy to shared memory
        addq.b  #2,($FFFFC896).w                 ; $008D4C: $5438 $C896 — advance mode counter
        rts                                      ; $008D50: $4E75
