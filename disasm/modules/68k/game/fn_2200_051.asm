; ============================================================================
; Clear Object State Bytes
; ROM Range: $00359C-$0035B4 (24 bytes)
; ============================================================================
; Clears three object-related bytes: two in SH2 shared memory ($FF6940,
; $FF6950) and flag byte $C305 in 68K RAM.
;
; Memory:
;   $00FF6940 = SH2 shared object byte 1 (cleared)
;   $00FF6950 = SH2 shared object byte 2 (cleared)
;   $FFFFC305 = flag byte (byte, cleared)
; Entry: none | Exit: 3 bytes cleared | Uses: none
; ============================================================================

fn_2200_051:
        move.b  #$00,$00FF6940                  ; $00359C: $13FC $0000 $00FF $6940 — clear SH2 obj byte 1
        move.b  #$00,$00FF6950                  ; $0035A4: $13FC $0000 $00FF $6950 — clear SH2 obj byte 2
        move.b  #$00,($FFFFC305).w              ; $0035AC: $11FC $0000 $C305 — clear flag byte
        rts                                     ; $0035B2: $4E75

