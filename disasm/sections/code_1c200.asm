; ============================================================================
; Code Section ($01C200-$01E1FF)
;
; Original data: 8 bytes at $01C200-$01C207
; Optimization code: $01C208-$01E1FF (8,184 bytes available)
;
; ADDRESSING:
;   File offsets:  $01C208 - $01E1FF
;   68K addresses: $89C208 - $89E1FF  (= $880000 + file_offset)
;
;   Cross-section callers MUST use absolute 68K addresses:
;     jsr $0089C208    ; NOT jsr vrd_opt_start (wrong address space)
;
;   Within this section, use PC-relative (BSR/BRA) for local calls.
; ============================================================================

        org     $01C200

; --- Original data (preserved byte-identical) ---
        dc.w    $0000        ; $01C200
        dc.w    $0000        ; $01C202
        dc.w    $0200        ; $01C204
        dc.w    $0020        ; $01C206

; ============================================================================
; RESERVED OPTIMIZATION CODE AREA
; File:  $01C208 - $01E1FF (8,184 bytes)
; 68K:   $89C208 - $89E1FF
;
; Originally unused ($FF padding) in the retail ROM. Reserved for future
; 68K optimization routines. Currently filled with $FF to match original.
;
; Optimization modules are in disasm/modules/68k/optimization/ but NOT
; included here until their hook points are activated.
; ============================================================================

; --- S-1: LOD culling enhanced sprite param update (relocated from code_2200) ---
        include "modules/68k/game/render/object_table_sprite_param_update.asm"

; --- VR60 Phase 1B: COMM relay trigger (50 bytes, called via JSR abs.l from code_2200) ---
        include "modules/68k/sh2/vr60_comm_trigger.asm"

; --- VR60 60 FPS: V-INT handlers (Phase 7 wrappers kept for non-racing modes) ---
        include "modules/68k/vint/vint_vdp_sync_with_swap.asm"
        include "modules/68k/vint/vint_sprite_cfg_with_swap.asm"

; --- VR60 Phase 8: Unified V-INT handler (VDP sync + sprite cfg + frame swap) ---
        include "modules/68k/vint/vint_unified_60fps.asm"

; --- VR60 Phase 3B: physics bypass trampoline (called via JMP from entity_render_pipeline) ---
        include "modules/68k/sh2/vr60_physics_bypass_trampoline.asm"

; --- VR60 Phase 4: AI bypass trampoline (called via JMP from Variant B) ---
        include "modules/68k/sh2/vr60_ai_bypass_trampoline.asm"

; --- VR60 Phase 3A/3B: entity+globals staging + DREQ transfer (called via JSR abs.l from code_2200) ---
        include "modules/68k/sh2/vr60_entity_stage.asm"
        include "modules/68k/sh2/vr60_globals_stage.asm"
        include "modules/68k/sh2/vr60_entity_transfer.asm"
        include "modules/68k/sh2/vr60_globals_transfer.asm"

; --- VR60 Phase 4: AI entity staging + DREQ transfer (first frame only) ---
        include "modules/68k/sh2/vr60_ai_entity_stage.asm"
        include "modules/68k/sh2/vr60_ai_entity_transfer.asm"

; --- VR60 Phase 1P: 1-player-exclusive copies of the DREQ transfer + cmd $3F
; trigger functions, with BOUNDED retries against the Master-SH2 poll-
; detection race (analysis/VR60_PHASE1_CMD3E_ACK_HANG.md §13). Separate
; files from the shared vr60_*_transfer.asm/vr60_comm_trigger.asm above --
; those are called unconditionally every frame by the always-active 2P path
; (state4_epilogue) and must never carry unverified retry logic again after
; the 2026-07-13 black-screen incident (§13.2-13.3). ---
        include "modules/68k/sh2/vr60_1p_entity_transfer.asm"
        include "modules/68k/sh2/vr60_1p_ai_entity_transfer.asm"
        include "modules/68k/sh2/vr60_1p_globals_transfer.asm"
        include "modules/68k/sh2/vr60_1p_comm_trigger.asm"

; --- VR60 Phase 1P: 1-player interactive racing staging + cmd $3F trigger ---
; Patched into game_frame_orch_013 (code_4200.asm) — see file header for why
; this lives here (equal-size swap; cross-section abs.l JSR convention).
        include "modules/68k/sh2/vr60_1p_staging_hook.asm"

        dcb.b   ($01E200-*),$FF
