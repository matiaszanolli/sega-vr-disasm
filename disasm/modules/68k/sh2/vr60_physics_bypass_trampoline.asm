; ============================================================================
; vr60_physics_bypass_trampoline — VR60 Phase 3B: Orchestrator Bypass
; Size: ~30 bytes
; ============================================================================
;
; Called via JMP from entity_render_pipeline (Variant A, first 6 bytes).
; Replaces: JSR camera_state_selector+12(PC) + MOVEQ #$00,D0
;
; When $C8D2 = 0 (68K physics): runs the replaced instructions, then
;   jumps back to entity_render_pipeline+6 (MOVE.W D0,$0044(A0)).
;   68K physics pipeline runs normally.
;
; When $C8D2 != 0 (SH2 physics): runs the replaced instructions, then
;   jumps to entity_render_pipeline_position_ai (after all physics/timer
;   calls). SH2 handles physics+timers via cmd $3F.
;
; Entry: A0 = entity base pointer (from caller)
; Preserves: A0, all registers (same contract as entity_render_pipeline)
; ============================================================================

vr60_physics_bypass_trampoline:
; --- Execute the replaced instructions ---
        jsr     camera_state_selector+12        ; 6B — abs.l JSR (PC-relative can't reach from code_1c200)
        moveq   #$00,d0                         ; 2B — original second instruction

; --- Check SH2 physics flag ---
        tst.b   ($FFFFC8D2).w                   ; 4B — SH2 physics active?
        bne.s   .bypass_physics                  ; 2B — yes: skip to position+AI

; --- 68K physics path: return to orchestrator (display offset clear) ---
        jmp     entity_render_pipeline+6         ; 6B — continue at MOVE.W D0,$0044(A0)

.bypass_physics:
; --- SH2 physics path: clear display offsets, then skip to position+AI ---
        move.w  d0,$0044(a0)                    ; 4B — clear display_offset (D0=0 from MOVEQ)
        move.w  d0,$0046(a0)                    ; 4B — clear display_scale
        move.w  d0,$004A(a0)                    ; 4B — clear display_aux
        jmp     entity_render_pipeline_position_ai ; 6B — skip physics, enter at position+AI
; Total: ~38 bytes
