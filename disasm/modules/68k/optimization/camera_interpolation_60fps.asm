; ============================================================================
; Camera Interpolation — 60 FPS Rendering (A-2)
; Relocated from code_2200.asm trampoline to code_1c200 expansion area.
;
; Implements 3 frame swaps per game frame (60 FPS display, 20 FPS game logic):
;   State 0: block-copy prev interp → swap → snapshot → DMA (this file)
;   State 4: block-copy current → swap → interpolate → re-DMA (this file)
;   State 8: block-copy interp → swap (existing vdp_dma_frame_swap_037)
;
; All cross-section calls use absolute 68K addresses (JSR $0088xxxx)
; since PC-relative cannot reach from code_1c200 to lower ROM sections.
;
; RAM usage:
;   $FF6080: prev camera snapshot (16 bytes)
;   $FF6090: curr camera snapshot (16 bytes)
;   $FF6100: camera parameter buffer (populated by render pipeline)
; ============================================================================

; --- Constants for cross-section calls (68K address = ROM offset + $880000) ---
SH2_SEND_CMD            equ     $0088E35A       ; sh2_send_cmd at ROM $00E35A
MARS_DMA_XFER_VDP_FILL  equ     $008828C2       ; mars_dma_xfer_vdp_fill at ROM $0028C2

; ============================================================================
; state0_60fps — State 0: block-copy + swap + snapshot + DMA
; Called via JMP relay from camera_snapshot_wrapper in code_2200.asm.
; Entry: called from state 0 handler (state_disp_005020)
; Returns: to state 0 handler (after original mars_dma_xfer_vdp_fill call)
; ============================================================================
state0_60fps:
; --- Block-copy previous interpolated render to framebuffer ---
; SDRAM still has the interpolated render from last frame's state 4 re-DMA.
; Copy it to framebuffer before the new DMA overwrites SDRAM.
        movea.l #$06038000,a0                  ; 3D geometry source (SDRAM)
        movea.l #$04012010,a1                  ; framebuffer dest
        move.w  #$0120,d0                      ; width = 288 pixels
        move.w  #$0030,d1                      ; height = 48 rows
        jsr     SH2_SEND_CMD                   ; sh2_send_cmd (abs.l)
        movea.l #$0603B600,a0                  ; sprite data source (SDRAM)
        movea.l #$0401B010,a1                  ; framebuffer dest
        move.w  #$0120,d0                      ; width = 288 pixels
        move.w  #$0018,d1                      ; height = 24 rows
        jsr     SH2_SEND_CMD                   ; sh2_send_cmd

; --- Frame swap (display previous interpolated render) ---
        btst    #0,COMM1_LO                    ; SH2 block copy done?
        beq.s   .no_swap                       ; no → skip
        bclr    #0,COMM1_LO                    ; clear done flag
        bchg    #0,($FFFFC80C).w               ; flip frame toggle
        bchg    #0,$00A1518B                   ; toggle FS bit (swap display)
.no_swap:

; --- Snapshot: curr → prev, $FF6100 → curr ---
        lea     $00FF6090,a0
        lea     $00FF6080,a1
        movem.l (a0),d0-d3                     ; load 16 bytes from curr
        movem.l d0-d3,(a1)                     ; store to prev
        lea     $00FF6100,a0
        lea     $00FF6090,a1
        movem.l (a0),d0-d3                     ; load 16 bytes from camera buffer
        movem.l d0-d3,(a1)                     ; store to curr snapshot

; --- Call original DMA function ---
        jsr     MARS_DMA_XFER_VDP_FILL         ; send $FF6000 block to SH2
        rts

; ============================================================================
; camera_avg_and_redma_60fps — Average camera and re-send DMA to SH2
; Averages 8 words between prev ($FF6080) and curr ($FF6090),
; writes result to $FF6100, then re-DMAs $FF6000 block to SH2.
; ============================================================================
camera_avg_and_redma_60fps:
; --- Average prev/curr camera into $FF6100 ---
        lea     $00FF6080,a0                   ; prev snapshot
        lea     $00FF6090,a1                   ; curr snapshot
        lea     $00FF6100,a2                   ; camera buffer output
        moveq   #7,d7                          ; 8 words to average
.avg_loop:
        move.w  (a0)+,d0                       ; prev[i]
        add.w   (a1)+,d0                       ; prev + curr
        asr.w   #1,d0                          ; / 2
        move.w  d0,(a2)+                       ; store averaged
        dbra    d7,.avg_loop
; --- DIAGNOSTIC: send a block-copy from a WRONG source address ---
; sh2_send_cmd (cmd $22) is PROVEN to work. If we send a block-copy
; from a different SDRAM address (e.g., $06030000 instead of $06038000),
; the display should show garbage/different content on one frame.
; This tests whether our frame swap + display pipeline is working.
        movea.l #$06030000,a0                  ; WRONG source (should show garbage)
        movea.l #$04012010,a1                  ; framebuffer dest (same as normal)
        move.w  #$0120,d0                      ; width = 288
        move.w  #$0030,d1                      ; height = 48
        jsr     SH2_SEND_CMD                   ; block-copy garbage to framebuffer
        rts

; ============================================================================
; state4_60fps — State 4: block-copy + swap + interpolation + re-DMA + advance
; Called via JMP relay from state4_epilogue in code_2200.asm.
; Entry: tail-jumped from frame_update_orch_005070
; Returns: to main loop (includes state advance + RTS)
; ============================================================================
state4_60fps:
; --- Block-copy current SH2 render (camera N) to framebuffer ---
        movea.l #$06038000,a0                  ; 3D geometry source (SDRAM)
        movea.l #$04012010,a1                  ; framebuffer dest
        move.w  #$0120,d0                      ; width = 288 pixels
        move.w  #$0030,d1                      ; height = 48 rows
        jsr     SH2_SEND_CMD                   ; sh2_send_cmd (abs.l)
        movea.l #$0603B600,a0                  ; sprite data source (SDRAM)
        movea.l #$0401B010,a1                  ; framebuffer dest
        move.w  #$0120,d0                      ; width = 288 pixels
        move.w  #$0018,d1                      ; height = 24 rows
        jsr     SH2_SEND_CMD                   ; sh2_send_cmd

; --- Frame swap (display camera N render) ---
        btst    #0,COMM1_LO                    ; SH2 block copy done?
        beq.s   .no_swap                       ; no → skip
        bclr    #0,COMM1_LO                    ; clear done flag
        bchg    #0,($FFFFC80C).w               ; flip frame toggle
        bchg    #0,$00A1518B                   ; toggle FS bit (swap display)
.no_swap:

; --- Interpolate camera and trigger second SH2 render ---
        bsr.w   camera_avg_and_redma_60fps     ; PC-relative (same section)

; --- Original state 4 epilogue ---
        addq.w  #4,($FFFFC87E).w               ; advance game_state
        move.w  #$001C,$00FF0008               ; V-INT state = sprite_cfg
        rts
