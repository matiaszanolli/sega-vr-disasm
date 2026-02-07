; ============================================================================
; Scroll Update Animation
; ROM Range: $004300-$00432E (46 bytes)
; ============================================================================
; Updates scroll animation on sprite at $FF6754. Increments scroll counter,
; updates sprite position/attributes, advances state when scroll reaches $100.
;
; Entry: none
; Uses: D0, A2
; ============================================================================

scroll_update:
        lea     $00FF6754,a2          ; Sprite structure
        dc.w    $5078,$C25C           ; ADDQ.W #8,($C25C).W - scroll counter
        dc.w    $3038,$C25C           ; MOVE.W ($C25C).W,D0
        move.w  d0,$0006(a2)          ; Update sprite X from scroll
        addq.w  #2,$0004(a2)          ; Increment sprite Y by 2
        addi.w  #$01C0,$0008(a2)      ; Add $1C0 to sprite attribute
        cmpi.w  #$0100,d0             ; Check if scroll reached $100
        bne.s   .done                 ; If not, skip
        dc.w    $5878,$C07C           ; ADDQ.W #4,($C07C).W - advance state
        dc.w    $31FC,$0000,$C8AA     ; MOVE.W #$0000,($C8AA).W - reset timer
.done:
        rts
