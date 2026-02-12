; ============================================================================
; SH2 Scene Reset — Set Handler $8926D2
; ROM Range: $01250C-$012534 (40 bytes)
; ============================================================================
; Waits for SH2 idle (COMM0 clear), then resets game state and configures
; a new SH2 scene handler at $008926D2 with display mode $0020.
;
; Memory:
;   $FFFFC87E = main game state (word, cleared to 0)
;   $00FF0002 = SH2 scene handler pointer (long, set)
;   $00FF0008 = display mode / frame delay (word, set to $0020)
; Entry: none | Exit: SH2 reconfigured | Uses: none
; ============================================================================

fn_12200_001:
.wait_sh2:
        tst.b   COMM0_HI                        ; $01250C: $4A38 $5120 — wait for SH2 idle
        bne.s   .wait_sh2                        ; $012512: $66F6
        clr.b   COMM1_LO                        ; $012514: $4238 $5123 — clear COMM1
        move.w  #$0000,($FFFFC87E).w            ; $01251A: $31FC $0000 $C87E — reset game state
        move.w  #$0020,$00FF0008                ; $012520: $33FC $0020 $00FF $0008 — display mode
        move.l  #$008926D2,$00FF0002            ; $012528: $23FC $0089 $26D2 $00FF $0002 — scene handler
        rts                                     ; $012532: $4E75
