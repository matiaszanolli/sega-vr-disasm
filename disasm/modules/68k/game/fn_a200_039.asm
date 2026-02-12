; ============================================================================
; AI Object Setup + Conditional Flag Set
; ROM Range: $00BDD6-$00BDFE (40 bytes)
; ============================================================================
; Tests AI data word ($A0F0). If zero, returns. Otherwise sets up
; SH2 object at $FF6860 (command $0B at +$00, $0C at +$10).
; If $A0F0 >= 12, sets $FF60C8 to $FFFF and returns.
; If < 12, falls through to next function.
;
; Memory:
;   $FFFFA0F0 = AI data word (tested)
;   $00FF6860 = SH2 object base (byte at +$00 set to $0B, +$10 set to $0C)
;   $00FF60C8 = SH2 flag (word, conditionally set to $FFFF)
; Entry: none | Exit: object setup or fall-through | Uses: D1, A1
; ============================================================================

fn_a200_039:
        move.w  ($FFFFA0F0).w,d1                ; $00BDD6: $3238 $A0F0 — load AI data
        beq.s   .done                           ; $00BDDA: $6720 — zero → return
        lea     $00FF6860,a1                    ; $00BDDC: $43F9 $00FF $6860 — SH2 object base
        move.b  #$0B,$0000(a1)                  ; $00BDE2: $137C $000B $0000 — command $0B
        move.b  #$0C,$0010(a1)                  ; $00BDE8: $137C $000C $0010 — command $0C
        cmpi.w  #$000C,d1                       ; $00BDEE: $0C41 $000C — >= 12?
        dc.w    $6D0A                           ; BLT.S fn_a200_039_end ; $00BDF2: — < 12 → fall through
        move.w  #$FFFF,$00FF60C8                ; $00BDF4: $33FC $FFFF $00FF $60C8 — set SH2 flag
.done:
        rts                                     ; $00BDFC: $4E75

