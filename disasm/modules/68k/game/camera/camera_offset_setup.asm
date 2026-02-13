; ============================================================================
; Camera Offset Setup
; ROM Range: $008C16-$008C40 (42 bytes)
; ============================================================================
;
; PURPOSE
; -------
; Camera setup with elevation offset from $C0BC. Reads pitch from
; buffer[0], copies buffer[1] to param A ($C0AE), loads elevation
; from $C0BC into param B ($C0B0), and reads yaw from buffer[2].
;
; MEMORY VARIABLES
; ----------------
;   $FFFFC0BA  Camera override flag (word, cleared to 0)
;   $FFFFC0C0  Camera parameter buffer (3 words: pitch, param A, yaw)
;   $FFFFC054  Viewport pitch (word, from buffer[0])
;   $FFFFC892  Working pitch (word, from buffer[0])
;   $FFFFC0AE  Camera param A (word, from buffer[1])
;   $FFFFC0BC  Elevation offset source (word, read)
;   $FFFFC0B0  Camera param B (word, from $C0BC)
;   $FFFFC056  Viewport yaw (word, from buffer[2])
;   $FFFFC894  Working yaw (word, from buffer[2])
;
; Entry: No register inputs
; Exit:  Camera configured from buffer with elevation offset
; Uses:  D0, A1
; ============================================================================

camera_offset_setup:
        move.w  #$0000,($FFFFC0BA).w           ; $008C16: $31FC $0000 $C0BA — clear override flag
        lea     ($FFFFC0C0).w,a1                ; $008C1C: $43F8 $C0C0 — point to parameter buffer
        move.w  (a1)+,d0                        ; $008C20: $3019 — read buffer[0] = pitch
        move.w  d0,($FFFFC054).w                ; $008C22: $31C0 $C054 — write viewport pitch
        move.w  d0,($FFFFC892).w                ; $008C26: $31C0 $C892 — write working pitch
        move.w  (a1)+,($FFFFC0AE).w             ; $008C2A: $31D9 $C0AE — buffer[1] → param A
        move.w  ($FFFFC0BC).w,($FFFFC0B0).w     ; $008C2E: $31F8 $C0BC $C0B0 — elevation → param B
        move.w  (a1),d0                         ; $008C34: $3011 — read buffer[2] = yaw
        move.w  d0,($FFFFC056).w                ; $008C36: $31C0 $C056 — write viewport yaw
        move.w  d0,($FFFFC894).w                ; $008C3A: $31C0 $C894 — write working yaw
        rts                                     ; $008C3E: $4E75
