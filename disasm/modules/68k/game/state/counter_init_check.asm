; ============================================================================
; Counter Init Check
; ROM Range: $00BDC8-$00BDD4 (12 bytes)
; ============================================================================
; Initializes counter ($A0F0).W to 1 if currently zero.
;
; Uses: (none modified)
; RAM:
;   ($A0F0).W: Counter (set to 1 if zero)
; ============================================================================

counter_init_check:
        dc.w    $4A78,$A0F0             ; TST.W ($A0F0).W - check counter
        bne.s   .return                 ; If non-zero, skip
        dc.w    $31FC,$0001,$A0F0       ; MOVE.W #$0001,($A0F0).W - init to 1
.return:
        rts
