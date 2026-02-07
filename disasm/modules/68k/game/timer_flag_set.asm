; ============================================================================
; Timer Wait and Set Transition Flags
; ROM Range: $004390-$0043BC (44 bytes)
; ============================================================================
; After 40-frame wait, advances state and sets control flags
; (C809, C80A, C80E bit 7, C802) to signal transition readiness.
;
; Entry: none
; Uses: none
; ============================================================================

timer_flag_set:
        dc.w    $0C78,$0028,$C8AA     ; CMPI.W #$0028,($C8AA).W
        bne.s   .done                 ; If not 40 frames, skip
        dc.w    $5878,$C07C           ; ADDQ.W #4,($C07C).W
        dc.w    $31FC,$0000,$C8AA     ; MOVE.W #$0000,($C8AA).W
        dc.w    $11FC,$0001,$C809     ; MOVE.B #$01,($C809).W
        dc.w    $11FC,$0001,$C80A     ; MOVE.B #$01,($C80A).W
        dc.w    $08F8,$0007,$C80E     ; BSET #7,($C80E).W
        dc.w    $11FC,$0001,$C802     ; MOVE.B #$01,($C802).W
.done:
        rts
