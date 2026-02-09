; ============================================================================
; FPS V-INT Wrapper - Frame Rate Measurement via FS Bit Tracking
; Location: MUST be first module in optimization area ($89C208)
; ============================================================================
;
; PURPOSE
; -------
; Thin wrapper inserted before the original V-INT handler via vector redirect.
; Renders cached FPS value on no-work frames.
;
; ARCHITECTURE
; ------------
; ALL FPS logic runs in vint_epilogue (after handler completes).
; Wrapper has ZERO cross-handler dependencies - just renders cached value.
; This eliminates all state-lifetime bugs.
;
; RAM LAYOUT (14 bytes at $FFFFF000-$FFFFF00D)
; ------------------------------------------------------------
; $FFFFF000: fps_vint_tick    (word) - V-INT counter (0-59, 60 Hz time base)
; $FFFFF002: fps_value        (word) - Current FPS for display (0-99)
; $FFFFF004: fps_flip_counter (long) - Total buffer flip count
; $FFFFF008: fps_flip_last    (long) - Last sampled flip count
; $FFFFF00C: fps_fs_last      (word) - Last FS bit state (0 or 1)
;
; CALLING CONVENTION
; ------------------
; Called from: V-INT vector at ROM $000078 (redirected to $0089C208)
; Parameters: None (interrupt context)
; Returns: Jumps to original V-INT handler
; Clobbers: Nothing
; Cost: ~10 cycles work path, ~10 + fps_render cycles no-work path
;
; Related: fps_render.asm, vint_handler (code_200.asm)
; ============================================================================

; --- RAM variable addresses ---
; Work RAM above game's highest usage ($FFFFEF00 = RANDOM_SEED)
FPS_BASE         equ     $FFFFF000      ; Work RAM (above all game data)
fps_vint_tick    equ     FPS_BASE+0     ; $FFFFF000: V-INT counter (word, 0-59)
fps_value        equ     FPS_BASE+2     ; $FFFFF002: Current FPS display value (word)
fps_flip_counter equ     FPS_BASE+4     ; $FFFFF004: Total buffer flip count (long)
fps_flip_last    equ     FPS_BASE+8     ; $FFFFF008: Last sampled flip count (long)
fps_fs_last      equ     FPS_BASE+12    ; $FFFFF00C: Last FS bit state (word)

; --- Original V-INT handler address ---
ORIG_VINT        equ     $00881684      ; Original handler (68K CPU address)

fps_vint_wrapper:
        ; Increment V-INT counter (60 Hz time base)
        addq.w  #1,fps_vint_tick.w      ; Force absolute short addressing

        ; Check work gate (same flag the original handler checks)
        tst.w   $FFFFC87A.w
        bne.s   .work

        ; NO-WORK PATH: Render cached fps_value on idle frames
        bsr.w   fps_render

.work:
        jmp     ORIG_VINT              ; Jump to original V-INT handler

; ============================================================================
; V-INT Epilogue - Tail of the V-INT handler (jumped to from code_200.asm)
; ============================================================================
; Runs after every work frame. Reads fps_vint_tick from wrapper (60 Hz time base).
; Uses FS bit to detect actual buffer flips, samples every 60 V-INTs (1 second).
;
; This provides accurate FPS measurement at 60 Hz resolution, independent of
; work frame frequency.
; ============================================================================

vint_epilogue:
        move.w  #$2700,sr               ; Keep interrupts disabled (prevent re-entry)
        movem.l d0-d7/a0-a6,-(sp)       ; Save ALL registers (match original handler)

        bsr.w   sh2_wait_queue_empty    ; Wait for SH2

        ; === DETECT BUFFER FLIP ===
        ; Read VRD's flip flag (toggled by fn_200_036 BCHG #0,$FFFFC80C)
        ; More reliable than FBCTL polling
        move.w  $FFFFC80C.w,d0          ; Read VRD flip flag
        andi.w  #1,d0                   ; Isolate bit 0
        cmp.w   fps_fs_last.w,d0        ; Compare to last known state
        beq.s   .no_flip                ; Same = no flip
        addq.l  #1,fps_flip_counter.w   ; Flip detected (address, not operand size)
.no_flip:
        move.w  d0,fps_fs_last.w        ; Always update last state

        ; === SAMPLE EVERY 60 V-INTS (1 SECOND) ===
        cmpi.w  #60,fps_vint_tick.w     ; Force absolute short addressing
        blt.s   .render

        ; Compute FPS = delta(flip_counter) over last second
        move.l  fps_flip_counter.w,d0
        sub.l   fps_flip_last.w,d0      ; Flips in sample window
        move.w  d0,fps_value.w          ; Store for display
        move.l  fps_flip_counter.w,fps_flip_last.w
        subi.w  #60,fps_vint_tick.w     ; Force absolute short addressing

.render:
        ; DIAGNOSTIC: Display cumulative flip counter to verify detection works
        move.l  fps_flip_counter.w,d0
        move.w  #100,d1
        divu    d1,d0
        swap    d0                      ; Remainder in low word
        move.w  d0,fps_value.w
        bsr.w   fps_render              ; Render fps_value

        movem.l (sp)+,d0-d7/a0-a6       ; Restore ALL 14 registers (match save)
        rte

; ============================================================================
; End of fps_vint_wrapper + vint_epilogue
; ============================================================================
