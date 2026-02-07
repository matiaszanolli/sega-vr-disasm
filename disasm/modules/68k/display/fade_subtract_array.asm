; ============================================================================
; Fade Subtract Array (Palette Fade-Out)
; ROM Range: $00434A-$004384 (58 bytes)
; ============================================================================
; Performs palette fade-out by subtracting 30 from 8 palette entries
; (spaced 16 bytes apart at $FF6802). Up to 10 steps.
; When done (step > 10), branches to advance_clear_timer (next function).
;
; Entry: none
; Uses: D0, A2
; ============================================================================

fade_subtract_array:
        dc.w    $3038,$C084           ; MOVE.W ($C084).W,D0 - fade step
        cmpi.w  #$000A,d0             ; Check if > 10 steps
        bgt.s   advance_clear_timer   ; If done, advance state (next func)
        addq.w  #1,d0                 ; Increment step
        dc.w    $31C0,$C084           ; MOVE.W D0,($C084).W
        moveq   #$1E,d0              ; Subtract value = 30
        lea     $00FF6802,a2          ; Palette entry base
        sub.w   d0,$0000(a2)          ; Entry 0
        sub.w   d0,$0010(a2)          ; Entry 1
        sub.w   d0,$0020(a2)          ; Entry 2
        sub.w   d0,$0030(a2)          ; Entry 3
        sub.w   d0,$0040(a2)          ; Entry 4
        sub.w   d0,$0050(a2)          ; Entry 5
        sub.w   d0,$0060(a2)          ; Entry 6
        sub.w   d0,$0070(a2)          ; Entry 7
        rts
