; ============================================================================
; Camera Direct Setup
; ROM Range: $008B9C-$008BC2 (38 bytes)
; ============================================================================
;
; PURPOSE
; -------
; Direct camera parameter setup from stored configuration values. Clears
; the camera override flag, sets elevation to $0080, then copies pitch
; and yaw from configuration RAM to both viewport and working registers.
;
; MEMORY VARIABLES
; ----------------
;   $FFFFC0BA  Camera override flag (word, cleared to 0)
;   $FFFFC0B0  Camera elevation (word, set to $0080)
;   $FFFFC8DC  Pitch input config (word, read)
;   $FFFFC8DE  Yaw input config (word, read)
;   $FFFFC054  Viewport pitch (word, written)
;   $FFFFC892  Working pitch (word, written)
;   $FFFFC056  Viewport yaw (word, written)
;   $FFFFC894  Working yaw (word, written)
;
; Entry: No register inputs
; Exit:  Camera parameters configured from stored values
; Uses:  D0
; ============================================================================

camera_direct_setup:
        move.w  #$0000,($FFFFC0BA).w           ; $008B9C: $31FC $0000 $C0BA — clear override flag
        move.w  #$0080,($FFFFC0B0).w           ; $008BA2: $31FC $0080 $C0B0 — set elevation
        move.w  ($FFFFC8DC).w,d0                ; $008BA8: $3038 $C8DC — load pitch config
        move.w  d0,($FFFFC054).w                ; $008BAC: $31C0 $C054 — write viewport pitch
        move.w  d0,($FFFFC892).w                ; $008BB0: $31C0 $C892 — write working pitch
        move.w  ($FFFFC8DE).w,d0                ; $008BB4: $3038 $C8DE — load yaw config
        move.w  d0,($FFFFC056).w                ; $008BB8: $31C0 $C056 — write viewport yaw
        move.w  d0,($FFFFC894).w                ; $008BBC: $31C0 $C894 — write working yaw
        rts                                     ; $008BC0: $4E75
