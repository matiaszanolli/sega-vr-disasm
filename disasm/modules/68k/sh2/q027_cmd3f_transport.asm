; Q-027 validation-only Master COMM0 two-edge transport.
;
; Fixed helper reservation: file $01C930-$01CAFF / 68K $0089C930-$0089CAFF.
; The caller invokes this only on lifecycle state 1.  Exact SR is saved before
; IPL7; all admission checks and both CMD waits remain masked.  After publishing
; $013F this routine never touches any COMM lane again.

q027_cmd3f_transport:
        move.w  sr,-(a7)
        move.w  #$2700,sr

.wait_edge1_intm_idle:
        btst    #0,MARS_SYS_INTMASK+1
        bne.s   .wait_edge1_intm_idle
.wait_edge1_dreq_idle:
        btst    #2,MARS_DREQ_CTRL+1
        bne.s   .wait_edge1_dreq_idle
.wait_edge1_len_idle:
        tst.w   MARS_DREQ_LEN
        bne.s   .wait_edge1_len_idle
.wait_edge1_comm0_hi_idle:
        tst.b   COMM0_HI
        bne.s   .wait_edge1_comm0_hi_idle

        move.b  #$02,VR60_1P_FLAG
        ori.b   #$01,MARS_SYS_INTMASK+1
.wait_edge1_ack:
        btst    #0,MARS_SYS_INTMASK+1
        bne.s   .wait_edge1_ack

; The admitted Master is now in the no-memory/no-COMM park loop.  Normalize
; the stock command's stale low byte only after exclusive ownership, then
; require an exact full-word zero readback before publishing aligned $013F.
        clr.w   COMM0_HI
        tst.w   COMM0_HI
        bne.s   .fail_stop
        move.w  #$013F,COMM0_HI
        ori.b   #$01,MARS_SYS_INTMASK+1
.wait_edge2_ack:
        btst    #0,MARS_SYS_INTMASK+1
        bne.s   .wait_edge2_ack

        move.w  (a7)+,sr
        rts

.fail_stop:
        bra.s   .fail_stop

; Q-027 lifecycle wrapper.  Fixed placement: file $01CB00-$01CB0D /
; 68K $0089CB00-$0089CB0D.
        dcb.b   ($01CB00-*),$FF
q027_scene_entry_wrapper:
        nop
        clr.b   VR60_1P_FLAG
        jmp     $00884A3E
