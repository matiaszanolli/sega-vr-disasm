; ============================================================================
; Timer Complete with Conditional Flags
; ROM Range: $0046AA-$0046EE (68 bytes)
; ============================================================================
;
; PURPOSE
; -------
; Waits for frame counter $C8AA to reach 40 ($0028). When expired,
; advances state at $C8BE, clears timer, selects a sound effect based
; on the position flag at $C816 ($AB or $AA), then sets all transition
; control flags.
;
; MEMORY VARIABLES
; ----------------
;   $FFFFC8AA  Frame counter (word, compared against $0028)
;   $FFFFC8BE  State counter (word, advanced by 4)
;   $FFFFC8A5  Sound effect selector (byte, $AB or $AA)
;   $FFFFC816  Position flag (byte, selects effect variant)
;   $FFFFC800  Execution control (byte, set to 1)
;   $FFFFC809  Control flag A (byte, set to 1)
;   $FFFFC80A  Control flag B (byte, set to 1)
;   $FFFFC80E  Display control flags (bit 7 set)
;   $FFFFC802  Control flag C (byte, set to 1)
;
; Entry: No register inputs
; Exit:  If timer expired: state advanced, effect selected, flags set
; Uses:  (none modified beyond RAM writes)
; ============================================================================

timer_complete_flags:
        cmpi.w  #$0028,($FFFFC8AA).w           ; $0046AA: $0C78 $0028 $C8AA — 40 frames elapsed?
        bne.s   .done                           ; $0046B0: $663A — not yet: return
        addq.w  #4,($FFFFC8BE).w               ; $0046B2: $5878 $C8BE — advance state counter
        move.w  #$0000,($FFFFC8AA).w            ; $0046B6: $31FC $0000 $C8AA — reset timer
        move.b  #$AB,($FFFFC8A5).w              ; $0046BC: $11FC $00AB $C8A5 — default effect
        tst.b   ($FFFFC816).w                   ; $0046C2: $4A38 $C816 — test position flag
        beq.s   .set_flags                      ; $0046C6: $6706 — zero: keep default $AB
        move.b  #$AA,($FFFFC8A5).w              ; $0046C8: $11FC $00AA $C8A5 — alt effect
.set_flags:
        move.b  #$01,($FFFFC800).w              ; $0046CE: $11FC $0001 $C800 — enable execution control
        move.b  #$01,($FFFFC809).w              ; $0046D4: $11FC $0001 $C809 — enable flag A
        move.b  #$01,($FFFFC80A).w              ; $0046DA: $11FC $0001 $C80A — enable flag B
        bset    #7,($FFFFC80E).w                ; $0046E0: $08F8 $0007 $C80E — set display bit 7
        move.b  #$01,($FFFFC802).w              ; $0046E6: $11FC $0001 $C802 — enable flag C
.done:
        rts                                     ; $0046EC: $4E75
