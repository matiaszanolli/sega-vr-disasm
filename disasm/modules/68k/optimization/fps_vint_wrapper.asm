; ============================================================================
; FPS V-INT Wrapper - Accurate Frame Rate Measurement
; Location: MUST be first module in optimization area ($89C208)
; ============================================================================
;
; PURPOSE
; -------
; Thin wrapper inserted before the original V-INT handler via vector redirect.
; Runs on EVERY V-INT (even when $C87A = 0), providing accurate time base
; for FPS measurement.
;
; HOW IT WORKS
; ------------
; 1. Increments a V-INT tick counter on every call (60 ticks/sec NTSC)
; 2. Every 60 ticks (1 second), samples the game's frame counter at $C964
; 3. FPS = (current $C964) - (last sampled $C964)
; 4. Jumps to original V-INT handler at $00881684
;
; WHY VECTOR REDIRECT
; -------------------
; The original V-INT handler exits early when $C87A = 0 (no work pending).
; The frame counter at $C964 only increments when work IS pending. To measure
; FPS accurately, we need a counter that runs on every V-INT regardless.
;
; RAM LAYOUT (16 bytes in isolated $D200 range)
; ------------------------------------------------------------
; $FFFFD200: fps_vint_tick   (word) - V-INT tick counter (0-59)
; $FFFFD202: fps_value       (word) - Current FPS for display (0-99)
; $FFFFD204: fps_flip_counter (long) - FS bit transition counter
; $FFFFD208: fps_flip_last   (long) - Flip counter snapshot from last sample
; $FFFFD20C: fps_fs_last     (word) - Last FS bit state (0 or 1)
; $FFFFD20E: fps_sentinel    (word) - DIAGNOSTIC: Same-frame survival test
;
; NOTE: Relocated to $D200 after RAM corruption confirmed in $CA20 range.
; $D200 is far from all documented game state ($C800-$C9FF active regions).
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

; --- RAM variable addresses (unified symbol base) ---
FPS_BASE         equ     $FFFFD200      ; Base address for all FPS variables
fps_vint_tick    equ     FPS_BASE+0     ; $FFFFD200: V-INT tick counter (word)
fps_value        equ     FPS_BASE+2     ; $FFFFD202: Current FPS display value (word)
fps_flip_counter equ     FPS_BASE+4     ; $FFFFD204: Buffer flip counter (long)
fps_flip_last    equ     FPS_BASE+8     ; $FFFFD208: Last sampled flip count (long)
fps_fs_last      equ     FPS_BASE+12    ; $FFFFD20C: Last FS bit state (word)
fps_sentinel     equ     FPS_BASE+14    ; $FFFFD20E: Sentinel canary (word)

; --- Original V-INT handler address ---
ORIG_VINT       equ     $00881684       ; Original handler (68K CPU address)

fps_vint_wrapper:
        ; Always increment tick counter (runs every V-INT)
        addq.w  #1,fps_vint_tick

        ; === DIAGNOSTIC A: Force constant 42 every V-INT ===
        ; Tests if display path is stable (should show stable "42")
        move.w  #42,fps_value

        ; === Same-frame survival test: Sentinel canary ===
        ; Write sentinel immediately after display value.
        ; vint_epilogue will check if this survives until render time.
        move.w  #$4242,fps_sentinel

.skip_sample:
        ; Gate render by work/no-work state
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

        ; === Dual-stage sentinel test: Isolate corruption point ===
        ; Stage 1: Check BEFORE queue drain (tests original V-INT handler)
        cmpi.w  #$4242,fps_sentinel
        beq.s   .pre_queue_ok
        ; Corrupted before queue drain - V-INT handler clobbered it
        move.w  #91,fps_value           ; Display = 91 (pre-drain corruption)
        bra.w   .render_now             ; Use word branch (longer range)
.pre_queue_ok:

        ; Stage 2: Drain queue, then check again
        bsr.w   sh2_wait_queue_empty    ; Drain async command queue
        cmpi.w  #$4242,fps_sentinel
        beq.s   .post_queue_ok
        ; Corrupted during/after queue drain
        move.w  #92,fps_value           ; Display = 92 (queue-drain corruption)
        bra.w   .render_now             ; Use word branch (longer range)
.post_queue_ok:
        ; Sentinel survived both checks - display = 42 (from wrapper)

.render_now:
        ; === OPTION 5 SANITY TEST ===
        ; Override fps_value with 42 written RIGHT NOW (epilogue-time)
        ; Tests: Does render path work when value is written at render time?
        ; Expected: Stable "42" if epilogue-time writes work (bypasses WRAM handoff)
        move.w  #42,fps_value

        ; WORK PATH: Render on frames with work (should be minority during idle)
        bsr.w   fps_render

        movem.l (sp)+,d0-d1/a0-a1      ; Restore pre-interrupt register values
        rte

; ============================================================================
; End of fps_vint_wrapper + vint_epilogue
; ============================================================================
