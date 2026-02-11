; ============================================================================
; Scene Phase Timer — Reset
; ROM Range: $00C592-$00C5AE (28 bytes)
; Source: code_c200
; ============================================================================
;
; PURPOSE
; -------
; Resets the phase timer system to its initial state. Called when entering a
; new scene or restarting the phase sequence. Clears the timeline sub-counter,
; control mode, and sets the initial phase count.
;
; MEMORY VARIABLES
; ----------------
;   $00FF0008  Display control timer (word, set to $003C = 60 frames)
;   $FFFFC082  Timeline sub-counter (byte, cleared to 0)
;   $FFFFC0FC  Control mode (word, cleared to 0)
;   $FFFFC8C5  Phase count / initial state (byte, set to $18 = 24)
;
; Entry: No register inputs
; Exit:  Phase timer system reset
; Uses:  (none)
; ============================================================================

c200_func_003:
        move.w  #$003C,$00FF0008                ; $00C592: $33FC $003C $00FF $0008 — display timer = 60
        move.b  #$00,($FFFFC082).w              ; $00C59A: $11FC $0000 $C082 — clear timeline sub-counter
        move.w  #$0000,($FFFFC0FC).w            ; $00C5A0: $31FC $0000 $C0FC — clear control mode
        move.b  #$18,($FFFFC8C5).w              ; $00C5A6: $11FC $0018 $C8C5 — phase count = 24
        rts                                     ; $00C5AC: $4E75
