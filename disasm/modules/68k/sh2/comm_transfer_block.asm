; ============================================================================
; COMM Transfer Block (Command $2D)
; ROM Range: $00FB36-$00FB98 (98 bytes)
; ============================================================================
; Sends command $2D and transfers 28 words from buffer via FIFO.
; Waits for COMM0 clear, sets count, sends command, polls COMM1_LO
; bit 1 for ready, then copies 28 words from ($FF60C8) to MARS_FIFO.
;
; Uses: D7, A1, A2
; ============================================================================

comm_transfer_block:
.wait1: tst.b   COMM0_HI              ; Wait COMM0 clear
        bne.s   .wait1
        move.w  #$001C,MARS_DREQ_LEN  ; Set transfer count (28 words)
        move.b  #$04,MARS_DREQ_CTRL+1 ; Set DMA mode
        clr.b   COMM1_LO              ; Clear COMM1 low byte
        move.b  #$2D,COMM0_LO         ; Command $2D
        move.b  #$01,COMM0_HI         ; Trigger
.wait2: btst    #$01,COMM1_LO         ; Poll COMM1_LO bit 1
        beq.s   .wait2
        bclr    #$01,COMM1_LO         ; Clear bit 1
        lea     $FF60C8,a1            ; Source buffer
        lea     MARS_FIFO,a2          ; FIFO data register
        move.w  #$001B,d7             ; 28 words
.xfer:  btst    #$07,MARS_DREQ_CTRL+1 ; Wait FIFO not full
        bne.s   .xfer
        move.w  (a1)+,(a2)            ; Copy word to FIFO
        dbra    d7,.xfer
        rts
