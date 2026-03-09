; ============================================================================
; conditional_update_check ($006D00-$006D2E) — Conditional Update Check
; ============================================================================
; CODE: 48 bytes — BSR target called by conditional_pos_add,
; conditional_speed_add, conditional_pos_subtract, conditional_speed_subtract.
; Tests bit 2 of $C313, selects offset, adds from $C8A0 twice, builds
; address into $FF301A, and loops comparing entries.
; ============================================================================
conditional_update_check:
        dc.w    $7E00        ; $006D00
        dc.w    $0838        ; $006D02
        dc.w    $0002        ; $006D04
        dc.w    $C313        ; $006D06
        dc.w    $6702        ; $006D08
        dc.w    $7E04        ; $006D0A
        dc.w    $DE78        ; $006D0C
        dc.w    $C8A0        ; $006D0E
        dc.w    $DE78        ; $006D10
        dc.w    $C8A0        ; $006D12
        dc.w    $45F9        ; $006D14
        dc.w    $00FF        ; $006D16
        dc.w    $301A        ; $006D18
        dc.w    $2272        ; $006D1A
        dc.w    $7000        ; $006D1C
        dc.w    $3238        ; $006D1E
        dc.w    $C0BA        ; $006D20
        dc.w    $3E19        ; $006D22
        dc.w    $B251        ; $006D24
        dc.w    $670C        ; $006D26
        dc.w    $43E9        ; $006D28
        dc.w    $0010        ; $006D2A
        dc.w    $51CF        ; $006D2C
        dc.w    $FFF6        ; $006D2E
