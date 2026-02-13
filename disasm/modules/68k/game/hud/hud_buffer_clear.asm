; ============================================================================
; HUD Buffer Clear
; ROM Range: $00C028-$00C05A (50 bytes)
; ============================================================================
; Clears HUD display buffer entries:
;   - Zeroes first byte at $FF6800, $FF6810, $FF6820
;   - Clears 6 word entries at $FF6900 with $14 stride
;
; Uses: D0, D1, A1
; RAM:
;   $FF6800: HUD entry 0 (byte cleared)
;   $FF6810: HUD entry 1 (byte cleared)
;   $FF6820: HUD entry 2 (byte cleared)
;   $FF6900: HUD table (6 words at stride $14, cleared)
; ============================================================================

hud_buffer_clear:
        moveq   #0,d0                   ; Clear value
        lea     $00FF6800,a1            ; HUD entry 0
        move.b  d0,$0(a1)               ; Clear first byte
        lea     $00FF6810,a1            ; HUD entry 1
        move.b  d0,$0(a1)               ; Clear first byte
        lea     $00FF6820,a1            ; HUD entry 2
        move.b  d0,$0(a1)               ; Clear first byte
        lea     $00FF6900,a1            ; HUD table base
        moveq   #5,d1                   ; 6 entries (0-5)
.loop:
        clr.w   (a1)                    ; Clear word
        lea     $14(a1),a1              ; Advance to next entry (stride $14)
        dbf     d1,.loop                ; Loop 6 times
        rts
