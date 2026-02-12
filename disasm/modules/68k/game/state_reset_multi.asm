; ============================================================================
; Comprehensive State Reset
; ROM Range: $0044A6-$0044E8 (66 bytes)
; ============================================================================
;
; PURPOSE
; -------
; Full state reset clearing control flags, counters, display parameters,
; and setting the execution vector. Used during scene transitions.
;
; Clears bits 7,3 then bits 5,4,3 of the display control byte ($C80E),
; zeros multiple state counters, sets display size to $0020, resets the
; execution control byte, and writes the jump vector to $008909AE.
;
; MEMORY VARIABLES
; ----------------
;   $FFFFC80E  Display control flags (bits 7,5,4,3 cleared)
;   $FFFFC87E  State counter A (word, cleared to 0)
;   $FFFFC8A8  State counter B (word, cleared to 0)
;   $FFFFC880  State counter C (word, cleared via D0)
;   $FFFFC882  State counter D (word, cleared via D0)
;   $00FF0008  Display size (word, set to $0020)
;   $FFFFC800  Execution control byte (byte, cleared to 0)
;   $00FF0002  Jump vector (long, set to $008909AE)
;
; Entry: No register inputs
; Exit:  All state variables reset, execution vector configured
; Uses:  D0
; ============================================================================

state_reset_multi:
        andi.b  #$77,($FFFFC80E).w             ; $0044A6: $0238 $0077 $C80E — clear bits 7,3
        move.w  #$0000,($FFFFC87E).w            ; $0044AC: $31FC $0000 $C87E — clear state counter A
        move.w  #$0000,($FFFFC8A8).w            ; $0044B2: $31FC $0000 $C8A8 — clear state counter B
        moveq   #0,d0                           ; $0044B8: $7000
        move.w  d0,($FFFFC880).w                ; $0044BA: $31C0 $C880 — clear state counter C
        move.w  d0,($FFFFC882).w                ; $0044BE: $31C0 $C882 — clear state counter D
        move.w  #$0020,$00FF0008                ; $0044C2: $33FC $0020 $00FF $0008 — set display size
        andi.b  #$C7,($FFFFC80E).w             ; $0044CA: $0238 $00C7 $C80E — clear bits 5,4,3
        move.b  #$00,($FFFFC800).w              ; $0044D0: $11FC $0000 $C800 — clear execution control
        bclr    #3,($FFFFC80E).w                ; $0044D6: $08B8 $0003 $C80E — ensure bit 3 clear
        move.l  #$008909AE,$00FF0002            ; $0044DC: $23FC $0089 $09AE $00FF $0002 — set jump vector
        rts                                     ; $0044E6: $4E75
