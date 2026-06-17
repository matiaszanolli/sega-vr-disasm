; ============================================================================
; vint_unified_60fps — VR60 Phase 8: Unified 60 FPS V-INT Handler
; ============================================================================
;
; Combines ALL VDP work into a single V-INT handler that runs every VBlank:
;   1. VDP sync (original $0014 handler at $001A72)
;   2. Sprite config (original $001C handler at $001ACA)
;   3. Frame swap (from vdp_dma_frame_swap_037 at $001D0C)
;
; Replaces the 3-handler rotation ($0014/$001C/$0054) with a single handler
; that does everything every frame. The state dispatcher always writes $0054
; to $FF0008, so this handler runs every VBlank.
;
; Total VBlank time: ~5-10K cycles (budget: ~30K). Ample margin.
;
; Entry: A5 = VDP control port, A6 = VDP data port (from V-INT dispatch)
; ============================================================================

vint_unified_60fps:
; --- 1. VDP sync (state $0014 work) ---
        jsr     $00881A72                       ; original VDP sync handler

; --- 2. Sprite config (state $001C work) ---
        jsr     $00881ACA                       ; original sprite config handler

; --- 3. Frame swap (state $0054 work, from vdp_dma_frame_swap_037) ---
; VDP scroll + color registers
        move.w  (A5),D0                         ; save VDP status
        move.l  #$6C000003,(A5)                 ; VDP reg: scroll address
        move.w  ($FFFF8000).w,(A6)              ; write scroll_h
        move.w  ($FFFF8002).w,(A6)              ; write scroll_v
        move.l  #$40000010,(A5)                 ; VDP reg: color address
        move.w  ($FFFFC880).w,(A6)              ; write color_a
        move.w  ($FFFFC882).w,(A6)              ; write color_b

; Z80 bus request + CRAM DMA
        move.w  #$0100,Z80_BUSREQ
.wait_z80:
        btst    #0,Z80_BUSREQ
        bne.s   .wait_z80

; VDP DMA: 64 words CRAM transfer
        move.w  ($FFFFC874).w,D4
        bset    #4,D4                           ; enable DMA
        move.w  D4,(A5)                         ; mode register
        move.l  #$93409400,(A5)                 ; DMA length = $0040
        move.l  #$954096C2,(A5)                 ; DMA source = $D845 << 1
        move.w  #$977F,(A5)                     ; DMA source high
        move.w  #$C000,(A5)                     ; DMA dest = CRAM $0000
        move.w  #$0080,($FFFFC876).w            ; vdp_dma_ctrl
        move.w  ($FFFFC876).w,(A5)              ; trigger DMA
        move.w  ($FFFFC874).w,(A5)              ; restore mode register

; Release Z80 bus
        move.w  #$0000,Z80_BUSREQ

; --- Check COMM1 for SH2 "render done" signal ---
        btst    #0,COMM1_LO
        beq.s   .exit                           ; not done → skip swap (adaptive)

        bclr    #0,COMM1_LO                    ; acknowledge
        move.w  #$0000,($FFFFC87E).w            ; reset game state (keeps dispatcher at state 0)

; --- CMD INT: disable during FS toggle ---
        bclr    #7,MARS_SYS_INTCTL
.wait_ack:
        btst    #7,$00A1518A
        beq.s   .wait_ack

; --- Toggle frame buffer ---
        bchg    #0,($FFFFC80C).w
        bne.s   .set_buf_1
        bset    #0,$00A1518B                    ; FS=1 (display buffer 0)
        bra.s   .done
.set_buf_1:
        bclr    #0,$00A1518B                    ; FS=0 (display buffer 1)
.done:
        bset    #7,MARS_SYS_INTCTL              ; re-enable CMD INT

.exit:
        rts
