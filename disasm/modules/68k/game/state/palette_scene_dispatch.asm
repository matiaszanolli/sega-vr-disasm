; ============================================================================
; palette_scene_dispatch ($00E90C-$00E926) — Palette Scene Dispatch
; ============================================================================
; CODE ($E90C-$E91A): JSR to init function, MOVE.W from ($C87E) index,
;   MOVEA.L indexed (d0,PC) into A1, JMP (A1)
; DATA ($E91C-$E926): 3 longword handler pointers:
;   Index 0: $0088E93A
;   Index 4: $0088EDDA
;   Index 8: $0088EEF2
; ============================================================================
palette_scene_dispatch:
        dc.w    $4EB9        ; $00E90C
        dc.w    $0088        ; $00E90E
        dc.w    $2080        ; $00E910
        dc.w    $3038        ; $00E912
        dc.w    $C87E        ; $00E914
        dc.w    $227B        ; $00E916
        dc.w    $0004        ; $00E918
        dc.w    $4ED1        ; $00E91A
        dc.w    $0088        ; $00E91C
        dc.w    $E93A        ; $00E91E
        dc.w    $0088        ; $00E920
        dc.w    $EDDA        ; $00E922
        dc.w    $0088        ; $00E924
        dc.w    $EEF2        ; $00E926
