; ============================================================================
; vr60_1p_ai_entity_transfer — 1P-exclusive DREQ Transfer of 15 AI Entities
; ============================================================================
;
; 1P-exclusive copy of vr60_ai_entity_transfer.asm, with the same bounded
; retry as vr60_1p_entity_transfer.asm (see that file's header for the full
; rationale). Separate file so this can never again affect the shared 2P
; path (state4_epilogue).
;
; Transfers 3,840 bytes (15 × 256B) from WRAM staging ($FF6B40) to SH2
; SDRAM ($06010000) via DREQ FIFO. Uses cmd $3E mode 2.
;
; Called from: vr60_1p_staging_hook (first frame only, after vr60_ai_entity_stage)
; ============================================================================

vr60_1p_ai_entity_transfer:
        movem.l d0/d1/a1-a2,-(sp)

; --- Set up DREQ for 3840-byte transfer ---
        move.w  #$0780,MARS_DREQ_LEN             ; 1920 words = 3840 bytes
        move.b  #$04,MARS_DREQ_CTRL+1            ; CPU write mode

; --- Set mode = AI entities (COMM3_HI = $02) ---
        move.b  #$02,COMM3                       ; mode 2

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

; --- Push 3840 bytes to FIFO ---
; Use 15 × BLOCK_COPY_256 for fast 256B chunks
        lea     $00FF6B40,a1                     ; staging source
        lea     MARS_FIFO,a2                     ; FIFO register
        moveq   #14,d0                           ; 15 entities - 1
.entity_fifo:
        jsr     BLOCK_COPY_256                   ; 128× MOVE.W = 256B
        dbra    d0,.entity_fifo

.done:
        movem.l (sp)+,d0/d1/a1-a2
        rts
