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
        cmpi.w  #$0014,($FFFFC8AA).w    ; $0C78 $0014 $C8AA
        ble.s   .done                 ; If <= 20, skip
        move.b  #$95,($FFFFC8A5).w      ; $11FC $0095 $C8A5 — sound effect
        move.w  #$0000,($FFFFC084).w    ; $31FC $0000 $C084 — clear fade
        addq.w  #4,($FFFFC07C).w        ; $5878 $C07C — advance state
        move.w  #$0000,($FFFFC8AA).w    ; $31FC $0000 $C8AA — reset timer
        lea     $00FF6754,a2          ; Sprite structure address
        move.w  #$FFE0,$0004(a2)      ; Set Y position = -32
        move.w  #$0040,$0006(a2)      ; Set X position = 64
        move.w  #$F600,$0008(a2)      ; Set sprite attribute
        move.l  #$22295ADE,$0010(a2)  ; Set tile data pointer
        move.w  #$0001,$0000(a2)      ; Enable sprite (flag=1)
.done:
        rts
