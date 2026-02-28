; ============================================================================
; MARS Framebuffer Preparation (Double-Buffered)
; ROM Range: $00270A-$00273C (50 bytes)
; ============================================================================
; Prepares both MARS framebuffers in sequence. Calls three sub-routines
; for each buffer, selecting the active framebuffer via the MARS FB
; control register at offset $8B from MARS_SYS_BASE. The frame toggle
; flag at $C80C determines which buffer gets drawn first.
;
; Memory:
;   $FFFFC80C = frame buffer toggle flag (byte, bit 0 tested)
;   MARS_SYS_BASE+$8B = MARS FB control register (byte, selects buffer)
; Entry: none | Exit: both framebuffers prepared
; Uses: D0, D2, A4
; ============================================================================

mars_framebuffer_preparation:
        lea     MARS_SYS_BASE,a4               ; $00270A: $49F9 $00A1 $5100 — MARS register base
        bsr.s   vdp_fill_framebuffer+6          ; $002710: call sub 1 (entry at +6)
        jsr     vdp_fill_line_table_flat+8(pc); $4EBA $008C
        jsr     gfx_32x_framebuffer_palette_fill(pc); $4EBA $00C2
        moveq   #$01,d0                         ; $00271A: $7001 — buffer 1 select
        moveq   #$00,d2                         ; $00271C: $7400 — buffer 0 select
        btst    #0,($FFFFC80C).w               ; $00271E: $0838 $0000 $C80C — check frame toggle
        beq.s   .write_fb                       ; $002724: $6604 — toggle clear → D0=1 first
        moveq   #$00,d0                         ; $002726: $7000 — swap: buffer 0 first
        moveq   #$01,d2                         ; $002728: $7201 — buffer 1 second
.write_fb:
        move.b  d0,$008B(a4)                   ; $00272A: $1940 $008B — select first framebuffer
        bsr.s   vdp_fill_framebuffer+6          ; $00272E: call sub 1 (entry at +6)
        bsr.s   vdp_fill_line_table_flat+8      ; $002730: call sub 2 (entry at +8)
        jsr     gfx_32x_framebuffer_palette_fill(pc); $4EBA $00A6
        move.b  d2,$008B(a4)                   ; $002736: $1942 $008B — select second framebuffer
        rts                                     ; $00273A: $4E75
