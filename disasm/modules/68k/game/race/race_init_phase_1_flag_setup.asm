; ============================================================================
; Race Init Phase 1 — Flag Setup
; ROM Range: $00C680-$00C6A4 (36 bytes)
; Source: code_c200
; ============================================================================
;
; PURPOSE
; -------
; First phase of race initialization, called when scene state ($C8F4) = 4.
; Enables several control flags, sets a display configuration value, and
; advances the scene state to 8 for the next phase.
;
; Called from the scene state dispatcher (scene_state_disp_race_init_phases / fn_c200_035).
;
; MEMORY VARIABLES
; ----------------
;   $FFFFC802  Control flag C (byte, set to 1)
;   $FFFFC809  Control flag A (byte, set to 1)
;   $FFFFC80A  Control flag B (byte, set to 1)
;   $FFFFC80E  Display control flags (bit 7 set)
;   $FFFFC822  Configuration value (byte, set to $F3)
;   $FFFFC8F4  Scene state (word, advanced from 4 to 8)
;
; Entry: No register inputs
; Exit:  Flags configured, scene state advanced to 8
; Uses:  (none modified beyond RAM writes)
; ============================================================================

race_init_phase_1_flag_setup:
        move.b  #$01,($FFFFC809).w              ; $00C680: $11FC $0001 $C809 — enable flag A
        move.b  #$01,($FFFFC80A).w              ; $00C686: $11FC $0001 $C80A — enable flag B
        bset    #7,($FFFFC80E).w                ; $00C68C: $08F8 $0007 $C80E — set display bit 7
        move.b  #$01,($FFFFC802).w              ; $00C692: $11FC $0001 $C802 — enable flag C
        move.b  #$F3,($FFFFC822).w              ; $00C698: $11FC $00F3 $C822 — config = $F3
        addq.b  #4,($FFFFC8F4).w                ; $00C69E: $5838 $C8F4 — advance state (4→8)
        rts                                     ; $00C6A2: $4E75
