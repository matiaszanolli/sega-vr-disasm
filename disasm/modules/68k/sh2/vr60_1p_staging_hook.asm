; ============================================================================
; vr60_1p_staging_hook — VR60 1P interactive racing: staging + cmd $3F trigger
; ============================================================================
;
; Full Phase 1 body: mirrors state4_epilogue (code_2200.asm, the proven 2P
; integration) exactly in staging/transfer/relay call order, but calling the
; 1P-EXCLUSIVE copies of the transfer/trigger functions (vr60_1p_entity_
; transfer.asm, vr60_1p_ai_entity_transfer.asm, vr60_1p_globals_transfer.asm,
; vr60_1p_comm_trigger.asm) rather than the shared vr60_*_transfer.asm/
; vr60_comm_trigger.asm files that state4_epilogue (2P) also uses.
;
; This hook's insertion point (game_frame_orch_013, "Path A", state 8 of
; state_disp_004cb8) was investigated at length this session (2026-07-13):
; briefly suspected dead code (a false negative from PC-histogram top-200
; truncation), then confirmed via VRD_CALLER_TRACE (an exact, non-truncated
; JSR-return-address counter) to fire reliably every ~3 frames (20 Hz),
; exactly matching the documented game-tick rate. See analysis/VR60_PHASE1_
; CMD3E_ACK_HANG.md §15-§20 for the full investigation -- this hook's
; location is confirmed valid, no relocation needed.
;
; The 1P-exclusive transfer/trigger functions use a BOUNDED retry (max 16
; attempts, ~600-cycle settle delay each) against the Master-SH2 poll-
; detection race documented in that same analysis (§13): a one-shot COMM0
; trigger can land while Master is transiently busy elsewhere and never
; wake it. An earlier attempt applied an UNBOUNDED version of this same
; retry directly to the SHARED vr60_*_transfer.asm/vr60_comm_trigger.asm
; files (also called unconditionally every frame by 2P's state4_epilogue)
; and hard-hung the 68K in real gameplay (black screen, §13.2-13.3) --
; hence separate, bounded, 1P-exclusive copies here. If any attempt is
; exhausted without an ACK, the affected transfer/trigger is skipped for
; that frame rather than blocking -- a dropped SH2 update, not a hang.
;
; Physics bypass stays OFF (vr60_physics_bypass_trampoline's flag is
; untouched here) -- this phase only proves the staging+trigger chain
; reaches the SH2 side; gameplay logic remains on the 68K.
;
; CURRENT STATE (2026-07-16): entity_transfer + globals_transfer (cmd $3E
; modes 0/1) are ACTIVE and confirmed clean (fb_crc matches the ~724-unique-
; hash baseline over 1800 frames, no hang). AI entity transfer (cmd $3E
; mode 2) and the cmd $3F trigger are DISABLED below -- both independently
; caused an fb_crc freeze (3-4 unique hashes instead of ~724) when tested.
; See analysis/VR60_PHASE1_CMD3E_ACK_HANG.md §21 for the isolation results
; and what's needed before re-enabling either one.
; ============================================================================

VR60_1P_FLAG    equ     $FFFF7B40

vr60_1p_staging_hook:
        tst.b   VR60_1P_FLAG
        bne.s   .globals_only
; --- First frame: full entity + globals + AI staging ---
        jsr     vr60_entity_stage                 ; 256B player WRAM -> $FF6A00
        jsr     vr60_globals_stage                 ; 64B scattered -> $FF6B00
        jsr     vr60_1p_entity_transfer            ; DREQ 320B -> SDRAM (cmd $3E mode 0)
; DIAGNOSTIC (temporary): AI transfer disabled to isolate the fb_crc freeze
;        jsr     vr60_ai_entity_stage               ; 3840B AI WRAM -> $FF6B40
;        jsr     vr60_1p_ai_entity_transfer          ; DREQ 3840B -> SDRAM (cmd $3E mode 2)
        move.b  #$01,VR60_1P_FLAG
        bra.s   .relay
.globals_only:
; --- Subsequent frames: globals only ---
        jsr     vr60_globals_stage                 ; 64B scattered -> $FF6B00
        jsr     vr60_1p_globals_transfer           ; DREQ 64B -> SDRAM (cmd $3E mode 1)
.relay:
; --- Sound + viewport pickup from previous frame's cmd $3F ---
        move.b  COMM6,($FFFFC8A4).w               ; sound trigger
        clr.b   COMM6                              ; clear
        move.w  COMM4,$00FF617A                    ; viewport left
        move.w  COMM5,$00FF618E                    ; viewport right
; --- Fire-and-forget: async block copies + physics via cmd $3F ---
; DIAGNOSTIC (temporary, disabled 2026-07-16): cmd $3F causes an fb_crc
; freeze (4 unique hashes/1800 frames vs ~724 baseline) even with AI
; transfer disabled above -- cmd3f_vr60_gameframe.asm's AI entity loop
; unconditionally processes 15 entities from SDRAM $06010000 regardless of
; whether the 68K side ever staged them, so disabling AI staging without
; also disabling this trigger left it processing garbage data. Likely
; stalls Master SH2 in that loop, starving the real per-frame Slave
; render re-trigger. Needs its own dedicated investigation -- see
; analysis/VR60_PHASE1_CMD3E_ACK_HANG.md §21. Do not re-enable without
; re-verifying via VRD_FB_CRC against this session's savestate first.
;        jsr     vr60_1p_comm_trigger                ; writes COMM3-5 + triggers cmd $3F
        jsr     animated_seq_player+10
        jsr     object_update
        jmp     game_frame_orch_013_tail                 ; NOT rts — entered via
                                                          ; JMP, no return addr
                                                          ; pushed for this frame
