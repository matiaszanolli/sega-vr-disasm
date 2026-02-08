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
; 3. Epilogue: Drains queue, increments tick counter, samples frame counter
; 4. Every 60 ticks (1 second), FPS = delta of $FFFFC964 frame counter
; 5. Epilogue: Renders FPS on work frames, returns via RTE
;
; WHY EPILOGUE-ONLY STATE
; ------------------------
; Original V-INT handler at $00881684 corrupts high WRAM ranges (including
; $CA20, $D200, etc). State written in wrapper does not survive to epilogue.
; Solution: All FPS state writes happen in epilogue (single execution context).
;
; RAM LAYOUT (10 bytes at $FFFFE600-$FFFFE609)
; ------------------------------------------------------------
; $FFFFE600: fps_vint_tick   (word) - V-INT tick counter (0-59)
; $FFFFE602: fps_value       (word) - Current FPS for display (0-99)
; $FFFFE604: fps_last_c964   (long) - Frame counter snapshot from last sample
; $FFFFE608: fps_canary      (word) - Persistence test canary (0xA55A)
;
; NOTE: Uses existing game frame counter at $FFFFC964 as data source.
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

; --- RAM variable addresses (epilogue-only state, 10 bytes) ---
FPS_BASE         equ     $FFFFE600      ; Base address for all FPS variables
fps_vint_tick    equ     FPS_BASE+0     ; $FFFFE600: V-INT tick counter (word)
fps_value        equ     FPS_BASE+2     ; $FFFFE602: Current FPS display value (word)
fps_last_c964    equ     FPS_BASE+4     ; $FFFFE604: Last sampled frame counter (long)
fps_canary       equ     FPS_BASE+8     ; $FFFFE608: Persistence canary (word)

; --- Game frame counter (existing VRD state) ---
FRAME_COUNTER    equ     $FFFFC964      ; Game's frame counter (increments on work frames)

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

        ; === TEST LADDER STEP 1: Render-path sanity (epilogue write only) ===
        ; Write constant 42 to verify render path works at $FFFFE600
        ; Expected: Stable "42" display
        move.w  #42,fps_value

        ; === FULL FPS LOGIC (disabled for step 1) ===
        ; addq.w  #1,fps_vint_tick
        ; cmpi.w  #60,fps_vint_tick       ; 60 V-INTs = 1 second (NTSC)
        ; blt.s   .render
        ;
        ; ; Sample FPS once per second: delta of $FFFFC964 frame counter
        ; move.l  FRAME_COUNTER.w,d0      ; Current frame count
        ; sub.l   fps_last_c964,d0        ; Subtract last sample = frames in last second
        ; move.w  d0,fps_value            ; Store FPS for display
        ; move.l  FRAME_COUNTER.w,fps_last_c964  ; Update snapshot for next sample
        ; clr.w   fps_vint_tick           ; Reset tick counter

.render:
        ; WORK PATH: Render on frames with work (should be minority during idle)
        bsr.w   fps_render

        movem.l (sp)+,d0-d1/a0-a1       ; Restore pre-interrupt register values
        rte

; ============================================================================
; End of fps_vint_wrapper + vint_epilogue
; ============================================================================
