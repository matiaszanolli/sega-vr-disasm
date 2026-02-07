; ============================================================================
; Timer Threshold Init (Sprite Setup)
; ROM Range: $0042BA-$004300 (70 bytes)
; ============================================================================
; Waits for frame counter > 20, then initializes a sprite at $FF6754
; with position/attribute data, sets sound effect $95, advances state.
;
; Entry: none
; Uses: A2
; ============================================================================

timer_threshold_init:
        dc.w    $0C78,$0014,$C8AA     ; CMPI.W #$0014,($C8AA).W
        ble.s   .done                 ; If <= 20, skip
        dc.w    $11FC,$0095,$C8A5     ; MOVE.B #$95,($C8A5).W - sound effect
        dc.w    $31FC,$0000,$C084     ; MOVE.W #$0000,($C084).W - clear fade
        dc.w    $5878,$C07C           ; ADDQ.W #4,($C07C).W - advance state
        dc.w    $31FC,$0000,$C8AA     ; MOVE.W #$0000,($C8AA).W - reset timer
        lea     $00FF6754,a2          ; Sprite structure address
        move.w  #$FFE0,$0004(a2)      ; Set Y position = -32
        move.w  #$0040,$0006(a2)      ; Set X position = 64
        move.w  #$F600,$0008(a2)      ; Set sprite attribute
        move.l  #$22295ADE,$0010(a2)  ; Set tile data pointer
        move.w  #$0001,$0000(a2)      ; Enable sprite (flag=1)
.done:
        rts
