; ============================================================================
; AI Parameter Lookup + Threshold Check (Data Prefix)
; ROM Range: $00B36E-$00B398 (42 bytes)
; ============================================================================
; Category: game
; Purpose: 24-byte data table of 12 parameter words indexed by race_state,
;   followed by lookup code: adds race_state ($C8A0) to entry D0,
;   fetches parameter from table, compares byte at (A1) with $60,
;   branches backward to $00B304 if less. D0 returns table value.
;
; Entry: D0 = base index (word offset), A1 = object pointer
; Uses: D0, A0, A1
; RAM:
;   $C8A0: race_state (word)
; ============================================================================

fn_a200_011:
; --- data: 12 parameter words (indexed by race_state + entry D0) ---
        dc.w    $00D0                           ; $00B36E  208
        dc.w    $00C0                           ; $00B370  192
        dc.w    $0090,$0090                     ; $00B372  144, 144
        dc.w    $00A0                           ; $00B376  160
        dc.w    $0100                           ; $00B378  256
        dc.w    $0080,$0080                     ; $00B37A  128, 128
        dc.w    $00E0                           ; $00B37E  224
        dc.w    $00D0                           ; $00B380  208
        dc.w    $0100,$0100                     ; $00B382  256, 256
; --- code: lookup + threshold check ---
        add.w   ($FFFFC8A0).w,D0               ; $00B386  D0 += race_state
        move.w  fn_a200_011(PC,D0.W),D0        ; $00B38A  D0 = table[D0]
        cmpi.b  #$60,(A1)                       ; $00B38E  *A1 < 96?
        dc.w    $6D00,$FF70                     ; $00B392  blt.w $00B304 — yes → branch back
        rts                                     ; $00B396
