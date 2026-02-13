; ============================================================================
; Full State Reset — Race Mode
; ROM Range: $0047E4-$00482A (70 bytes)
; ============================================================================
;
; PURPOSE
; -------
; Full state reset for race mode. Conditionally initializes the lap
; counter ($C260) if mode flag bit 5 is clear. Then clears all state
; counters/flags, sets display parameters, and configures the execution
; vector to $0088FB98.
;
; MEMORY VARIABLES
; ----------------
;   $FFFFC30E  Mode flags (bit 5 tested for lap init gate)
;   $FFFFC260  Lap counter (long, set to $60000000 if bit 5 clear)
;   $FFFFC80E  Display control flags (bit 7 cleared)
;   $FFFFC87E  State counter A (word, cleared to 0)
;   $FFFFC880  State counter B (word, cleared via D0)
;   $FFFFC882  State counter C (word, cleared via D0)
;   $FFFFC8A8  State counter D (word, cleared to 0)
;   $00FF0008  Display size (word, set to $0020)
;   $FFFFC800  Execution control byte (byte, cleared to 0)
;   $00FF0002  Jump vector (long, set to $0088FB98)
;
; Entry: No register inputs
; Exit:  State reset for race mode, execution vector configured
; Uses:  D0
; ============================================================================

full_state_reset_b:
        btst    #5,($FFFFC30E).w               ; $0047E4: $0838 $0005 $C30E — test mode flag bit 5
        bne.s   .skip_lap                       ; $0047EA: $660A — set: skip lap init
        move.l  #$60000000,($FFFFC260).w        ; $0047EC: $21FC $6000 $0000 $C260 — init lap counter
.skip_lap:
        andi.b  #$7F,($FFFFC80E).w             ; $0047F4: $0238 $007F $C80E — clear display bit 7
        move.w  #$0000,($FFFFC87E).w            ; $0047FA: $31FC $0000 $C87E — clear state counter A
        moveq   #0,d0                           ; $004800: $7000
        move.w  d0,($FFFFC880).w                ; $004802: $31C0 $C880 — clear state counter B
        move.w  d0,($FFFFC882).w                ; $004806: $31C0 $C882 — clear state counter C
        move.w  #$0000,($FFFFC8A8).w            ; $00480A: $31FC $0000 $C8A8 — clear state counter D
        move.w  #$0020,$00FF0008                ; $004810: $33FC $0020 $00FF $0008 — set display size
        move.b  #$00,($FFFFC800).w              ; $004818: $11FC $0000 $C800 — clear execution control
        move.l  #$0088FB98,$00FF0002            ; $00481E: $23FC $0088 $FB98 $00FF $0002 — set jump vector
        rts                                     ; $004828: $4E75
