; ============================================================================
; vint_sprite_cfg_with_swap — V-INT State $001C: Sprite Config + Frame Swap
; ============================================================================
;
; Wrapper for the original vdp_dma_xfer_setup_001aca handler.
; Called from V-INT dispatch during VBlank (VBLK=1).
;
; Phase 8: 60 FPS triggers REMOVED. The state dispatcher now runs all states
; per frame, and the unified V-INT handler ($0054) does all VDP work.
; This wrapper is kept for non-racing modes that still use V-INT $001C.
;
; Entry: A5 = VDP control port (from V-INT dispatch)
; ============================================================================

VDP_DMA_SETUP_001ACA    equ     $00881ACA       ; original handler 68K address

vint_sprite_cfg_with_swap:
; --- Call original sprite config handler ---
        jsr     VDP_DMA_SETUP_001ACA

; --- Frame swap (only during racing, $C8D2 != 0) ---
        tst.b   ($FFFFC8D2).w
        beq.s   .no_swap

        bclr    #7,MARS_SYS_INTCTL
.wait_ack:
        btst    #7,$00A1518A
        beq.s   .wait_ack

        bchg    #0,($FFFFC80C).w
        bne.s   .set_buf_1
        bset    #0,$00A1518B
        bra.s   .done
.set_buf_1:
        bclr    #0,$00A1518B
.done:
        bset    #7,MARS_SYS_INTCTL

.no_swap:
        rts
