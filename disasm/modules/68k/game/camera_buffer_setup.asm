; ============================================================================
; Camera Buffer Setup
; ROM Range: $008BC2-$008BF2 (48 bytes)
; ============================================================================
;
; PURPOSE
; -------
; Camera setup reading from the parameter buffer at $C0C0. Copies three
; buffer values to camera parameters ($C0AE, $C0B0, $C0B2), loads pitch
; from config, and sets yaw to a constant $0800.
;
; MEMORY VARIABLES
; ----------------
;   $FFFFC0BA  Camera override flag (word, cleared to 0)
;   $FFFFC0C0  Camera parameter buffer (3 words: read sequentially)
;   $FFFFC0AE  Camera param A (word, from buffer[0])
;   $FFFFC0B0  Camera param B (word, from buffer[1])
;   $FFFFC0B2  Camera param C (word, from buffer[2])
;   $FFFFC8DC  Pitch config (word, read)
;   $FFFFC054  Viewport pitch (word, written)
;   $FFFFC892  Working pitch (word, written)
;   $FFFFC056  Viewport yaw (word, set to $0800)
;   $FFFFC894  Working yaw (word, set to $0800)
;
; Entry: No register inputs
; Exit:  Camera configured from buffer with constant yaw
; Uses:  D0, A1
; ============================================================================

camera_buffer_setup:
        move.w  #$0000,($FFFFC0BA).w           ; $008BC2: $31FC $0000 $C0BA — clear override flag
        lea     ($FFFFC0C0).w,a1                ; $008BC8: $43F8 $C0C0 — point to parameter buffer
        move.w  (a1)+,($FFFFC0AE).w             ; $008BCC: $31D9 $C0AE — buffer[0] → param A
        move.w  (a1)+,($FFFFC0B0).w             ; $008BD0: $31D9 $C0B0 — buffer[1] → param B
        move.w  (a1),($FFFFC0B2).w              ; $008BD4: $31D1 $C0B2 — buffer[2] → param C (no advance)
        move.w  ($FFFFC8DC).w,d0                ; $008BD8: $3038 $C8DC — load pitch config
        move.w  d0,($FFFFC054).w                ; $008BDC: $31C0 $C054 — write viewport pitch
        move.w  d0,($FFFFC892).w                ; $008BE0: $31C0 $C892 — write working pitch
        move.w  #$0800,d0                       ; $008BE4: $303C $0800 — constant yaw value
        move.w  d0,($FFFFC056).w                ; $008BE8: $31C0 $C056 — write viewport yaw
        move.w  d0,($FFFFC894).w                ; $008BEC: $31C0 $C894 — write working yaw
        rts                                     ; $008BF0: $4E75
