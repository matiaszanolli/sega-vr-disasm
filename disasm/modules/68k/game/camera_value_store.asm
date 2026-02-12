; ============================================================================
; Camera Value Store
; ROM Range: $008D52-$008D62 (16 bytes)
; ============================================================================
;
; PURPOSE
; -------
; Copies the working yaw value ($C894) to both the viewport backup
; register ($C0BE) and the shared memory location ($00FF3028) for
; SH2 access.
;
; MEMORY VARIABLES
; ----------------
;   $FFFFC894  Working yaw (word, read)
;   $FFFFC0BE  Viewport yaw backup (word, written)
;   $00FF3028  Shared memory yaw (word, written for SH2)
;
; Entry: No register inputs
; Exit:  Yaw value copied to viewport and shared memory
; Uses:  (none modified beyond RAM writes)
; ============================================================================

camera_value_store:
        move.w  ($FFFFC894).w,($FFFFC0BE).w     ; $008D52: $31F8 $C894 $C0BE — copy to viewport backup
        move.w  ($FFFFC894).w,($00FF3028).l      ; $008D58: $33F8 $C894 $00FF $3028 — copy to shared memory
        rts                                      ; $008D60: $4E75
