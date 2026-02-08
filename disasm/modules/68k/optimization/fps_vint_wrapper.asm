; ============================================================================
; FPS V-INT Wrapper - Epilogue-Only Frame Rate Measurement
; Location: MUST be first module in optimization area ($89C208)
; ============================================================================
;
; PURPOSE
; -------
; Thin wrapper inserted before the original V-INT handler via vector redirect.
; Wrapper does NO state management (avoids proven WRAM corruption issue).
; All FPS logic happens in vint_epilogue after queue drain.
;
; HOW IT WORKS
; ------------
; 1. Wrapper: Renders FPS on no-work frames, jumps to original V-INT handler
; 2. Original V-INT handler executes, then jumps to vint_epilogue
; 3. Epilogue: Drains queue, tracks FS bit transitions (buffer flips)
; 4. Every 60 ticks (1 second), FPS = delta of flip counter
; 5. Epilogue: Renders FPS on work frames, returns via RTE
;
; FS BIT TRACKING: Reads $00A1518A (FBCTL) bit 0 every V-INT. When bit changes,
; a buffer flip occurred (new frame presented). Count transitions = actual FPS.
;
; WHY EPILOGUE-ONLY STATE
; ------------------------
; Original V-INT handler at $00881684 corrupts high WRAM ranges (including
; $CA20, $D200, etc). State written in wrapper does not survive to epilogue.
; Solution: All FPS state writes happen in epilogue (single execution context).
;
; RAM LAYOUT (14 bytes at $FFFFE600-$FFFFE60D)
; ------------------------------------------------------------
; $FFFFE600: fps_vint_tick    (word) - V-INT tick counter (0-59)
; $FFFFE602: fps_value        (word) - Current FPS for display (0-99)
; $FFFFE604: fps_flip_counter (long) - Total buffer flip count
; $FFFFE608: fps_flip_last    (long) - Last sampled flip count
; $FFFFE60C: fps_fs_last      (word) - Last FS bit state (0 or 1)
;
; NOTE: Measures actual buffer flips (FS bit transitions in $00A1518A FBCTL).
; NOTE: This is true presented frame rate, not V-INT frequency.
; NOTE: Relocated to $FFFFE600 after collision confirmed at $FFFFC8F8.
;
; CALLING CONVENTION
; ------------------
; Called from: V-INT vector at ROM $000078 (redirected to $0089C208)
; Parameters: None (interrupt context)
; Returns: Jumps to original V-INT handler
; Clobbers: Nothing (saves/restores D0 when sampling)
; Cost: ~20 cycles fast path, ~60 cycles every 60th V-INT
;
; Related: fps_render.asm, vint_handler (code_200.asm)
; ============================================================================

; --- RAM variable addresses (epilogue-only state, 16 bytes) ---
FPS_BASE         equ     $FFFFE600      ; Base address for all FPS variables
fps_vint_tick    equ     FPS_BASE+0     ; $FFFFE600: V-INT tick counter (word)
fps_value        equ     FPS_BASE+2     ; $FFFFE602: Current FPS display value (word)
fps_flip_counter equ     FPS_BASE+4     ; $FFFFE604: Total buffer flip count (long)
fps_flip_last    equ     FPS_BASE+8     ; $FFFFE608: Last sampled flip count (long)
fps_fs_last      equ     FPS_BASE+12    ; $FFFFE60C: Last FS bit state (word)

; --- 32X hardware registers ---
FBCTL            equ     $00A1518A      ; Frame Buffer Control (bit 0 = FS buffer select)

; --- Original V-INT handler address ---
ORIG_VINT        equ     $00881684      ; Original handler (68K CPU address)

fps_vint_wrapper:
        ; Wrapper does NO state management - epilogue owns all FPS logic.
        ; Only renders on no-work path (work path uses epilogue render).
        tst.w   $FFFFC87A.w                    ; Check work pending flag
        bne.s   .skip_no_work_render           ; If work, epilogue will render

        ; NO-WORK PATH: Render on idle frames (should be majority)
        bsr.w   fps_render

.skip_no_work_render:
        jmp     ORIG_VINT                      ; Jump to original V-INT handler

; ============================================================================
; V-INT Epilogue - Tail of the V-INT handler (jumped to from code_200.asm)
; ============================================================================
; The V-INT handler in code_200.asm has no room for extra JSRs (section is
; byte-exact to $2200). Instead, it jumps here after restoring registers.
; We re-enable interrupts, drain the async queue, render FPS, and RTE.
; ============================================================================

vint_epilogue:
        move.w  #$2300,sr               ; Re-enable interrupts (was in code_200)
        movem.l d0-d1/a0-a1,-(sp)      ; Save regs clobbered by queue drain + fps_render

        ; Drain async queue first (SH2 rendering must complete)
        bsr.w   sh2_wait_queue_empty

        ; === TRACK FS BIT TRANSITIONS (actual buffer flips) ===
        ; Read current FS bit from frame buffer control register
        move.w  FBCTL,d0                ; Read FBCTL ($00A1518A)
        andi.w  #1,d0                   ; Isolate FS bit (bit 0)
        cmp.w   fps_fs_last,d0          ; Compare to last known state
        beq.s   .no_flip                ; Same state = no flip

        ; FS bit changed - buffer flip occurred
        addq.l  #1,fps_flip_counter     ; Increment flip counter
        move.w  d0,fps_fs_last          ; Update last state

.no_flip:
        ; === TEST 1: Display raw flip counter modulo 100 every V-INT ===
        ; TEMP: Bypasses once-per-second sampling to show raw counter
        move.w  fps_flip_counter,d0     ; Low 16 bits (enough for test window)
        divu    #100,d0                 ; Quotient:low, remainder:high
        swap    d0                      ; Remainder -> low word
        move.w  d0,fps_value            ; Show raw counter % 100

        ; COMM mirrors for debugging (visible in debugger or via register dump)
        move.w  fps_flip_counter,$00A15128  ; COMM4 = flip_counter low word
        move.w  fps_value,$00A1512A         ; COMM5 = display value (counter % 100)

        ; === DISABLED: Once-per-second sampling (for Test 1) ===
        ; addq.w  #1,fps_vint_tick
        ; cmpi.w  #60,fps_vint_tick
        ; blt.s   .render
        ; move.l  fps_flip_counter,d0
        ; sub.l   fps_flip_last,d0
        ; move.w  d0,fps_value
        ; move.l  fps_flip_counter,fps_flip_last
        ; clr.w   fps_vint_tick

.render:
        ; WORK PATH: Render on frames with work (should be minority during idle)
        bsr.w   fps_render

        movem.l (sp)+,d0-d1/a0-a1       ; Restore pre-interrupt register values
        rte

; ============================================================================
; End of fps_vint_wrapper + vint_epilogue
; ============================================================================
