; ============================================================================
; SH2 Scene Reset — Conditional Handler by Player 2 Flag
; ROM Range: $013824-$013864 (64 bytes)
; ============================================================================
; Waits for SH2 idle, copies the player 2 active flag ($A01A) to a
; local variable ($FDB9), then selects the SH2 scene handler based
; on whether the player 1 data pointer high byte ($A018) is set.
; Default handler: $00893864; override if $A018 == 0: $008926D2.
;
; Memory:
;   $FFFFA01A = player 2 active flag (word, read)
;   $FFFFFDA9 = P2 flag backup (byte, written)
;   $FFFFA018 = player 1 data pointer high byte (byte, tested)
;   $FFFFC87E = main game state (word, cleared to 0)
;   $00FF0002 = SH2 scene handler pointer (long, set)
;   $00FF0008 = display mode / frame delay (word, set to $0020)
; Entry: none | Exit: SH2 scene configured | Uses: D0
; ============================================================================

fn_12200_012:
.wait_sh2:
        tst.b   COMM0_HI                        ; $013824: $4A38 $5120 — wait for SH2 idle
        bne.s   .wait_sh2                       ; $01382A: $66F8
        clr.b   COMM1_LO                        ; $01382C: $4238 $5123 — clear COMM1
        move.w  ($FFFFA01A).w,d0               ; $013832: $3038 $A01A — load P2 active flag
        move.b  d0,($FFFFFDA9).w               ; $013836: $11C0 $FDA9 — save P2 flag
        move.l  #$00893864,$00FF0002            ; $01383A: $23FC $0089 $3864 $00FF $0002 — default handler
        tst.b   ($FFFFA018).w                   ; $013844: $4A38 $A018 — P1 pointer set?
        bne.s   .set_mode                       ; $013848: $660A — yes → keep default
        move.l  #$008926D2,$00FF0002            ; $01384A: $23FC $0089 $26D2 $00FF $0002 — override handler
.set_mode:
        move.w  #$0000,($FFFFC87E).w           ; $013854: $31FC $0000 $C87E — reset game state
        move.w  #$0020,$00FF0008                ; $01385A: $33FC $0020 $00FF $0008 — display mode
        rts                                     ; $013862: $4E75
