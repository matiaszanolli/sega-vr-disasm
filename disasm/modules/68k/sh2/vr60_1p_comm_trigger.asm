; ============================================================================
; vr60_1p_comm_trigger — 1P-exclusive COMM relay trigger (cmd $3F)
; ============================================================================
;
; 1P-exclusive copy of vr60_comm_trigger.asm's protocol, with BOUNDED
; retries against the same Master-SH2 poll-detection race documented in
; analysis/VR60_PHASE1_CMD3E_ACK_HANG.md §13. Separate file so this can
; never again affect the shared 2P path (state4_epilogue calls the
; original vr60_comm_trigger unconditionally every frame).
;
; This trigger is fire-and-forget by design (Phase 2B's async pipeline
; depends on the caller NOT blocking on cmd $3F's full completion), so
; unlike the entity/globals transfers this cannot wait on a "done" signal
; -- but the handler (cmd3f_vr60_gameframe.asm) clears COMM0_LO back to
; $00 the moment it's entered, well before its block-copy/physics/AI work,
; as a fast "params consumed" signal. Used here as a low-latency entry-ack:
; force a genuine 0->1 transition on COMM0_HI, then check whether Master
; has already cleared COMM0_LO; if not, re-assert and retry, bounded to 16
; attempts. If exhausted, give up silently (matches the original's
; fire-and-forget contract -- a dropped cmd $3F this frame is a missed
; SH2 update, not a hang).
;
; The initial "wait for Master idle" spin is ALSO now bounded (was
; unbounded in the original) -- if Master never clears COMM0_HI, this
; gives up and skips the trigger for this frame rather than hanging.
;
; Preserves D0/D1 (scratch registers used for the retry), matching the
; original's "clobbers nothing visible to caller" contract.
;
; Called from: vr60_1p_staging_hook
; ============================================================================

vr60_1p_comm_trigger:
        movem.l d0/d1,-(sp)

; --- Wait for Master SH2 idle (bounded, max 64 checks) ---
        moveq   #63,d1
.wait_idle:
        tst.b   COMM0_HI                          ; Master busy? ($A15120)
        beq.s   .idle
        dbra    d1,.wait_idle
        bra.s   .exit                             ; still busy -- skip this frame

.idle:
; --- Write game state to COMM3-5 (all params BEFORE trigger) ---
        move.w  ($FFFFC964).w,COMM3               ; frame counter → $A15126
        move.w  ($FFFFC87E).w,COMM4                ; game state   → $A15128
        move.w  ($FFFFC80C).w,COMM5                ; frame toggle → $A1512A

; --- Trigger cmd $3F, bounded retry (max 16 attempts) against Master's
; fast "params consumed" entry-ack on COMM0_LO ---
        moveq   #15,d1
.retrigger:
        moveq   #0,d0
        move.b  d0,COMM0_HI                       ; force real transition: 0 first...
        move.b  #$3F,COMM0_LO                     ; dispatch index (re-assert each attempt)
        move.b  #$01,COMM0_HI                     ; ...then 1 (guaranteed 0->1)

        move.w  #99,d0                            ; ~600-cycle settle delay
.settle_delay:
        dbra    d0,.settle_delay

        tst.b   COMM0_LO                          ; Master clears this fast, on entry
        beq.s   .exit                             ; cleared -- entered successfully
        dbra    d1,.retrigger                     ; still $3F -- not entered yet, retry
                                                   ; (exhausted -- fall through to .exit)
.exit:
        movem.l (sp)+,d0/d1
        rts
