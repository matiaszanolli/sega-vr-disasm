; ============================================================================
; VDP Fill Frame Buffer
; ROM Range: $00273C-$002778 (62 bytes)
; ============================================================================
; Fills the entire 32X VDP frame buffer with zeros (screen clear).
; Uses hardware fill register with 256-pixel line stride for 256 lines.
;
; Entry: none
; Uses: A2, A3, A4, D0, D1, D2, D7
; ============================================================================

vdp_fill_framebuffer:
        lea     $00A15100,a4          ; MARS system base
        lea     $00A15186,a2          ; VDP fill address register
        lea     $00A15188,a3          ; VDP fill data register
        andi.b  #$40,$0081(a4)        ; Configure VDP access
        move.w  #$00FF,d7             ; 256 lines
        moveq   #0,d0                 ; Fill value = 0
        moveq   #0,d1                 ; Start address = 0
        move.w  #$0100,d2             ; Line stride
        move.w  #$00FF,$0084(a4)      ; Set auto-increment
.fill_loop:
        move.w  d1,(a2)               ; Set fill address
        move.w  d0,(a3)               ; Write fill data
.busy_wait:
        btst    #1,$008B(a4)          ; Check fill busy
        bne.s   .busy_wait            ; Wait until done
        add.w   d2,d1                 ; Next line address
        dbra    d7,.fill_loop         ; Loop 256 lines
        rts
