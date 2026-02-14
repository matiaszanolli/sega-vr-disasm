; ============================================================================
; Palette Fade 003
; ROM Range: $01457C-$0145F0 (116 bytes)
; ============================================================================
; Category: game
; Purpose: Applies brightness fade to 256-entry CRAM palette
;   Scales R/G/B channels (5-bit each in $7C00/$03E0/$001F format)
;   Decrements fade counter; clears when done
;
; Uses: D0, D1, D2, D3, D4, D5, A1
; RAM:
;   $A008: fade_counter (byte: intensity 0-8; word: nonzero = active)
;   $A009: fade_mode
;   $A100: cram_shadow (256 words)
; Confidence: high
; ============================================================================

palette_fade_003:
        nop                                     ; $01457C
        nop                                     ; $01457E
        nop                                     ; $014580
        tst.w   ($FFFFA008).w                   ; $014582  fade active?
        beq.w   .done                           ; $014586  no → done
        lea     ($FFFFA100).w,A1                ; $01458A  A1 → CRAM shadow buffer
        moveq   #$00,D2                         ; $01458E  D2 = 0
        move.b  ($FFFFA008).w,D2                ; $014590  D2 = fade_counter
        cmpi.b  #$02,($FFFFA009).w              ; $014594  fade_mode == 2?
        beq.s   .start_loop                     ; $01459A  yes → use counter directly
        move.w  #$0008,D2                       ; $01459C  D2 = 8
        sub.b   ($FFFFA008).w,D2                ; $0145A0  D2 = 8 - counter (invert)
.start_loop:
        move.w  #$00FF,D1                       ; $0145A4  D1 = 255 (loop 256 entries)
.loop:
        move.w  (A1),D0                         ; $0145A8  D0 = CRAM entry
; --- scale blue channel (bits 4-0) ---
        move.w  D0,D3                           ; $0145AA  D3 = D0
        andi.w  #$001F,D3                       ; $0145AC  isolate blue (5 bits)
        mulu    D2,D3                           ; $0145B0  D3 *= fade level
        lsr.w   #3,D3                           ; $0145B2  D3 >>= 3
        andi.w  #$001F,D3                       ; $0145B4  clamp to 5 bits
; --- scale green channel (bits 9-5) ---
        move.w  D0,D4                           ; $0145B8  D4 = D0
        andi.w  #$03E0,D4                       ; $0145BA  isolate green
        mulu    D2,D4                           ; $0145BE  D4 *= fade level
        lsr.w   #3,D4                           ; $0145C0  D4 >>= 3
        andi.w  #$03E0,D4                       ; $0145C2  clamp to green range
; --- scale red channel (bits 14-10) ---
        move.w  D0,D5                           ; $0145C6  D5 = D0
        andi.w  #$7C00,D5                       ; $0145C8  isolate red
        mulu    D2,D5                           ; $0145CC  D5 *= fade level
        lsr.l   #3,D5                           ; $0145CE  D5 >>= 3 (long for overflow)
        andi.w  #$7C00,D5                       ; $0145D0  clamp to red range
; --- combine channels ---
        or.w    d4,d3                   ; $8644
        or.w    d5,d3                   ; $8645
        move.w  D3,(A1)+                        ; $0145D8  store faded color, advance
        dbra    D1,.loop                        ; $0145DA  loop 256 entries
; --- decrement fade counter ---
        subq.b  #1,($FFFFA008).w                ; $0145DE  fade_counter--
        bne.s   .done                           ; $0145E2  not zero → continue next frame
        clr.w   ($FFFFA008).w                   ; $0145E4  clear fade (word = inactive)
.done:
        nop                                     ; $0145E8
        nop                                     ; $0145EA
        nop                                     ; $0145EC
        rts                                     ; $0145EE
