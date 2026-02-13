; ============================================================================
; MARS Adapter State Init + Framebuffer Setup
; ROM Range: $002680-$00270A (138 bytes)
; ============================================================================
; Two entry points for MARS framebuffer initialization. Both select
; framebuffer 0, call three sub-routines, switch to framebuffer 1,
; call the same three subs again, then reset to framebuffer 0 and
; clear the frame toggle flag.
;
; Data prefix at $002680-$00268B (12 bytes, referenced by nearby code).
; Entry 1 ($00268C): adapter_state_init — uses $0027BE variant, JMP $002782
; Entry 2 ($0026C8): alternate init — uses $0027A0 variant, writes CRAM
;
; Memory:
;   $FFFFC80C = frame buffer toggle flag (byte, cleared to 0)
;   MARS_SYS_BASE+$8B = MARS FB control register (byte, selects buffer)
;   $00A15202 = MARS CRAM entry 1 (word, set to $8000 = priority black)
; Entry: none | Exit: framebuffers initialized
; Uses: D0, A4
; ============================================================================

mars_adapter_state_init_framebuffer_setup:
; --- Data prefix (12 bytes) ---
        dc.w    $8000                           ; $002680: data
        dc.w    $0000,$0000                     ; $002682: data
        dc.w    $0000,$0000                     ; $002686: data
        dc.w    $0000                           ; $00268A: data
; --- Entry 1: adapter_state_init ---
        lea     MARS_SYS_BASE,a4               ; $00268C: $49F9 $00A1 $5100 — MARS register base
        bclr    #0,$008B(a4)                   ; $002692: — select framebuffer 0
        dc.w    $4EBA,$00A8                     ; JSR $002742(PC) ; $002698: — call sub 1
        dc.w    $4EBA,$0120                     ; JSR $0027BE(PC) ; $00269C: — call sub 2a
        dc.w    $4EBA,$017C                     ; JSR $00281E(PC) ; $0026A0: — call VDPPrep
        bset    #0,$008B(a4)                   ; $0026A4: — select framebuffer 1
        dc.w    $4EBA,$0096                     ; JSR $002742(PC) ; $0026AA: — call sub 1
        dc.w    $4EBA,$010E                     ; JSR $0027BE(PC) ; $0026AE: — call sub 2a
        dc.w    $4EBA,$016A                     ; JSR $00281E(PC) ; $0026B2: — call VDPPrep
        bclr    #0,$008B(a4)                   ; $0026B6: — back to framebuffer 0
        move.b  #$00,($FFFFC80C).w             ; $0026BC: $11FC $0000 $C80C — clear frame toggle
        moveq   #$00,d0                         ; $0026C2: $7000 — clear D0
        dc.w    $4EFA,$00BC                     ; JMP $002782(PC) ; $0026C4: — tail-call palette init
; --- Entry 2: alternate framebuffer init ---
        lea     MARS_SYS_BASE,a4               ; $0026C8: $49F9 $00A1 $5100 — MARS register base
        bclr    #0,$008B(a4)                   ; $0026CE: — select framebuffer 0
        dc.w    $616C                           ; BSR.S $002742 ; $0026D4: — call sub 1
        dc.w    $4EBA,$00C8                     ; JSR $0027A0(PC) ; $0026D6: — call sub 2b
        dc.w    $4EBA,$0142                     ; JSR $00281E(PC) ; $0026DA: — call VDPPrep
        bset    #0,$008B(a4)                   ; $0026DE: — select framebuffer 1
        dc.w    $615C                           ; BSR.S $002742 ; $0026E4: — call sub 1
        dc.w    $4EBA,$00B8                     ; JSR $0027A0(PC) ; $0026E6: — call sub 2b
        dc.w    $4EBA,$0132                     ; JSR $00281E(PC) ; $0026EA: — call VDPPrep
        bclr    #0,$008B(a4)                   ; $0026EE: — back to framebuffer 0
        move.b  #$00,($FFFFC80C).w             ; $0026F4: $11FC $0000 $C80C — clear frame toggle
        moveq   #$00,d0                         ; $0026FA: $7000 — clear D0
        dc.w    $4EBA,$0084                     ; JSR $002782(PC) ; $0026FC: — call palette init
        move.w  #$8000,$00A15202                ; $002700: — set CRAM entry 1 = priority black
        rts                                     ; $002708: $4E75
