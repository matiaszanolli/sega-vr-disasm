; ============================================================================
; Camera Scroll Update
; ROM Range: $008CB0-$008CCC (28 bytes)
; ============================================================================
;
; PURPOSE
; -------
; Increments camera scroll positions (pitch and yaw) by 8 each frame,
; then copies working values to viewport registers. Also copies a
; counter value from $C8F6 to $C0C6.
;
; MEMORY VARIABLES
; ----------------
;   $FFFFC892  Working pitch (word, incremented by 8)
;   $FFFFC894  Working yaw (word, incremented by 8)
;   $FFFFC054  Viewport pitch (word, copied from working)
;   $FFFFC056  Viewport yaw (word, copied from working)
;   $FFFFC8F6  Counter source (word, read)
;   $FFFFC0C6  Counter destination (word, written)
;
; Entry: No register inputs
; Exit:  Scroll positions advanced and synced to viewport
; Uses:  (none modified beyond RAM writes)
; ============================================================================

camera_scroll_update:
        addq.w  #8,($FFFFC892).w               ; $008CB0: $5078 $C892 — advance working pitch
        addq.w  #8,($FFFFC894).w               ; $008CB4: $5078 $C894 — advance working yaw
        move.w  ($FFFFC892).w,($FFFFC054).w     ; $008CB8: $31F8 $C892 $C054 — sync viewport pitch
        move.w  ($FFFFC894).w,($FFFFC056).w     ; $008CBE: $31F8 $C894 $C056 — sync viewport yaw
        move.w  ($FFFFC8F6).w,($FFFFC0C6).w     ; $008CC4: $31F8 $C8F6 $C0C6 — copy counter
        rts                                     ; $008CCA: $4E75
