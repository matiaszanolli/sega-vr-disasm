; ============================================================================
; Q-020 mode-1 validation-only scene wrapper and CMDINT/DREQ producer
; ============================================================================
;
; This reviewed producer is shared by the mutually-exclusive
; VR60_MODE1_VALIDATION and VR60_MODE2_VALIDATION builds. Conditional constants
; select the payload; neither variant is part of the accepted mode-0 ROM.
;
; The producer never accesses a COMM register.  The SH2 ISR rejects every setup
; edge whose saved SPC is outside the exact disassembled stock-idle or
; stock-finalization-quiescent sets.  A completion edge is SPC-independent only
; after the ISR proves the unique in-flight transaction counts and exact DMAC0
; identity, because the 68K stays blocked between the two edges.
; Setup and terminal acknowledgement are both the hardware INTM bit returning
; low after the Master clears CMDINT at $2000401A.
;
; Fixed layout in code_1c200:
;   $01C914/$0089C914  scene wrapper
;   $01C922            shared DREQ/CMDINT helper (low ROM alias used by hook)
; ============================================================================

vr60_mode1_scene_entry_wrapper:
        nop                                             ; distinct wrapper-entry witness
        clr.b   VR60_1P_FLAG                            ; re-arm lifecycle one-shot
        jmp     $00884A3E                               ; preserve loader's original entry

vr60_1p_globals_transfer_mode1_validation:
vr60_1p_ai_transfer_mode2_validation:
        movem.l d0-d2/a1-a2,-(sp)

; Require no prior producer edge and no active DREQ transaction before changing
; the DREQ signature.  INTM is the Master-only low byte bit; INTS is preserved.
.wait_setup_intm_low:
        btst    #0,MARS_SYS_INTMASK+1
        bne.s   .wait_setup_intm_low
.wait_dreq_idle:
        btst    #2,MARS_DREQ_CTRL+1
        bne.s   .wait_dreq_idle
.wait_prior_len_zero:
        tst.w   MARS_DREQ_LEN
        bne.s   .wait_prior_len_zero

; Publish the exact SH2-readable setup signature before the first CMD edge.
; Destination registers are descriptive to the SH2 (the DREQ circuit itself
; does not consume them).  The selected 24-bit SDRAM-offset encoding expands
; semantically to the variant's exact SH2 SDRAM destination.
        ifd     VR60_MODE2_VALIDATION
        move.w  #$0001,MARS_DREQ_DST_H             ; 24-bit SDRAM offset $01:0000
        move.w  #$0000,MARS_DREQ_DST_L
        move.w  #$0780,MARS_DREQ_LEN             ; 1920 words = 3840 bytes
        else
        move.w  #$0000,MARS_DREQ_DST_H             ; 24-bit SDRAM offset high byte
        move.w  #$F30C,MARS_DREQ_DST_L
        move.w  #$0020,MARS_DREQ_LEN             ; 32 words = 64 bytes
        endif
        move.b  #$04,MARS_DREQ_CTRL+1             ; 68S=1, CPU-write mode

; Setup edge.  No FIFO word can execute until the ISR has armed DMAC0,
; synchronized DMAOR, cleared CMDINT, and INTM has consequently returned low.
        ori.b   #$01,MARS_SYS_INTMASK+1
.wait_setup_ack:
        btst    #0,MARS_SYS_INTMASK+1
        bne.s   .wait_setup_ack

; The hardware FIFO is four words deep.  Stream the variant's exact number of
; four-word groups, checking FULL before every group as required by the manual.
        ifd     VR60_MODE2_VALIDATION
        lea     $00FF6B40,a1
        else
        lea     $00FF6B00,a1
        endif
        lea     MARS_FIFO,a2
        ifd     VR60_MODE2_VALIDATION
        move.w  #479,d2                          ; 480 groups x four words
        else
        moveq   #7,d2
        endif
.fifo_group:
.wait_fifo_clear:
        btst    #7,MARS_DREQ_CTRL+1
        bne.s   .wait_fifo_clear
        moveq   #3,d0
.fifo_word:
        move.w  (a1)+,(a2)
        dbra    d0,.fifo_word
        dbra    d2,.fifo_group

; DREQ_LEN reaches zero when all words have entered the DREQ circuit.  68S is
; automatically cleared when that operation ends; require both before issuing
; the completion edge.  The ISR then waits for/validates DMAC0.TE itself.
.wait_dreq_len_zero:
        tst.w   MARS_DREQ_LEN
        bne.s   .wait_dreq_len_zero
.wait_dreq_auto_clear:
        btst    #2,MARS_DREQ_CTRL+1
        bne.s   .wait_dreq_auto_clear

; Completion edge.  The ISR proves TCR0=0/TE=1, performs the documented
; read-1/write-0 acknowledgement, returns CHCR0 to disabled idle, clears CMDINT,
; and only then lets this INTM poll finish.
.wait_completion_intm_low:
        btst    #0,MARS_SYS_INTMASK+1
        bne.s   .wait_completion_intm_low
        ori.b   #$01,MARS_SYS_INTMASK+1
.wait_completion_ack:
        btst    #0,MARS_SYS_INTMASK+1
        bne.s   .wait_completion_ack

        movem.l (sp)+,d0-d2/a1-a2
        rts
