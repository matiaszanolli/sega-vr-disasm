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
        btst    #5,($FFFFC30E).w        ; $0838 $0005 $C30E — check flag 1
        bne.s   .check_second           ; If set, skip first scale
        moveq   #0,d0                   ; Clear D0
        move.w  ($FFFF907E).w,d0        ; $3038 $907E — load first value
        bsr.s   speed_scale_calc        ; Scale it
        move.w  d0,$00FF6328            ; Store first result
.check_second:
        btst    #5,($FFFFB4EE).w        ; $0838 $0005 $B4EE — check flag 2
        bne.s   .return                 ; If set, skip second scale
        moveq   #0,d0                   ; Clear D0
        move.w  ($FFFF9F7E).w,d0        ; $3038 $9F7E — load second value
        bsr.s   speed_scale_calc        ; Scale it
        move.w  d0,$00FF6558            ; Store second result
.return:
        rts
