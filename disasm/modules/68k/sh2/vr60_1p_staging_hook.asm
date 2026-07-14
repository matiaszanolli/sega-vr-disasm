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
; UPDATE (2026-07-13, later same session): this hook's own address range
; (state 8, "Path A" of game_frame_orch_013) is now confirmed DEAD CODE
; during real 1-player gameplay -- zero PC-histogram hits across four
; independent savestates (mid-race, near-countdown-end, from-loading with
; and without held input) and 28.5 million sampled 68K instructions from
; one savestate alone. State $C87E transits 0->4->8->12 at most once, very
; early (likely during scene init, before state_disp_004cb8 even becomes
; the active scene handler), then sticks at Path B (state $0C) for the rest
; of the race. Path B itself is lightweight (sound/controller/frame-counter/
; AI-buffer only) and is NOT the real per-frame game-logic driver either.
;
; The real per-frame entity/physics/AI driver was traced (partially) to
; `race_frame_main_dispatch_entity_updates` (disasm/modules/68k/game/race/
; race_frame_main_dispatch_entity_updates.asm) via race_entity_update_loop,
; which shows heavy, confirmed execution in every real-racing PC histogram
; this session. The exact recurring per-frame trigger for that function is
; not yet fully pinned down -- needs its own dedicated tracing session.
;
; DO NOT reuse this hook's insertion point (game_frame_orch_013's Path A)
; for any future 1P SH2-offload work -- it is provably unreachable during
; real gameplay. See analysis/VR60_PHASE1_CMD3E_ACK_HANG.md §15 for the
; full investigation. If a retry-based fix for cmd $3E/$3F is still needed
; once the real hook point is found: use BOUNDED retries (never loop
; forever on an ack), and land new logic in 1P-exclusive copies of
; vr60_*_transfer.asm/vr60_comm_trigger.asm rather than editing the shared
; files (they're also called unconditionally by the always-active 2P path).
; ============================================================================

vr60_1p_staging_hook:
        jsr     animated_seq_player+10
        jsr     object_update
        jmp     game_frame_orch_013_tail                 ; NOT rts — entered via
                                                          ; JMP, no return addr
                                                          ; pushed for this frame
