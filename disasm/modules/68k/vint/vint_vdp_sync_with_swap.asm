; ============================================================================
; vint_vdp_sync_with_swap — V-INT State $0014: VDP Sync + Frame Swap
; Size: ~40 bytes
; ============================================================================
;
; Wrapper for vdp_dma_xfer_setup_001a72 (state $0014 handler).
; Called from V-INT dispatch during VBlank.
; Same swap logic as vint_sprite_cfg_with_swap.
;
; Entry: A5 = VDP control port
; ============================================================================

VDP_DMA_SETUP_001A72    equ     $00881A72       ; original handler 68K address

vint_vdp_sync_with_swap:
; --- Call original VDP sync handler ---
        jsr     VDP_DMA_SETUP_001A72

; --- Frame swap (only during racing) ---
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
; --- 60 FPS: fire cmd $3F physics (non-blocking) ---
        tst.b   COMM0_HI                        ; Master busy?
        bne.s   .no_swap                         ; skip if busy (graceful)
        move.b  #$3F,COMM0_LO                   ; cmd index
        move.b  #$01,COMM0_HI                   ; trigger
; --- 60 FPS: re-trigger Slave render ---
        move.b  #$02,COMM2                       ; Slave cmd $02 (render)
.no_swap:
        rts
