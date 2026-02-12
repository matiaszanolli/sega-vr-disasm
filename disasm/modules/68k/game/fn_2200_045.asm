; ============================================================================
; Load Object Pointer + Clear Object State
; ROM Range: $003250-$003272 (34 bytes)
; ============================================================================
; Loads object pointer from $C258 into A1, sets object command byte
; (offset $00) to $02, then clears three state bytes: two SH2 shared
; ($FF6940, $FF6950) and flag byte $C305.
;
; Memory:
;   $FFFFC258 = object pointer (long, loaded into A1)
;   $00FF6940 = SH2 shared object byte 1 (cleared)
;   $00FF6950 = SH2 shared object byte 2 (cleared)
;   $FFFFC305 = flag byte (byte, cleared)
; Entry: none | Exit: object + state cleared | Uses: A1
; ============================================================================

fn_2200_045:
        movea.l ($FFFFC258).w,a1                ; $003250: $2278 $C258 — load object pointer
        move.b  #$02,$0000(a1)                  ; $003254: $137C $0002 $0000 — set object command
        move.b  #$00,$00FF6940                  ; $00325A: $13FC $0000 $00FF $6940 — clear SH2 obj byte 1
        move.b  #$00,$00FF6950                  ; $003262: $13FC $0000 $00FF $6950 — clear SH2 obj byte 2
        move.b  #$00,($FFFFC305).w              ; $00326A: $11FC $0000 $C305 — clear flag byte
        rts                                     ; $003270: $4E75

