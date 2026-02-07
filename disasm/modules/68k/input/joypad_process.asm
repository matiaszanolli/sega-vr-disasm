; ============================================================================
; Joypad Process (Button Mapping + Edge Detection)
; ROM Range: $0017E4-$00185C (122 bytes)
; ============================================================================
; Reads joypad via joypad_read_hw, maps raw button/direction bits
; to a standardized format using a configurable mapping table,
; and performs edge detection to identify newly pressed buttons.
;
; Entry: A0 = output buffer (2 bytes), A2 = state buffer (4 bytes)
;        A3 = button mapping table (8 bytes)
; Exit: Button states written to (A0) and (A2)
; Uses: D0-D2, D6, D7, A0-A3
; Calls: joypad_read_hw
; ============================================================================

joypad_process:
        lea     $00A10005,a1            ; Joypad data port 2
        jsr     joypad_read_hw(pc)      ; Read hardware buttons
        move.b  (a0),d2                 ; D2 = previous raw state
        move.w  d0,d1                   ; D1 = save raw reading
        eor.b   d0,d2                   ; Find changed bits
        and.b   d2,d0                   ; Isolate newly pressed
        move.b  d1,(a0)+                ; Store raw state
        move.b  d0,(a0)+                ; Store edge-detected
        moveq   #0,d6                   ; Initialize output word
        or.b    d1,d6                   ; Copy direction bits
        andi.b  #$0C,d6                 ; Mask to U/D only
; --- Button A ---
        move.b  (a3)+,d7                ; Get button bit position
        btst    d7,d1                   ; Test button
        beq.s   .no_btn_a
        bset    #4,d6                   ; Set button A
.no_btn_a:
; --- Button B ---
        move.b  (a3)+,d7
        btst    d7,d1
        beq.s   .no_btn_b
        bset    #6,d6                   ; Set button B
.no_btn_b:
; --- Left ---
        move.b  (a3)+,d7
        btst    d7,d1
        beq.s   .no_left
        bset    #1,d6                   ; Set left
.no_left:
; --- Right ---
        move.b  (a3)+,d7
        btst    d7,d1
        beq.s   .no_right
        bset    #0,d6                   ; Set right
.no_right:
; --- Start ---
        move.b  (a3)+,d7
        btst    d7,d1
        beq.s   .no_start
        bset    #10,d6                  ; Set start
.no_start:
; --- Button C ---
        move.b  (a3)+,d7
        btst    d7,d1
        beq.s   .no_btn_c
        bset    #5,d6                   ; Set button C
.no_btn_c:
; --- Button X ---
        move.b  (a3)+,d7
        btst    d7,d1
        beq.s   .no_btn_x
        bset    #9,d6                   ; Set button X
.no_btn_x:
; --- Button Y ---
        move.b  (a3)+,d7
        btst    d7,d1
        beq.s   .no_btn_y
        bset    #8,d6                   ; Set button Y
.no_btn_y:
; --- Edge detection on processed output ---
        move.w  (a2),d2                 ; Previous processed state
        move.w  d6,(a2)+                ; Store current state
        eor.w   d6,d2                   ; Find changes
        and.w   d2,d6                   ; Isolate newly set bits
        move.w  d6,(a2)+                ; Store edge-detected
        rts
