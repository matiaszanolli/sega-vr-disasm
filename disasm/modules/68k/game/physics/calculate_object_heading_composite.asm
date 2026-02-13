; ============================================================================
; Calculate Object Heading Composite
; ROM Range: $007636-$00764E (24 bytes)
; ============================================================================
; Computes a heading value: ($C0CA + $C0B0) * 8 + object+$3C +
; object+$96, storing the result in object+$CC.
;
; Memory:
;   $FFFFC0CA = heading base (word)
;   $FFFFC0B0 = segment 2 position (word)
; Entry: A0 = object pointer | Exit: +$CC updated | Uses: D0, A0
; ============================================================================

calculate_object_heading_composite:
        move.w  ($FFFFC0CA).w,d0                ; $007636: $3038 $C0CA — load heading base
        add.w   ($FFFFC0B0).w,d0                ; $00763A: $D078 $C0B0 — add segment 2 position
        asl.w   #3,d0                           ; $00763E: $E740 — multiply by 8
        add.w   $003C(a0),d0                    ; $007640: $D068 $003C — add heading mirror
        add.w   $0096(a0),d0                    ; $007644: $D068 $0096 — add offset field
        move.w  d0,$00CC(a0)                    ; $007648: $3140 $00CC — store composite heading
        rts                                     ; $00764C: $4E75

