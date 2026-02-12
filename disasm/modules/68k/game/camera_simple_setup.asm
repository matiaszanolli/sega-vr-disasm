; ============================================================================
; Camera Simple Setup
; ROM Range: $008BF2-$008C16 (36 bytes)
; ============================================================================
;
; PURPOSE
; -------
; Simple camera setup from the $C0C0 parameter buffer. Reads pitch from
; buffer[0], copies to viewport/working. Copies buffer[1] to param B
; ($C0B0). Reads yaw from buffer[2], copies to viewport/working.
;
; MEMORY VARIABLES
; ----------------
;   $FFFFC0BA  Camera override flag (word, cleared to 0)
;   $FFFFC0C0  Camera parameter buffer (3 words: pitch, param B, yaw)
;   $FFFFC054  Viewport pitch (word, from buffer[0])
;   $FFFFC892  Working pitch (word, from buffer[0])
;   $FFFFC0B0  Camera param B (word, from buffer[1])
;   $FFFFC056  Viewport yaw (word, from buffer[2])
;   $FFFFC894  Working yaw (word, from buffer[2])
;
; Entry: No register inputs
; Exit:  Camera configured from buffer
; Uses:  D0, A1
; ============================================================================

camera_simple_setup:
        move.w  #$0000,($FFFFC0BA).w           ; $008BF2: $31FC $0000 $C0BA — clear override flag
        lea     ($FFFFC0C0).w,a1                ; $008BF8: $43F8 $C0C0 — point to parameter buffer
        move.w  (a1)+,d0                        ; $008BFC: $3019 — read buffer[0] = pitch
        move.w  d0,($FFFFC054).w                ; $008BFE: $31C0 $C054 — write viewport pitch
        move.w  d0,($FFFFC892).w                ; $008C02: $31C0 $C892 — write working pitch
        move.w  (a1)+,($FFFFC0B0).w             ; $008C06: $31D9 $C0B0 — buffer[1] → param B
        move.w  (a1),d0                         ; $008C0A: $3011 — read buffer[2] = yaw
        move.w  d0,($FFFFC056).w                ; $008C0C: $31C0 $C056 — write viewport yaw
        move.w  d0,($FFFFC894).w                ; $008C10: $31C0 $C894 — write working yaw
        rts                                     ; $008C14: $4E75
