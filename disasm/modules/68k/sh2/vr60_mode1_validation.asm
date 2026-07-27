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

; Exactly one trigger. From this point onward there is no retry, unwind, return,
; or COMM0/COMM3 access until Master completes. Missing progress fails stopped.
        move.b  #$3E,COMM0_LO
        move.b  #$01,COMM0_HI

.wait_ack:
        btst    #1,COMM1_LO
        beq.s   .wait_ack

; Master flushed ACK and has relinquished COMM1 while it waits on DREQ_LEN.
; Preserve system bit 0 and return only ACK-bit ownership before streaming.
        bclr    #1,COMM1_LO

; Eight groups of four words. FULL is checked before every group, as required
; by the 32X hardware manual.
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
; length has reached zero. Master does not inspect COMM1 until this reaches 0.
.wait_dreq_complete:
        tst.w   MARS_DREQ_LEN
        bne.s   .wait_dreq_complete

        movem.l (sp)+,d0-d2/a1-a2
        rts
