; ============================================================================
; State Handler Table + Init
; ROM Range: $008B28-$008B9C (116 bytes)
; ============================================================================
; 13-entry jump table for state handlers, followed by two 16-byte
; parameter blocks (data), then initialization code that clears
; camera/waypoint state and sets steering mode flags.
;
; Uses: D0, D2, D5, D6, D7, A0, A2, A3
; RAM:
;   $C0BA: waypoint_angle (cleared)
;   $C0C6: camera_offset (cleared)
;   $C313: steering_flags (bit 1 set, bit 3 cleared)
;   $C896: ai_timer (cleared)
; ============================================================================

fn_8200_022:
; --- jump table: 13 state handler entries ---
        dc.l    $00888D62                        ; state 0
        dc.l    $00888EB6                        ; state 1
        dc.l    $00888ED6                        ; state 2
        dc.l    $00888EF2                        ; state 3
        dc.l    $00888EF4                        ; state 4
        dc.l    $00888EFC                        ; state 5
        dc.l    $00888C40                        ; state 6
        dc.l    $00888CCE                        ; state 7
        dc.l    $00888B9C                        ; state 8
        dc.l    $00888DC0                        ; state 9
        dc.l    $00888BC2                        ; state 10
        dc.l    $00888BF2                        ; state 11
        dc.l    $00888C16                        ; state 12
; --- parameter block A (16 bytes) ---
        dc.w    $FA30,$5800,$1D58,$0000
        dc.w    $0000,$0000,$0000,$0024
; --- parameter block B (16 bytes) ---
        dc.w    $ED68,$4400,$1E93,$0000
        dc.w    $0000,$0000,$0100,$0024
; --- initialization code ---
        move.w  #$0000,($FFFFC0C6).w            ; clear camera_offset
        move.w  #$0000,($FFFFC0BA).w            ; clear waypoint_angle
        bset    #1,($FFFFC313).w                ; set steering flag bit 1
        bclr    #3,($FFFFC313).w                ; clear steering flag bit 3
        move.b  #$00,($FFFFC896).w              ; clear ai_timer
        rts
