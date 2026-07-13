; ============================================================================
; vr60_1p_staging_hook — VR60 1P interactive racing: staging + cmd $3F trigger
; ============================================================================
;
; Currently INERT: bare re-issue of the two displaced calls, no staging, no
; SH2 offload. This is the ONLY state of this hook confirmed safe against
; real gameplay so far -- confirmed via manual PicoDrive test that this
; passthrough is behaviorally identical to the unmodified game (no black
; screen, no hang).
;
; History: a fuller body (entity/AI/globals staging + DREQ transfer + cmd
; $3F trigger, each using a forced-0->1-transition retry loop to work around
; a suspected Master-SH2 poll-detection race -- analysis/VR60_PHASE1_CMD3E_
; ACK_HANG.md) was headlessly "verified working" earlier, but that
; verification never actually exercised real GP racing: --autoplay only
; ever reaches Free Run ($5586), which doesn't call this hook at all. The
; first real GP racing test hard-hung the 68K (black screen, sound still
; running) -- almost certainly the unbounded `.retrigger` loop in
; vr60_entity_transfer.asm (and the same pattern in vr60_ai_entity_transfer/
; vr60_globals_transfer/vr60_comm_trigger.asm) spinning forever on an ACK
; that never arrived. All four of those files were reverted to HEAD (their
; original, always-shipped synchronous form) since they are NOT 1P-exclusive
; -- state4_epilogue (2P, code_2200.asm) calls all four unconditionally
; every frame, so an unverified change to any of them is a change to
; already-working functionality, not just to this dormant hook.
;
; Before re-attempting SH2 offload here: get a real GP-racing savestate
; (VRD_LOAD_STATE, added to profiling_frontend.c this session) for headless
; testing, use BOUNDED retries (never loop forever on an ack), and land any
; new retry logic in 1P-exclusive copies of these functions rather than
; editing the shared vr60_*_transfer.asm/vr60_comm_trigger.asm files, so a
; wrong fix can never again hang the already-working 2P/demo path.
; ============================================================================

vr60_1p_staging_hook:
        jsr     animated_seq_player+10
        jsr     object_update
        jmp     game_frame_orch_013_tail                 ; NOT rts — entered via
                                                          ; JMP, no return addr
                                                          ; pushed for this frame
