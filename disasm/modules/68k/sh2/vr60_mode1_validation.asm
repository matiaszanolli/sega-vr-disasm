; ============================================================================
; Q-020 mode-1 validation-only scene wrapper and DREQ helper
; ============================================================================
;
; This file is included only when VR60_MODE1_VALIDATION is defined. It is not
; part of the ordinary accepted mode-0 ROM and is explicitly non-promotable.
;
; Fixed layout in code_1c200:
;   $01C914/$0089C914  scene wrapper
;   $01C922            mode-1 DREQ helper (low ROM alias used by hook JSR)
; ============================================================================

vr60_mode1_scene_entry_wrapper:
        nop                                             ; distinct wrapper-entry witness
        clr.b   VR60_1P_FLAG                            ; reset one-shot before loader
        jmp     $00884A3E                               ; preserve loader's original entry

vr60_1p_globals_transfer_mode1_validation:
        movem.l d0-d2/a1-a2,-(sp)

; Validation-only fail-stop before ownership acquisition: do not submit while
; Master still owns COMM0.
.wait_master_idle:
        tst.b   COMM0_HI
        bne.s   .wait_master_idle

; Configure one 64-byte CPU-write DREQ transaction.
        move.w  #$0020,MARS_DREQ_LEN
        move.b  #$04,MARS_DREQ_CTRL+1
        move.b  #$01,COMM3

; Publish the command exactly once. The Master consumes COMM0_LO as the dispatch
; index, programs/enables DMAC0, then clears COMM0_LO as the readiness signal.
; COMM0_HI remains one until normal DMAC completion.
        move.b  #$3E,COMM0_LO
        move.b  #$01,COMM0_HI

; Do not touch the FIFO until Master has armed DMAC0. A read concurrent with
; Master's LO clear may be undefined, but that clear is program-ordered after
; the synchronized DMAOR enable, so even an undefined false zero cannot release
; this producer before DMAC0 is armed.
.wait_master_ready:
        tst.b   COMM0_LO
        bne.s   .wait_master_ready

; The hardware FIFO is four words deep. Stream exactly eight four-word groups,
; checking FULL before every group as required by the 32X hardware manual.
        lea     $00FF6B00,a1
        lea     MARS_FIFO,a2
        moveq   #7,d2
.fifo_group:
.wait_fifo_clear:
        btst    #7,MARS_DREQ_CTRL+1
        bne.s   .wait_fifo_clear
        moveq   #3,d0
.fifo_word:
        move.w  (a1)+,(a2)
        dbra    d0,.fifo_word
        dbra    d2,.fifo_group

; Do not return until all words have entered the DREQ circuit and its live
; length has reached zero. COMM1 is never read or written by this protocol.
.wait_dreq_complete:
        tst.w   MARS_DREQ_LEN
        bne.s   .wait_dreq_complete

        movem.l (sp)+,d0-d2/a1-a2
        rts
