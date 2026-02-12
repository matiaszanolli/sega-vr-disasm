; ============================================================================
; SH2 Scene Reset — Set Handler $88D4A4
; ROM Range: $011862-$01188A (40 bytes)
; ============================================================================
; Waits for SH2 idle (COMM0 clear), then resets game state and configures
; a new SH2 scene handler at $0088D4A4 with display mode $0020.
;
; Memory:
;   $FFFFC87E = main game state (word, cleared to 0)
;   $00FF0002 = SH2 scene handler pointer (long, set)
;   $00FF0008 = display mode / frame delay (word, set to $0020)
; Entry: none | Exit: SH2 reconfigured | Uses: none
; ============================================================================

fn_10200_004:
.wait_sh2:
        tst.b   COMM0_HI                        ; $011862: $4A38 $5120 — wait for SH2 idle
        bne.s   .wait_sh2                        ; $011868: $66F6
        clr.b   COMM1_LO                        ; $01186A: $4238 $5123 — clear COMM1
        move.w  #$0000,($FFFFC87E).w            ; $011870: $31FC $0000 $C87E — reset game state
        move.w  #$0020,$00FF0008                ; $011876: $33FC $0020 $00FF $0008 — display mode
        move.l  #$0088D4A4,$00FF0002            ; $01187E: $23FC $0088 $D4A4 $00FF $0002 — scene handler
        rts                                     ; $011888: $4E75
