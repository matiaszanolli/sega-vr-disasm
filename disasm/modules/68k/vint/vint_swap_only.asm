; ============================================================================
; vint_swap_only — Swap-Only V-INT Handler for 60 FPS Display
; Size: ~28 bytes
; ============================================================================
;
; Minimal frame buffer swap handler. Toggles the FS (Frame Select) bit
; to display the alternate buffer. No VDP writes, no DMA, no Z80 bus,
; no COMM1 check, no game state reset.
;
; Used during state 4 (V-INT state $0040) to provide the 3rd frame swap
; per game tick, achieving 60 FPS display with 20 FPS game logic:
;   State 0 → V-INT $0010 (minimal)
;   State 4 → V-INT $0040 (THIS HANDLER — swap only)
;   State 8 → V-INT $0054 (full swap + game state reset)
;
; The CMD INT must be managed during FS writes to prevent the SH2
; from issuing new commands while the adapter register is being modified.
;
; Entry: called from V-INT dispatch (A5/A6 = VDP ctrl/data, D0 saved)
; Preserves: all (no registers modified beyond FS toggle)
; ============================================================================

vint_swap_only:
; --- CMD INT: disable SH2 commands during FS toggle ---
        bclr    #7,MARS_SYS_INTCTL              ; clear CMD INT
.wait_ack:
        btst    #7,$00A1518A                    ; CMD INT acknowledged?
        beq.s   .wait_ack                       ; no → wait
; --- Toggle frame buffer ---
        bchg    #0,($FFFFC80C).w                ; flip software toggle
        bne.s   .set_buf_1                      ; was 1 → set buffer 1
        bset    #0,$00A1518B                    ; FS=1 (display buffer 0)
        bra.s   .done
.set_buf_1:
        bclr    #0,$00A1518B                    ; FS=0 (display buffer 1)
.done:
; --- CMD INT: re-enable SH2 commands ---
        bset    #7,MARS_SYS_INTCTL              ; restore CMD INT
        rts
