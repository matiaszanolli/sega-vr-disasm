; ============================================================================
; Camera State Selector
; ROM Range: $00B770-$00B7E6 (118 bytes)
; ============================================================================
; Selects camera view based on button input. Increments per-camera
; frame counter, then checks directional buttons (bits 5, 8-10)
; in game_input to switch between 4 camera positions (0-3).
;
; Entry: A0 = buffer selector ($9000 = alternate)
; Uses: D0, A0, A1, A2
; RAM:
;   $C048: camera_position (0-3, word index)
;   $C064: camera_enable
;   $C0A2: camera_frame_counters (word array, indexed by position×2)
;   $C302: camera_max_frames
;   $C314: camera_input_enable
;   $C972: game_input (button bitmap)
; ============================================================================

camera_state_selector:
        lea     $00FF6344,a2                    ; default gfx buffer
        cmpa.w  #$9000,a0                       ; alternate mode?
        bne.s   .selected
        lea     $00FF6114,a2                    ; alternate gfx buffer
.selected:
        move.w  ($FFFFC048).w,d0                ; camera_position
        add.w   d0,d0                            ; ×2 for word index
        lea     ($FFFFC0A2).w,a1                ; camera_frame_counters
        addq.w  #1,$00(a1,d0.w)                 ; increment frame counter
        tst.b   ($FFFFC064).w                   ; camera enabled?
        dc.w    $6658                            ; bne.s $00B7EE → external handler
        move.w  ($FFFFC048).w,d0                ; camera_position
        add.w   d0,d0                            ; ×2
        add.w   d0,d0                            ; ×4
        cmp.b   ($FFFFC302).w,d0                ; reached max frames?
        dc.w    $6656                            ; bne.s $00B7FA → external handler
        move.w  ($FFFFC972).w,d0                ; game_input buttons
        tst.b   ($FFFFC314).w                   ; camera input enabled?
        dc.w    $6738                            ; beq.s $00B7E6 → skip (input disabled)
; --- check directional buttons ---
        btst    #10,d0                          ; button bit 10?
        beq.s   .check_bit9
        move.w  #$0001,($FFFFC048).w            ; camera position 1
        bra.s   .done
.check_bit9:
        btst    #9,d0                           ; button bit 9?
        beq.s   .check_bit8
        move.w  #$0002,($FFFFC048).w            ; camera position 2
        bra.s   .done
.check_bit8:
        btst    #8,d0                           ; button bit 8?
        beq.s   .check_bit5
        move.w  #$0003,($FFFFC048).w            ; camera position 3
        bra.s   .done
.check_bit5:
        btst    #5,d0                           ; button bit 5?
        beq.s   .done
        move.w  #$0000,($FFFFC048).w            ; camera position 0 (default)
.done:
        rts
