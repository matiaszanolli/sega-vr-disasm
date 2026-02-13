; ============================================================================
; Countdown Timer Update — Animation and Race Start Trigger
; ROM Range: $00C618-$00C662 (74 bytes)
; Source: code_c200
; ============================================================================
;
; PURPOSE
; -------
; Called each frame after the countdown begins (timeline > 995). Handles two
; concurrent animations and the final race-start trigger:
;
;   1. Animation timer ($C0C6): Incremented by 2 each frame, clamped to 48.
;      Controls the visual countdown overlay animation speed.
;
;   2. Camera zoom ($C0B0): Incremented by $80 each frame, clamped to $1000.
;      Produces a smooth zoom-in effect during the countdown sequence.
;
;   3. Race start: At frame 1241 ($04D9), calls a subroutine at $00882066.
;      At frame 1296 ($0510), sets the transition trigger ($C8F4 = 4) to
;      begin the actual race, unless already triggered.
;
; This module is tightly coupled with fn_c200_034 (countdown setup), which
; branches here for frames > 995 and uses `countdown_done` for early return.
;
; TIMELINE
; --------
;   Frame  995: Countdown initialized (fn_c200_034)
;   Frame 996-1295: Animation updates (this function)
;   Frame 1241: Pre-race subroutine called
;   Frame 1296: Race start triggered ($C8F4 = 4)
;
; MEMORY VARIABLES
; ----------------
;   $FFFFC080  Timeline frame counter (word, read only)
;   $FFFFC0B0  Camera zoom level (word, animated $0080 per frame, max $1000)
;   $FFFFC0C6  Countdown animation timer (word, animated +2/frame, max $30)
;   $FFFFC8F4  State transition trigger (byte: 0=idle, 4=race start)
;
; Entry: No register inputs
; Exit:  Animation state updated; race started if frame >= 1296
; Uses:  D0 (preserved by subroutine call convention — caller saves)
; ============================================================================

countdown_timer_update_anim_race_start:
; --- Advance countdown animation timer (clamped to 48) ---
        addq.w  #2,($FFFFC0C6).w                ; $00C618: $5478 $C0C6 — timer += 2
        cmpi.w  #$0030,($FFFFC0C6).w            ; $00C61C: $0C78 $0030 $C0C6 — max 48?
        ble.s   .advance_zoom                    ; $00C622: $6F06 — within range
        move.w  #$0030,($FFFFC0C6).w            ; $00C624: $31FC $0030 $C0C6 — clamp to 48

; --- Advance camera zoom level (clamped to $1000) ---
.advance_zoom:
        addi.w  #$0080,($FFFFC0B0).w            ; $00C62A: $0678 $0080 $C0B0 — zoom += $80
        cmpi.w  #$1000,($FFFFC0B0).w            ; $00C630: $0C78 $1000 $C0B0 — max zoom?
        ble.s   .check_prerace                   ; $00C636: $6F06 — within range
        move.w  #$1000,($FFFFC0B0).w            ; $00C638: $31FC $1000 $C0B0 — clamp zoom

; --- Check for pre-race subroutine trigger (frame 1241) ---
.check_prerace:
        cmpi.w  #$04D9,($FFFFC080).w            ; $00C63E: $0C78 $04D9 $C080 — frame 1241?
        bne.s   .check_race_start                ; $00C644: $6606 — not yet
        jsr     $00882066                        ; $00C646: $4EB9 $0088 $2066 — pre-race handler

; --- Check for race start trigger (frame 1296) ---
.check_race_start:
        cmpi.w  #$0510,($FFFFC080).w            ; $00C64C: $0C78 $0510 $C080 — frame 1296?
        blt.s   countdown_done                   ; $00C652: $6D0C — not yet
        tst.b   ($FFFFC8F4).w                   ; $00C654: $4A38 $C8F4 — already triggered?
        bne.s   countdown_done                   ; $00C658: $6606 — yes: skip
        move.b  #$04,($FFFFC8F4).w              ; $00C65A: $11FC $0004 $C8F4 — trigger race start

; --- Shared return point (also used by fn_c200_034 for early exit) ---
countdown_done:
        rts                                     ; $00C660: $4E75
