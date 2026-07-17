; ============================================================================
; vr60_1p_globals_transfer — 1P-exclusive DREQ Transfer of Globals-Only
; ============================================================================
;
; 1P-exclusive copy of vr60_globals_transfer.asm, with the same bounded
; retry as vr60_1p_entity_transfer.asm (see that file's header for the full
; rationale). Separate file so this can never again affect the shared 2P
; path (state4_epilogue).
;
; Transfers 64 bytes of globals from WRAM staging ($FF6B00) to SH2 SDRAM
; ($0600F30C) via DREQ FIFO. Uses cmd $3E mode 1 (COMM3_HI = $01).
;
; Called from: vr60_1p_staging_hook (subsequent frames, after vr60_globals_stage)
; ============================================================================

vr60_1p_globals_transfer:
; --- Save registers used by retry counter and FIFO loop ---
        movem.l d0/d1/a1-a2,-(sp)                ; save D0/D1/A1/A2

; --- Set up DREQ for 64-byte transfer ---
        move.w  #$0020,MARS_DREQ_LEN              ; 32 words = 64 bytes
        move.b  #$04,MARS_DREQ_CTRL+1             ; CPU write mode

; --- Set mode = globals-only (COMM3_HI = $01) ---
        move.b  #$01,COMM3                        ; mode 1

; --- Trigger cmd $3E, bounded retry (max 16 attempts) ---
        moveq   #15,d1
.retrigger:
        moveq   #0,d0
        move.b  d0,COMM0_HI
        move.b  #$3E,COMM0_LO
        move.b  #$01,COMM0_HI

        move.w  #99,d0
.settle_delay:
        dbra    d0,.settle_delay

        btst    #1,COMM1_LO
        bne.s   .acked
        dbra    d1,.retrigger
        bra.s   .done

.acked:
        bclr    #1,COMM1_LO

; --- Push 64 bytes from globals staging to FIFO ---
        lea     $00FF6B00,a1                      ; globals staging source
        lea     MARS_FIFO,a2                      ; FIFO register
        moveq   #31,d0                            ; 32 words - 1
.globals_fifo:
        move.w  (a1)+,(a2)                        ; push word to FIFO
        dbra    d0,.globals_fifo                   ; loop 32 times

.done:
        movem.l (sp)+,d0/d1/a1-a2                 ; restore D0/D1/A1/A2
        rts
