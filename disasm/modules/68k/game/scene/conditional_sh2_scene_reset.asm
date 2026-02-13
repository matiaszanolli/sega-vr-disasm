; ============================================================================
; Conditional SH2 Scene Reset
; ROM Range: $014540-$014566 (38 bytes)
; ============================================================================
; Tests player data word ($A008). If non-zero, returns immediately.
; Otherwise resets: sets display mode $0020, clears timeline counter
; ($C080), sets SH2 scene handler to $008853B0, and jumps to
; SH2 comm init at $00882890.
;
; Memory:
;   $FFFFA008 = player data word (tested, non-zero → early return)
;   $00FF0008 = SH2 display mode/frame delay (word, set to $0020)
;   $FFFFC080 = timeline counter (byte, cleared)
;   $00FF0002 = SH2 scene handler pointer (long, set to $008853B0)
; Entry: none | Exit: scene reset or early return | Uses: none
; ============================================================================

conditional_sh2_scene_reset:
        tst.w   ($FFFFA008).w                   ; $014540: $4A78 $A008 — test player data
        bne.s   .done                           ; $014544: $661E — non-zero → return
        move.w  #$0020,$00FF0008                ; $014546: $33FC $0020 $00FF $0008 — display mode $20
        move.b  #$00,($FFFFC080).w              ; $01454E: $11FC $0000 $C080 — clear timeline counter
        move.l  #$008853B0,$00FF0002            ; $014554: $23FC $0088 $53B0 $00FF $0002 — SH2 handler
        jmp     $00882890                       ; $01455E: $4EF9 $0088 $2890 — jump to SH2 comm init
.done:
        rts                                     ; $014564: $4E75

