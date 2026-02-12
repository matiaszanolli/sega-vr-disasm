; ============================================================================
; AI Parameter Lookup + Threshold Check (Data Prefix, Variant B)
; ROM Range: $00B398-$00B3CE (54 bytes)
; ============================================================================
; Category: game
; Purpose: 36-byte data table of 18 parameter words indexed by race_state,
;   followed by lookup code: adds race_state ($C8A0) to entry D0,
;   fetches parameter from table, compares byte at (A1) with $60,
;   branches backward to $00B304 if less. D0 returns table value.
;   Same structure as fn_a200_011 but larger table (18 vs 12 entries).
;
; Entry: D0 = base index (word offset), A1 = object pointer
; Uses: D0, A0, A1
; RAM:
;   $C8A0: race_state (word)
; ============================================================================

fn_a200_012:
; --- data: 18 parameter words (indexed by race_state + entry D0) ---
        dc.w    $00A0,$00D0                     ; $00B398  160, 208
        dc.w    $00C0,$0110                     ; $00B39C  192, 272
        dc.w    $0090,$0090                     ; $00B3A0  144, 144
        dc.w    $0080,$00A0                     ; $00B3A4  128, 160
        dc.w    $0100,$0080                     ; $00B3A8  256, 128
        dc.w    $0080,$0080                     ; $00B3AC  128, 128
        dc.w    $00D0,$00E0                     ; $00B3B0  208, 224
        dc.w    $00D0,$0100                     ; $00B3B4  208, 256
        dc.w    $0100,$0100                     ; $00B3B8  256, 256
; --- code: lookup + threshold check ---
        add.w   ($FFFFC8A0).w,D0               ; $00B3BC  D0 += race_state
        move.w  fn_a200_012(PC,D0.W),D0        ; $00B3C0  D0 = table[D0]
        cmpi.b  #$60,(A1)                       ; $00B3C4  *A1 < 96?
        dc.w    $6D00,$FF3A                     ; $00B3C8  blt.w $00B304 — yes → branch back
        rts                                     ; $00B3CC
