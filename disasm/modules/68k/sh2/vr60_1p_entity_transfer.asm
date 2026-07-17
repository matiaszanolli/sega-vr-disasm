; ============================================================================
; vr60_1p_entity_transfer — 1P-exclusive DREQ Transfer of Entity+Globals
; ============================================================================
;
; 1P-exclusive copy of vr60_entity_transfer.asm's protocol, with a BOUNDED
; retry against the Master-SH2 poll-detection race documented in
; analysis/VR60_PHASE1_CMD3E_ACK_HANG.md §13: a one-shot COMM0 trigger can
; land while Master is transiently busy elsewhere and never wake it. The
; original (unbounded) retry fix hard-hung the 68K when it was applied to
; the SHARED vr60_entity_transfer.asm (also used every frame by 2P's
; state4_epilogue) — see §13.2-§13.3. This is a SEPARATE file specifically
; so that risk can never recur: this function is called ONLY from the 1P
; hook, never from the 2P path.
;
; Bounded to 16 attempts (~600-cycle settle delay each, ~9,600 cycles worst
; case -- negligible next to the ~127,833-cycle 68K frame budget). If all
; attempts are exhausted without an ACK, the FIFO push is skipped entirely
; (DREQ_LEN is left programmed but unconsumed -- harmless, reprogrammed by
; the next call) rather than pushing data nothing will drain.
;
; Transfers 320 bytes (256B entity + 64B globals) from WRAM staging to
; SH2 SDRAM via DREQ FIFO. Uses cmd $3E on the Master SH2 which
; configures DMAC channel 0. Data lands at:
;   Entity:  $0600F20C (256 bytes)
;   Globals: $0600F30C (64 bytes)
;
; Called from: vr60_1p_staging_hook (after vr60_globals_stage)
; Entry: none (uses hardcoded addresses)
; Clobbers: COMM0, COMM1 bit 1 (restored by SH2 handler)
; ============================================================================

vr60_1p_entity_transfer:
; --- Save registers used by retry counter, block copy, and globals loop ---
        movem.l d0/d1/a1-a2,-(sp)               ; save D0/D1/A1/A2

; --- Set up DREQ for 320-byte transfer ---
        move.w  #$00A0,MARS_DREQ_LEN             ; 160 words = 320 bytes
        move.b  #$04,MARS_DREQ_CTRL+1            ; CPU write mode

; --- Trigger cmd $3E on Master SH2, bounded retry (max 16 attempts) ---
        moveq   #15,d1                           ; 16 attempts max
.retrigger:
        moveq   #0,d0                            ; force a real transition:
        move.b  d0,COMM0_HI                      ;   COMM0_HI = 0 first...
        move.b  #$3E,COMM0_LO                    ; dispatch index
        move.b  #$01,COMM0_HI                    ; ...then = 1 (guaranteed 0->1)

        move.w  #99,d0                           ; ~600-cycle settle delay
.settle_delay:
        dbra    d0,.settle_delay

        btst    #1,COMM1_LO                      ; poll ACK
        bne.s   .acked                           ; got it -- proceed
        dbra    d1,.retrigger                    ; not yet -- retry (bounded)
        bra.s   .done                            ; exhausted -- give up, skip FIFO push

.acked:
        bclr    #1,COMM1_LO                      ; clear ACK

; --- Push 320 bytes from staging area to FIFO ---
; Entity: 256 bytes from $FF6A00
        lea     $00FF6A00,a1                     ; entity staging source
        lea     MARS_FIFO,a2                     ; FIFO register
        jsr     BLOCK_COPY_256                   ; 128× MOVE.W (A1)+,(A2)
; Globals: 64 bytes from $FF6B00 (A1 auto-incremented to $FF6B00 by block_copy)
        moveq   #31,d0                           ; 32 words - 1
.globals_fifo:
        move.w  (a1)+,(a2)                       ; push word to FIFO
        dbra    d0,.globals_fifo                  ; loop 32 times

.done:
        movem.l (sp)+,d0/d1/a1-a2                ; restore D0/D1/A1/A2
        rts
