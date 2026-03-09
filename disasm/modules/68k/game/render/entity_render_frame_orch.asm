; ============================================================================
; entity_render_frame_orch ($00617A-$0061FE) — Entity Render Frame Orchestrator
; ============================================================================
; CODE: 134 bytes — entity field clears, 21 BSR calls, flag tests
; Called after entity_render_pipeline_with_vdp_dma; orchestrates per-frame
; entity rendering by testing flags, clearing fields, and dispatching to
; 21 subsystems via BSR.
; ============================================================================
entity_render_frame_orch:
        dc.w    $0838        ; $00617A
        dc.w    $0000        ; $00617C
        dc.w    $C80E        ; $00617E
        dc.w    $6600        ; $006180
        dc.w    $00D6        ; $006182
        dc.w    $11FC        ; $006184
        dc.w    $0001        ; $006186
        dc.w    $C800        ; $006188
        dc.w    $7000        ; $00618A
        dc.w    $3140        ; $00618C
        dc.w    $0044        ; $00618E
        dc.w    $3140        ; $006190
        dc.w    $0046        ; $006192
        dc.w    $3140        ; $006194
        dc.w    $004A        ; $006196
        dc.w    $4EBA        ; $006198
        dc.w    $1F32        ; $00619A
        dc.w    $4EBA        ; $00619C
        dc.w    $23AA        ; $00619E
        dc.w    $4EBA        ; $0061A0
        dc.w    $3660        ; $0061A2
        dc.w    $4EBA        ; $0061A4
        dc.w    $1CD4        ; $0061A6
        dc.w    $4EBA        ; $0061A8
        dc.w    $0DEE        ; $0061AA
        dc.w    $4EBA        ; $0061AC
        dc.w    $1B2A        ; $0061AE
        dc.w    $4EBA        ; $0061B0
        dc.w    $0EF8        ; $0061B2
        dc.w    $4EBA        ; $0061B4
        dc.w    $0F94        ; $0061B6
        dc.w    $4EBA        ; $0061B8
        dc.w    $1494        ; $0061BA
        dc.w    $4EBA        ; $0061BC
        dc.w    $1D92        ; $0061BE
        dc.w    $4EBA        ; $0061C0
        dc.w    $3B0C        ; $0061C2
        dc.w    $4EBA        ; $0061C4
        dc.w    $4A78        ; $0061C6
        dc.w    $4EBA        ; $0061C8
        dc.w    $398A        ; $0061CA
        dc.w    $4EBA        ; $0061CC
        dc.w    $24FA        ; $0061CE
        dc.w    $4EBA        ; $0061D0
        dc.w    $CF54        ; $0061D2
        dc.w    $4EBA        ; $0061D4
        dc.w    $CF8A        ; $0061D6
        dc.w    $4EBA        ; $0061D8
        dc.w    $144A        ; $0061DA
        dc.w    $4EBA        ; $0061DC
        dc.w    $1170        ; $0061DE
        dc.w    $4EBA        ; $0061E0
        dc.w    $D4FC        ; $0061E2
        dc.w    $4EBA        ; $0061E4
        dc.w    $D5D0        ; $0061E6
        dc.w    $4EBA        ; $0061E8
        dc.w    $DD9C        ; $0061EA
        dc.w    $4EBA        ; $0061EC
        dc.w    $2E76        ; $0061EE
        dc.w    $11F8        ; $0061F0
        dc.w    $C304        ; $0061F2
        dc.w    $C30C        ; $0061F4
        dc.w    $3038        ; $0061F6
        dc.w    $C8A0        ; $0061F8
        dc.w    $0838        ; $0061FA
        dc.w    $0007        ; $0061FC
        dc.w    $C81C        ; $0061FE
