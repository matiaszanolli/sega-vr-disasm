; ============================================================================
; vr60_1p_staging_hook — VR60 1P interactive racing: staging + cmd $3F trigger
; ============================================================================
;
; Full Phase 1 body: mirrors state4_epilogue (code_2200.asm, the built but
; unvalidated 2P integration) in staging/transfer/relay call order, but calls the
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
; attempts, ~600-cycle settle delay each) defensively around a suspected,
; unproven Master-SH2 poll-detection race discussed in that analysis (§13).
; The bounded retry is defensive; it is not proof that the race is the root
; cause. An earlier attempt applied an UNBOUNDED version of this same
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
; CURRENT STATE (2026-07-25): the promoted ordinary build defines
; VR60_MODE0_ONLY and executes the accepted cmd $3E mode-0 transfer exactly
; once per eligible lifecycle. The mode-1 block and relay below are therefore
; unreachable in that build. Mode 1, AI entity transfer (mode 2), and cmd $3F
; remain DISABLED and UNVERIFIED. See VR60_STATUS.md and
; analysis/evidence/vr60-q020-mode0-gate/ for the exact accepted scope.
; ============================================================================

VR60_1P_FLAG    equ     $FFFF7B40

vr60_1p_staging_hook:
        tst.b   VR60_1P_FLAG
        ifd     VR60_MODE0_ONLY
        bne.s   .original_calls
        else
        bne.s   .globals_only
        endif
; --- First frame: player entity + globals staging (AI mode 2 remains gated) ---
        jsr     vr60_entity_stage                 ; 256B player WRAM -> $FF6A00
        jsr     vr60_globals_stage                 ; 64B scattered -> $FF6B00
        ifd     VR60_MODE0_ONLY
        ifd     VR60_MODE0_STAGE_CONTROL
        nop                                         ; paired stage-control: no DREQ
        nop                                         ; exact 6-byte replacement for JSR
        nop
        else
        jsr     .mode0_transfer                    ; explicit mode 0 + DREQ transfer
        endif
        else
        jsr     vr60_1p_entity_transfer            ; DREQ 320B -> SDRAM (cmd $3E mode 0)
        endif
; VALIDATION GATE: AI transfer stays disabled until a trustworthy control
; fixture passes, then must be tested independently of cmd $3F.
;        jsr     vr60_ai_entity_stage               ; 3840B AI WRAM -> $FF6B40
;        jsr     vr60_1p_ai_entity_transfer          ; DREQ 3840B -> SDRAM (cmd $3E mode 2)
        move.b  #$01,VR60_1P_FLAG
        ifd     VR60_MODE0_ONLY
        bra.s   .original_calls
        else
        bra.s   .relay
        endif
.globals_only:
        ifd     VR60_MODE0_ONLY
; The promoted mode-0-only build reuses the original 12-byte mode-1 slot
; as a tail-call stub. MOVE.B #imm,abs.l is 8 bytes and BRA.W is 4 bytes, so
; the complete hook layout and every following ROM address remain unchanged.
; The JSR above supplies the return address consumed by the transfer's RTS.
.mode0_transfer:
        move.b  #$00,COMM3                         ; explicit COMM3_HI mode 0
        bra.w   vr60_1p_entity_transfer            ; tail-call; returns to first-hit block
        else
; --- Subsequent frames: globals only ---
        jsr     vr60_globals_stage                 ; 64B scattered -> $FF6B00
        jsr     vr60_1p_globals_transfer           ; DREQ 64B -> SDRAM (cmd $3E mode 1)
        endif
.relay:
; --- Dormant relay slots; values are stale/zero while cmd $3F stays disabled ---
        move.b  COMM6,($FFFFC8A4).w               ; sound trigger
        clr.b   COMM6                              ; clear
        move.w  COMM4,$00FF617A                    ; viewport left
        move.w  COMM5,$00FF618E                    ; viewport right
; --- Fire-and-forget: async block copies + physics via cmd $3F ---
; VALIDATION GATE: cmd $3F stays disabled until a trustworthy baseline exists.
; First run it as observable shadow computation with the 68K authoritative;
; do not enable the physics bypass or infer causality from fb_crc alone.
; The §21 freeze attribution was retracted by §22 because the fixture freezes
; independently of this hook.
;        jsr     vr60_1p_comm_trigger                ; writes COMM3-5 + triggers cmd $3F
.original_calls:
        jsr     animated_seq_player+10
        jsr     object_update
        ifd     VR60_MODE0_ONLY
        jmp     $00884D6A                              ; preserve exact accepted raw PC
        else
        jmp     game_frame_orch_013_tail                 ; NOT rts — entered via
                                                          ; JMP, no return addr
                                                          ; pushed for this frame
        endif
