; Q-020 validation-only 68000 scene wrapper and CMDINT diagnostic trigger.
;
; Fixed placement:
;   file $01C914 / 68K $0089C914  wrapper, 24 bytes
;   file $01C92C / 68K $0089C92C  helper,  30 bytes
;
; Enabled only by VR60_Q020_CMDINT_PROBE, which is mutually exclusive with
; VR60_MODE1_VALIDATION.

Q020_CMDINT_ONESHOT    equ     $00FF7B41

q020_cmdint_probe_wrapper:
        tst.b   Q020_CMDINT_ONESHOT
        bne.s   .tail
        move.b  #1,Q020_CMDINT_ONESHOT
        bsr.s   q020_cmdint_probe_trigger
.tail:
        jmp     $00884A3E

q020_cmdint_probe_trigger:
.wait_for_boot_ack:
        btst    #0,$00A15103       ; require a fresh low->high diagnostic edge
        bne.s   .wait_for_boot_ack
        ori.b   #1,$00A15103       ; set INTM only; preserve INTS
.wait_for_master_ack:
        btst    #0,$00A15103
        bne.s   .wait_for_master_ack
        rts
