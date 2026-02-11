; ============================================================================
; Race Init Phase 2 — VDP Scroll Mode Configuration
; ROM Range: $00C6A4-$00C6B6 (18 bytes)
; Source: code_c200
; ============================================================================
;
; PURPOSE
; -------
; Second phase of race initialization, called when scene state ($C8F4) = 8.
; Checks if display bit 7 has been set (by phase 1). If not yet set, writes
; VDP register 11 command ($8B00) to configure horizontal scroll mode to
; full-screen scrolling, then advances the scene state to 12.
;
; VDP register $0B ($8B00):
;   Bits 1-0 = 00: Full screen horizontal scroll
;   Bit 2 = 0: Full screen vertical scroll
;   Bit 3 = 0: External interrupt disabled
;
; Called from the scene state dispatcher (c200_func_005 / fn_c200_035).
; Assumes A5 points to VDP control port ($C00004).
;
; MEMORY VARIABLES
; ----------------
;   $FFFFC80E  Display control flags (bit 7 tested)
;   $FFFFC8F4  Scene state (word, advanced from 8 to 12)
;
; Entry: A5 = VDP control port
; Exit:  VDP register 11 configured, scene state advanced to 12
; Uses:  (none modified beyond VDP write and RAM)
; ============================================================================

c200_func_007:
        btst    #7,($FFFFC80E).w                ; $00C6A4: $0838 $0007 $C80E — display bit 7 set?
        bne.s   .done                           ; $00C6AA: $6608 — already configured: skip
        move.w  #$8B00,(a5)                     ; $00C6AC: $3ABC $8B00 — VDP reg 11 = full-screen scroll
        addq.b  #4,($FFFFC8F4).w                ; $00C6B0: $5838 $C8F4 — advance state (8→12)
.done:
        rts                                     ; $00C6B4: $4E75
