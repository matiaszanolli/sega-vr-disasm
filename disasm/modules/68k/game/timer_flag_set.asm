; ============================================================================
; Timer Wait and Set Transition Flags
; ROM Range: $004390-$0043BC (44 bytes)
; ============================================================================
;
; PURPOSE
; -------
; Waits for the frame counter at $C8AA to reach 40 ($0028). When the
; timer expires, advances the state machine at $C07C, clears the timer,
; and sets all transition control flags (C809, C80A, C80E bit 7, C802).
;
; MEMORY VARIABLES
; ----------------
;   $FFFFC8AA  Frame counter (word, compared against $0028)
;   $FFFFC07C  State machine counter (word, advanced by 4)
;   $FFFFC809  Control flag A (byte, set to 1)
;   $FFFFC80A  Control flag B (byte, set to 1)
;   $FFFFC80E  Display control flags (bit 7 set)
;   $FFFFC802  Control flag C (byte, set to 1)
;
; Entry: No register inputs
; Exit:  If timer expired: state advanced, flags set
; Uses:  (none modified beyond RAM writes)
; ============================================================================

timer_flag_set:
        cmpi.w  #$0028,($FFFFC8AA).w           ; $004390: $0C78 $0028 $C8AA — 40 frames elapsed?
        bne.s   .done                           ; $004396: $6622 — not yet: return
        addq.w  #4,($FFFFC07C).w               ; $004398: $5878 $C07C — advance state machine
        move.w  #$0000,($FFFFC8AA).w            ; $00439C: $31FC $0000 $C8AA — reset timer
        move.b  #$01,($FFFFC809).w              ; $0043A2: $11FC $0001 $C809 — enable flag A
        move.b  #$01,($FFFFC80A).w              ; $0043A8: $11FC $0001 $C80A — enable flag B
        bset    #7,($FFFFC80E).w                ; $0043AE: $08F8 $0007 $C80E — set display bit 7
        move.b  #$01,($FFFFC802).w              ; $0043B4: $11FC $0001 $C802 — enable flag C
.done:
        rts                                     ; $0043BA: $4E75
