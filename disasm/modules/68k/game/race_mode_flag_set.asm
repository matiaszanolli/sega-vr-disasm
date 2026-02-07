; ============================================================================
; Race Mode Flag Set
; ROM Range: $00ACC0-$00ACD2 (18 bytes)
; ============================================================================
; Sets flag at $FF6970 based on bit 2 of ($C8AB).W:
;   If bit 2 set: flag = 0
;   If bit 2 clear: flag = 1
;
; Uses: D0
; RAM:
;   ($C8AB).W: Mode control bits
;   $FF6970: Race mode flag (output)
; ============================================================================

race_mode_flag_set:
        moveq   #0,d0                   ; Default: flag = 0
        dc.w    $0838,$0002,$C8AB       ; BTST #2,($C8AB).W - check mode bit
        bne.s   .store                  ; If bit 2 set, keep 0
        moveq   #1,d0                   ; Bit 2 clear: flag = 1
.store:
        move.b  d0,$00FF6970            ; Store race mode flag
        rts
