; ============================================================================
; COMM Transfer Block (Command $2D)
; ROM Range: $00FB36-$00FB98 (98 bytes)
; ============================================================================
; Sends command $2D and transfers 28 words from buffer via COMM.
; Waits for COMM0 clear, sets count, sends command, polls COMM3
; bit 1 for ready, then copies 28 words from ($FF60C8) to ($A15112).
;
; Uses: D7, A1, A2
; ============================================================================

comm_transfer_block:
.wait1: tst.b   $A15120               ; Wait COMM0 clear
        bne.s   .wait1
        move.w  #$001C,$A15110        ; Set transfer count
        move.b  #$04,$A15107          ; Set mode flag
        clr.b   $A15123               ; Clear COMM3
        move.b  #$2D,$A15121          ; Command $2D
        move.b  #$01,$A15120          ; Trigger
.wait2: btst    #$01,$A15123          ; Poll COMM3 bit 1
        beq.s   .wait2
        bclr    #$01,$A15123          ; Clear bit 1
        lea     $FF60C8,a1            ; Source buffer
        lea     $A15112,a2            ; COMM register dest
        move.w  #$001B,d7             ; 28 words
.xfer:  btst    #$07,$A15107          ; Wait for transfer ready
        bne.s   .xfer
        move.w  (a1)+,(a2)            ; Copy word
        dbra    d7,.xfer
        rts
