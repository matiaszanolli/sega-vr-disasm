; ============================================================================
; FPS V-INT Wrapper - Frame Rate Measurement via Frame Buffer Toggle
; Location: MUST be first module in optimization area ($89C208)
; ============================================================================
;
; PURPOSE
; -------
; Thin wrapper inserted before the original V-INT handler via vector redirect.
; Measures actual rendered FPS by counting frame buffer page flips per 60
; V-INTs (1 second on NTSC). Renders cached FPS value on all frames.
;
; ARCHITECTURE
; ------------
; WRAPPER (every V-INT, pre-handler):
;   - Increments fps_vint_tick (60 Hz time base)
;   - Every 60 ticks: snapshots fps_work_frames → fps_value, resets counters
;   - On no-work frames: calls fps_render to display cached value
;   - Jumps to original V-INT handler
;
; EPILOGUE (every work frame, post-handler via JMP from code_200.asm):
;   - Detects frame buffer page flip by comparing $FFFFC80C against saved state
;   - Only increments fps_work_frames when toggle bit CHANGED (= new frame)
;   - Calls fps_render to display cached value
;   - Returns from interrupt (RTE)
;
; WHY TOGGLE DETECTION:
; The game has 6 different V-INT state handlers that flip $FFFFC80C bit 0
; (states 24, 36, 48, 52, 56 and vdp_reg_write_32x_adapter_control).
; Checking specific state values is fragile. Monitoring the actual toggle
; bit catches ALL frame flips regardless of which state handler did it.
; Non-flip work V-INTs (~40/sec) are correctly excluded.
;
; RAM LAYOUT (8 bytes at $FFFFC978-$FFFFC97F)
; ------------------------------------------------------------
; $FFFFC978: fps_vint_tick    (word) - V-INT counter (0-59, 60 Hz time base)
; $FFFFC97A: fps_work_frames  (word) - Frame flips in current 1-second window
; $FFFFC97C: fps_value        (word) - Current FPS for display (0-99)
; $FFFFC97E: fps_last_toggle  (word) - Last seen $FFFFC80C value (for change detection)
;
; ADDRESS ASSIGNMENT RATIONALE:
; Previous location ($FFFFF000) was cleared by an unknown V-INT state handler
; sweep. Constant-42 diagnostic confirmed epilogue fires and fps_render works,
; but fps_vint_tick read 0 every frame. Moving to $FFFFC978 — adjacent to the
; game frame counter ($FFFFC964) which provably survives the sweep. No game
; code references $FFFFC978-$FFFFC97F (verified by full-ROM grep).
;
; CALLING CONVENTION
; ------------------
; Called from: V-INT trampoline at ROM $0002AE (redirected to $0089C208)
; Parameters: None (interrupt context)
; Returns: Jumps to original V-INT handler
; Clobbers: Nothing
; Cost: ~14 cycles normal path, ~30 cycles snapshot path
;
; Related: fps_render.asm, vint_handler (code_200.asm)
; ============================================================================

; --- RAM variable addresses ---
; SAFE ZONE: $FFFFC978 is near the game frame counter ($FFFFC964)
; which provably survives V-INT state handler sweeps.
FPS_BASE         equ     $FFFFC978      ; Work RAM (safe zone near game variables)
fps_vint_tick    equ     FPS_BASE+0     ; $FFFFC978: V-INT counter (word, 0-59)
fps_work_frames  equ     FPS_BASE+2     ; $FFFFC97A: Frame flip accumulator (word)
fps_value        equ     FPS_BASE+4     ; $FFFFC97C: FPS display value (word, 0-99)
fps_last_toggle  equ     FPS_BASE+6     ; $FFFFC97E: Last $FFFFC80C state (word)

; --- Original V-INT handler address ---
ORIG_VINT        equ     $00881684      ; Original handler (68K CPU address)

fps_vint_wrapper:
        ; Increment V-INT counter (60 Hz time base)
        addq.w  #1,fps_vint_tick.w      ; Force absolute short addressing

        ; Check if 1 second (60 V-INTs) has elapsed
        cmpi.w  #60,fps_vint_tick.w
        bne.s   .no_snapshot

        ; 1-second snapshot: FPS = work frames counted in this window
        move.w  fps_work_frames.w,fps_value.w
        clr.w   fps_work_frames.w
        clr.w   fps_vint_tick.w

.no_snapshot:
        ; Check work gate (same flag the original handler checks)
        tst.w   $FFFFC87A.w
        bne.s   .work

        ; NO-WORK PATH: Render cached fps_value on idle frames
        ; jsr uses abs.l addressing (immune to vasm BSR.W +2 displacement bug).
        ; fps_render is in org $01C200 section; +$880000 converts to 68K CPU address.
        jsr     fps_render+$880000

.work:
        jmp     ORIG_VINT              ; Jump to original V-INT handler

; ============================================================================
; V-INT Epilogue - Tail of the V-INT handler (jumped to from code_200.asm)
; ============================================================================
; Runs after every work V-INT. Detects frame buffer page flips by comparing
; $FFFFC80C against saved state — only counts actual new rendered frames.
;
; Entry: registers already restored by vint_handler before the JMP here.
;        sr is at whatever level the handler left it.
; ============================================================================

vint_epilogue:
        move.w  #$2700,sr               ; Keep interrupts disabled (prevent re-entry)
        movem.l d0-d7/a0-a6,-(sp)       ; Save ALL registers

        ; Detect frame buffer toggle: compare current $C80C against saved state
        ; 6 different state handlers flip bit 0 of $FFFFC80C on page flip.
        ; Only increment fps_work_frames when the bit CHANGED (= new frame).
        move.b  ($FFFFC80C).w,d0        ; D0 = current frame toggle bit
        cmp.b   fps_last_toggle.w,d0    ; Same as last seen?
        beq.s   .no_flip                ; Yes → not a new frame
        move.b  d0,fps_last_toggle.w    ; Save new state
        addq.w  #1,fps_work_frames.w    ; Count this frame buffer flip
.no_flip:
        ; Render the FPS display
        ; jsr uses abs.l addressing (immune to vasm BSR.W +2 displacement bug).
        ; fps_render is in org $01C200 section; +$880000 converts to 68K CPU address.
        jsr     fps_render+$880000

        movem.l (sp)+,d0-d7/a0-a6
        rte

; ============================================================================
; End of fps_vint_wrapper + vint_epilogue
; ============================================================================
