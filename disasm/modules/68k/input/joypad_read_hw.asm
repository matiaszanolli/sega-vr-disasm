; ============================================================================
; Joypad Hardware Read (6-Button Protocol)
; ROM Range: $00185E-$0018C6 (106 bytes)
; ============================================================================
; Low-level Genesis/Mega Drive joypad hardware read using the standard
; TH-toggle protocol. Detects 6-button controllers and reads extra buttons.
; Requests Z80 bus during I/O access.
;
; Entry: A1 = joypad data port address (e.g., $A10003 or $A10005)
; Exit: D0 = button state word (1 = pressed)
;       Format: ZYXM_SACBRLDU (6-btn) or 00000000_SACBRLDU (3-btn)
; Uses: D0, D1, D5, D6, D7
; Hardware: $A11100 (Z80 bus), A1 (joypad port)
; ============================================================================

joypad_read_hw:
        move.w  #$0100,$00A11100        ; Request Z80 bus
.wait_bus:
        btst    #0,$00A11100            ; Check bus grant
        bne.s   .wait_bus               ; Wait until granted
; --- TH toggle protocol ---
        move.b  #$40,(a1)               ; TH=1 (select high)
        moveq   #0,d6                   ; Clear temp
        moveq   #$3F,d1                 ; 6-bit mask
        and.b   (a1),d1                 ; Read CBRLDU (TH=1)
        move.b  d6,(a1)                 ; TH=0 (select low)
        moveq   #$40,d7                 ; TH=1 value for later
        moveq   #$30,d0                 ; Bits 4-5 mask
        and.b   (a1),d0                 ; Read SA bits (TH=0)
        lsl.b   #2,d0                   ; Shift Start/A to bits 6-7
        or.w    d1,d0                   ; Merge: SACBRLDU
        move.b  d7,(a1)                 ; TH=1
        nop                             ; Timing delays
        nop
        nop
        nop
        move.b  (a1),d1                 ; Read (TH=1, 2nd)
        move.b  d6,(a1)                 ; TH=0
; --- 6-button detection ---
        move.w  #$00FF,d5               ; 3-button mask
        move.b  (a1),d1                 ; Read (TH=0, 2nd)
        move.b  d7,(a1)                 ; TH=1
        move.b  (a1),d1                 ; Read (TH=1, 3rd)
        move.b  d6,(a1)                 ; TH=0
        nop                             ; Timing delays
        nop
        nop
        moveq   #$0F,d1                 ; Low nibble mask
        and.b   (a1),d1                 ; Read (TH=0, 3rd)
        dc.w    $661C                   ; BNE.S joypad_read_3btn (3-button exit)
; --- 6-button extra buttons ---
        move.b  d7,(a1)                 ; TH=1 (4th toggle)
        nop                             ; Timing
        nop
        nop
        moveq   #$0F,d1                 ; Mask
        and.b   (a1),d1                 ; Read ZYXM bits
        lsl.w   #8,d1                   ; Shift to high byte
        or.w    d1,d0                   ; Merge: ZYXM_SACBRLDU
        not.w   d0                      ; Complement (active low -> high)
        move.w  #$0000,$00A11100        ; Release Z80 bus
        rts
