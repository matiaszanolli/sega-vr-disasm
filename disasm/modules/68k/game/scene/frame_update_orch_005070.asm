; ============================================================================
; Frame Update Orchestrator — ABSORBED by state_disp_005020 (VR60 Phase 8)
; ROM Range: $005070-$00509E (46 bytes)
; ============================================================================
;
; VR60 Phase 8: This function's work is now inlined in state_disp_005020
; which runs all 3 states sequentially every TV frame for 60 FPS.
; This space is used as overflow for the expanded state dispatcher.
;
; The assembler auto-fills with the sequential JSR calls from state_disp_005020.
; If the dispatcher ends before $00509E, pad with $FF to maintain alignment
; with frame_orch_00509e at $00509E.
; ============================================================================

; No code — space consumed by expanded state_disp_005020
; Pad to $00509E if state_disp_005020 doesn't reach here
        dcb.b   ($00509E - *), $FF
