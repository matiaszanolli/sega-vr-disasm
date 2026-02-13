; ============================================================================
; Speed Scale Conditional
; ROM Range: $00B03C-$00B068 (44 bytes)
; ============================================================================
; Conditionally scales two speed values based on flag bits:
;   If bit 5 of ($C30E).W clear: scale ($907E).W → $FF6328
;   If bit 5 of ($B4EE).W clear: scale ($9F7E).W → $FF6558
;
; Uses: D0, D1
; RAM:
;   ($C30E).W: Flag byte 1 (bit 5 checked)
;   ($B4EE).W: Flag byte 2 (bit 5 checked)
;   ($907E).W: First input value
;   ($9F7E).W: Second input value
;   $FF6328: First output (scaled)
;   $FF6558: Second output (scaled)
; Calls: speed_scale_calc (via BSR.S)
; ============================================================================

speed_scale_conditional:
        dc.w    $0838,$0005,$C30E       ; BTST #5,($C30E).W - check flag 1
        bne.s   .check_second           ; If set, skip first scale
        moveq   #0,d0                   ; Clear D0
        dc.w    $3038,$907E             ; MOVE.W ($907E).W,D0 - load first value
        bsr.s   speed_scale_calc        ; Scale it
        move.w  d0,$00FF6328            ; Store first result
.check_second:
        dc.w    $0838,$0005,$B4EE       ; BTST #5,($B4EE).W - check flag 2
        bne.s   .return                 ; If set, skip second scale
        moveq   #0,d0                   ; Clear D0
        dc.w    $3038,$9F7E             ; MOVE.W ($9F7E).W,D0 - load second value
        bsr.s   speed_scale_calc        ; Scale it
        move.w  d0,$00FF6558            ; Store second result
.return:
        rts
