; ============================================================================
; SH2 Scene Reset — Name Entry Mode Dispatcher
; ROM Range: $0117F4-$011862 (110 bytes)
; ============================================================================
; Resets SH2 communication and selects a scene handler based on game
; mode flags. Three possible scene handlers:
;   1. $00884A3E — if no track selected ($A019==0) and $A042==0
;   2. $0088C0F0 — if VDP flag ($FEB7) bit 7 is set
;   3. $0088D48A — default fallback
; Also manages sync flags at $C80E and debug flags at $C81C.
;
; Memory:
;   $FFFFC87E = main game state (word, cleared to 0)
;   $FFFFA019 = player 1 selection / track index (byte, tested)
;   $FFFFA042 = game mode parameter (word, tested)
;   $FFFFC80E = sync/transition flags (byte, bits 3/7 modified)
;   $FFFFC81C = debug/mode flags (byte, bit 7 modified)
;   $FFFFFEB7 = VDP/display flag (byte, bit 7 tested)
;   $00FF0002 = SH2 scene handler pointer (long, set)
;   $00FF0008 = display mode / frame delay (word, set to $0020)
; Entry: none | Exit: SH2 scene configured | Uses: none
; ============================================================================

fn_10200_003:
.wait_sh2:
        tst.b   COMM0_HI                        ; $0117F4: $4A38 $5120 — wait for SH2 idle
        bne.s   .wait_sh2                       ; $0117FA: $66F8
        clr.b   COMM1_LO                        ; $0117FC: $4238 $5123 — clear COMM1
        move.w  #$0000,($FFFFC87E).w           ; $011802: $31FC $0000 $C87E — reset game state
        move.w  #$0020,$00FF0008                ; $011808: $33FC $0020 $00FF $0008 — display mode
        tst.b   ($FFFFA019).w                   ; $011810: $4A38 $A019 — track selected?
        bne.s   .has_selection                   ; $011814: $6618 — yes → check further
        tst.w   ($FFFFA042).w                   ; $011816: $4A78 $A042 — mode parameter set?
        bne.s   .has_selection                   ; $01181A: $6612 — yes → check further
        bset    #3,($FFFFC80E).w               ; $01181C: $08F8 $0003 $C80E — set sync bit 3
        move.l  #$00884A3E,$00FF0002            ; $011822: $23FC $0088 $4A3E $00FF $0002 — handler: no selection
        bra.w   .done                           ; $01182C: $6000 $0032
.has_selection:
        bclr    #3,($FFFFC80E).w               ; $011830: $08B8 $0003 $C80E — clear sync bit 3
        bclr    #7,($FFFFC81C).w               ; $011836: $08B8 $0007 $C81C — clear debug flag
        btst    #7,($FFFFFEB7).w               ; $01183C: $0838 $0007 $FEB7 — VDP flag set?
        beq.s   .default_handler                ; $011842: $6612 — no → use default
        bset    #7,($FFFFC81C).w               ; $011844: $08F8 $0007 $C81C — set debug flag
        move.l  #$0088C0F0,$00FF0002            ; $01184A: $23FC $0088 $C0F0 $00FF $0002 — handler: VDP mode
        bra.s   .done                           ; $011854: $6008
.default_handler:
        move.l  #$0088D48A,$00FF0002            ; $011856: $23FC $0088 $D48A $00FF $0002 — handler: default
.done:
        rts                                     ; $011860: $4E75
