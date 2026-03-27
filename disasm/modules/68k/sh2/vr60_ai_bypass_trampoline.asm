; ============================================================================
; vr60_ai_bypass_trampoline_variant_b — Phase 4: AI Entity Physics Bypass
; Size: ~30 bytes
; ============================================================================
;
; Called via JMP from entity_render_pipeline Variant B (first 8 bytes).
; Replaces: JSR camera_state_selector+12 + JSR effect_timer_mgmt
;
; When $C8D2 = 0 (68K physics): runs the replaced instructions, then
;   jumps back to Variant B+8 (object_timer_expire_speed_param_reset).
;   68K physics+AI pipeline runs normally.
;
; When $C8D2 != 0 (SH2 physics): jumps directly to rendering section
;   (entity_render_pipeline_varb_rendering). SH2 cmd $3F entity loop
;   handles orchestrator + physics for AI entities.
;
; Entry: A0 = entity base pointer (from entity dispatch)
; Preserves: A0, all registers (same contract as entity_render_pipeline)
; ============================================================================

vr60_ai_bypass_trampoline_variant_b:
; --- Execute the replaced instructions ---
        jsr     camera_state_selector+12        ; 6B — abs.l (PC-relative can't reach)
        jsr     effect_timer_mgmt               ; 6B — abs.l

; --- Check SH2 physics flag ---
        tst.b   ($FFFFC8D2).w                   ; 4B — SH2 physics active?
        bne.s   .bypass_ai                       ; 2B — yes: skip to rendering

; --- 68K physics path: return to Variant B physics section ---
        jmp     entity_render_pipeline_varb_physics ; 6B — continue at timer_expire_reset

.bypass_ai:
; --- SH2 physics path: skip all physics+AI, jump to rendering ---
        jmp     entity_render_pipeline_varb_rendering ; 6B
; Total: ~30 bytes
