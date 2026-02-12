; ============================================================================
; MARS DMA Transfer + VDP Fill
; ROM Range: $0028C2-$002984 (194 bytes)
; ============================================================================
; Two entry points: (1) DMA transfer — sets MARS DREQ length/mode,
; writes command to COMM0, waits for ACK via COMM1, then streams
; data from $FF6000 to MARS FIFO via 10 calls to block copy routine.
; (2) VDP fill — clears adapter control, fills MARS framebuffer
; with zeros starting at VRAM $3000 (192 lines × 256 pixels).
;
; Uses: D0, D1, D2, D7, A1, A2, A3, A4
; RAM:
;   $C8A8: dma_state_timer
;   $C8A9: dma_command_code
; ============================================================================

fn_2200_021:
; --- entry 1: MARS DMA transfer ---
        move.w  #$0500,MARS_DREQ_LEN            ; DMA length = $500
        move.b  #$04,MARS_DREQ_CTRL+1           ; DMA mode = 4
        move.b  ($FFFFC8A9).w,COMM0_LO          ; write command code
        move.b  ($FFFFC8A8).w,COMM0_HI          ; write command flag
.wait_ack:
        btst    #1,COMM1_LO                     ; poll ACK bit
        beq.s   .wait_ack
        bclr    #1,COMM1_LO                     ; clear ACK bit
        lea     $00FF6000,a1                    ; source buffer
        lea     MARS_FIFO,a2                    ; FIFO register
; --- stream 10 blocks to MARS FIFO ---
        jsr     $008988EC
        jsr     $008988EC
        jsr     $008988EC
        jsr     $008988EC
        jsr     $008988EC
        jsr     $008988EC
        jsr     $008988EC
        jsr     $008988EC
        jsr     $008988EC
        jmp     $008988EC                       ; last block + return
; --- entry 2: MARS VDP fill ---
        lea     MARS_SYS_BASE,a4                ; 32X register base
        move.b  #$00,(a4)                       ; clear adapter control
        lea     MARS_VDP_FILLADR,a2             ; VDP fill address register
        lea     MARS_VDP_FILLDATA,a3            ; VDP fill data register
        move.w  #$00BF,d7                       ; 192 lines - 1
        moveq   #$00,d0                         ; fill value = 0
        move.w  #$3000,d1                       ; start address
        move.w  #$0100,d2                       ; line stride (256 pixels)
        move.w  #$009F,$0084(a4)                ; set fill length = 160 words
.fill_loop:
        move.w  d1,(a2)                         ; set fill address
        move.w  d0,(a3)                         ; trigger fill with value 0
        moveq   #$6F,d0                         ; delay counter
        divs    #$0378,d0                       ; burn cycles (delay for fill)
.wait_fill:
        btst    #1,$008B(a4)                    ; fill busy?
        bne.s   .wait_fill
        add.w   d2,d1                            ; next line address
        dbra    d7,.fill_loop
        move.b  #$80,(a4)                       ; restore adapter control
        rts
