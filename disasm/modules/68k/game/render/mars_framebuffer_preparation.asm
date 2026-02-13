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
        dc.w    $6130                           ; BSR.S $002742 ; $002710: — call sub 1
        dc.w    $4EBA,$008C                     ; JSR $0027A0(PC) ; $002712: — call sub 2
        dc.w    $4EBA,$00C2                     ; JSR $0027DA(PC) ; $002716: — call sh2_framebuffer_prep
        moveq   #$01,d0                         ; $00271A: $7001 — buffer 1 select
        moveq   #$00,d2                         ; $00271C: $7400 — buffer 0 select
        btst    #0,($FFFFC80C).w               ; $00271E: $0838 $0000 $C80C — check frame toggle
        beq.s   .write_fb                       ; $002724: $6604 — toggle clear → D0=1 first
        moveq   #$00,d0                         ; $002726: $7000 — swap: buffer 0 first
        moveq   #$01,d2                         ; $002728: $7201 — buffer 1 second
.write_fb:
        move.b  d0,$008B(a4)                   ; $00272A: $1940 $008B — select first framebuffer
        dc.w    $6112                           ; BSR.S $002742 ; $00272E: — call sub 1
        dc.w    $616E                           ; BSR.S $0027A0 ; $002730: — call sub 2
        dc.w    $4EBA,$00A6                     ; JSR $0027DA(PC) ; $002732: — call sh2_framebuffer_prep
        move.b  d2,$008B(a4)                   ; $002736: $1942 $008B — select second framebuffer
        rts                                     ; $00273A: $4E75
