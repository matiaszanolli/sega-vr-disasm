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
        addq.w  #8,($FFFFC25C).w        ; $5078 $C25C — scroll counter
        move.w  ($FFFFC25C).w,d0        ; $3038 $C25C
        move.w  d0,$0006(a2)          ; Update sprite X from scroll
        addq.w  #2,$0004(a2)          ; Increment sprite Y by 2
        addi.w  #$01C0,$0008(a2)      ; Add $1C0 to sprite attribute
        cmpi.w  #$0100,d0             ; Check if scroll reached $100
        bne.s   .done                 ; If not, skip
        addq.w  #4,($FFFFC07C).w        ; $5878 $C07C — advance state
        move.w  #$0000,($FFFFC8AA).w    ; $31FC $0000 $C8AA — reset timer
.done:
        rts
