; ============================================================================
; Countdown Timer Setup — Race Start Initialization
; ROM Range: $00C5AE-$00C618 (106 bytes)
; Source: code_c200
; ============================================================================
;
; PURPOSE
; -------
; Manages the race-start countdown trigger based on the timeline frame counter
; ($C080). When the timeline reaches exactly frame 995 ($03E3), this function
; initializes the countdown sequence: sets the active flag, configures camera
; parameters, copies stored viewport settings, and prepares animation state.
;
; For frames before 995, it skips directly to the RTS in the countdown update
; module (countdown_timer_update_anim_race_start). For frames after 995, it falls through to countdown_timer_update_anim_race_start
; which handles the ongoing countdown animation and camera zoom.
;
; TIMELINE FLOW
; -------------
;   Frame < 995:  Early return (BLT → countdown_done)
;   Frame = 995:  Initialize countdown (this function), then return
;   Frame > 995:  Fall through to countdown_timer_update_anim_race_start (countdown update)
;   Frame 1296:   Race starts (handled by countdown_timer_update_anim_race_start)
;
; MEMORY VARIABLES
; ----------------
;   $FFFFC080  Timeline frame counter (word, incremented each frame)
;   $FFFFC081  (low byte of above, used for countdown display)
;   $FFFFC0AE  Active camera X position (word)
;   $FFFFC0B0  Camera zoom level (word, animated 0→$1000)
;   $FFFFC0B2  Camera rotation (word, cleared at countdown start)
;   $FFFFC0BA  Countdown frame counter (word, cleared at start)
;   $FFFFC0C6  Countdown animation timer (word, animated 0→$30)
;   $FFFFC0C8  Camera distance setting (word, set to $00C0)
;   $FFFFC0FC  Control mode (word, set to 8 = countdown mode)
;   $FFFFC054  Viewport width (word, copied from stored value)
;   $FFFFC056  Viewport height (word, copied from stored value)
;   $FFFFC313  State flags (bit 1 = countdown active, bit 3 = cleared)
;   $FFFFC81C  Countdown trigger flag (bit 0 = countdown started)
;   $FFFFC896  Countdown phase byte (cleared to 0)
;   $FFFFC8DA  Stored camera X position (word, template)
;   $FFFFC8DC  Stored viewport width (word, template)
;   $FFFFC8DE  Stored viewport height (word, template)
;   $00FF60CC  Display control flag (word, set to $0100)
;
; Entry: No register inputs (reads timeline from RAM)
; Exit:  Countdown initialized if frame == 995; otherwise no-op or falls through
; Uses:  D0
; ============================================================================

countdown_timer_setup_race_start_init:
; --- Check timeline frame counter ---
        move.w  ($FFFFC080).w,d0                ; $00C5AE: $3038 $C080 — load timeline
        cmpi.w  #$03E3,d0                       ; $00C5B2: $0C40 $03E3 — frame 995?
        blt.w   countdown_done                  ; $00C5B6: $6D00 $00A8 — before 995: skip
        cmpi.w  #$03E3,d0                       ; $00C5BA: $0C40 $03E3 — exact match?
        bne.s   countdown_timer_update_anim_race_start                     ; $00C5BE: $6658 — after 995: update handler

; --- Frame 995: Initialize countdown sequence ---
        bset    #0,($FFFFC81C).w                ; $00C5C0: $08F8 $0000 $C81C — countdown started
        move.w  #$00C0,($FFFFC0C8).w            ; $00C5C6: $31FC $00C0 $C0C8 — camera distance
        move.w  #$0100,$00FF60CC                 ; $00C5CC: $33FC $0100 $00FF $60CC — display flag

; --- Copy stored camera/viewport templates to active registers ---
        move.w  ($FFFFC8DA).w,($FFFFC0AE).w     ; $00C5D4: $31F8 $C8DA $C0AE — camera X
        move.w  #$0000,($FFFFC0B0).w            ; $00C5DA: $31FC $0000 $C0B0 — zoom = 0
        move.w  #$0000,($FFFFC0B2).w            ; $00C5E0: $31FC $0000 $C0B2 — rotation = 0
        move.w  ($FFFFC8DC).w,($FFFFC054).w     ; $00C5E6: $31F8 $C8DC $C054 — viewport W
        move.w  ($FFFFC8DE).w,($FFFFC056).w     ; $00C5EC: $31F8 $C8DE $C056 — viewport H

; --- Clear animation state ---
        move.w  #$0000,($FFFFC0C6).w            ; $00C5F2: $31FC $0000 $C0C6 — anim timer = 0
        move.w  #$0000,($FFFFC0BA).w            ; $00C5F8: $31FC $0000 $C0BA — frame counter = 0

; --- Set countdown mode flags ---
        bset    #1,($FFFFC313).w                ; $00C5FE: $08F8 $0001 $C313 — countdown active
        bclr    #3,($FFFFC313).w                ; $00C604: $08B8 $0003 $C313 — clear old state
        move.b  #$00,($FFFFC896).w              ; $00C60A: $11FC $0000 $C896 — phase = 0
        move.w  #$0008,($FFFFC0FC).w            ; $00C610: $31FC $0008 $C0FC — countdown mode
        rts                                     ; $00C616: $4E75
