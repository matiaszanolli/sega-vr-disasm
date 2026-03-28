; ============================================================================
; vint_sprite_cfg_with_swap — V-INT State $001C: Sprite Config + Frame Swap
; Size: ~40 bytes
; ============================================================================
;
; Wrapper for the original vdp_dma_xfer_setup_001aca handler.
; Called from V-INT dispatch during VBlank (VBLK=1).
;
; Does TWO things:
;   1. Call the original sprite config handler (VDP DMA setup)
;   2. Toggle the frame buffer (FS bit) if racing mode active ($C8D2)
;
; The FS toggle happens DURING VBlank, so it takes effect immediately
; (per 32X Hardware Manual page 35: "swapping is done at the next VBlank"
; only applies to writes during DISPLAY — writes during VBlank are instant).
;
; CMD INT is disabled during FS toggle to prevent SH2 from issuing
; commands while the adapter register is being modified.
;
; Entry: A5 = VDP control port (from V-INT dispatch)
; Preserves: all (same contract as original handler)
; ============================================================================

VDP_DMA_SETUP_001ACA    equ     $00881ACA       ; original handler 68K address

vint_sprite_cfg_with_swap:
; --- Call original sprite config handler ---
        jsr     VDP_DMA_SETUP_001ACA            ; 6B — abs.l (original handler)

; --- Frame swap (only during racing, $C8D2 != 0) ---
        tst.b   ($FFFFC8D2).w                   ; 4B — racing mode?
        beq.s   .no_swap                         ; 2B — no: skip swap

; --- CMD INT: disable during FS toggle ---
        bclr    #7,MARS_SYS_INTCTL              ; 6B — clear CMD INT
.wait_ack:
        btst    #7,$00A1518A                    ; 6B — CMD INT acknowledged?
        beq.s   .wait_ack                       ; 2B — spin

; --- Toggle frame buffer ---
        bchg    #0,($FFFFC80C).w                ; 6B — flip software toggle
        bne.s   .set_buf_1                      ; 2B
        bset    #0,$00A1518B                    ; 6B — FS=1 (display buffer 0)
        bra.s   .done                            ; 2B
.set_buf_1:
        bclr    #0,$00A1518B                    ; 6B — FS=0 (display buffer 1)
.done:
; --- CMD INT: re-enable ---
        bset    #7,MARS_SYS_INTCTL
; --- 60 FPS: fire cmd $3F physics (non-blocking) ---
        tst.b   COMM0_HI                        ; Master busy?
        bne.s   .no_swap                         ; skip if busy
        move.b  #$3F,COMM0_LO
        move.b  #$01,COMM0_HI
; --- 60 FPS: re-trigger Slave render ---
        move.b  #$02,COMM2
.no_swap:
        rts
