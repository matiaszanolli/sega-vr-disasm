; ============================================================================
; Proximity Zone Simple (Single Entity Pair)
; ROM Range: $008672-$0086C8 (86 bytes)
; ============================================================================
; Calculates proximity zone between entities (A0) and (A1).
; Zones: 0=far, 1=closest, 2=near, 3=approaching.
;
; Entry: A0 = entity, A1 = target entity
; Uses: D2, D4, D5, D6
; ============================================================================

proximity_zone_simple:
        move.w  #$0100,d4             ; Threshold 1 (unused - overwritten)
        move.w  #$0200,d5             ; Threshold 2 (near)
        move.w  #$1000,d6             ; Threshold 3 (approach)
        move.w  #$0000,$00C0(a1)      ; Default zone 0
        move.w  $0030(a1),d2          ; Target X position
        move.w  $0034(a1),d4          ; Target Z position (overwrites D4)
        sub.w   $0030(a0),d2          ; X difference
        bpl.s   .xpos
        neg.w   d2                    ; |X_diff|
.xpos:
        cmp.w   d6,d2                 ; X vs $1000
        bgt.s   .done                 ; Too far in X
        sub.w   $0034(a0),d4          ; Z difference
        bpl.s   .zpos
        neg.w   d4                    ; |Z_diff|
.zpos:
        cmp.w   d6,d4                 ; Z vs $1000
        bgt.s   .done                 ; Too far in Z
        move.w  #$0003,$00C0(a1)      ; Zone 3 (approaching)
        cmp.w   d5,d2                 ; X vs $0200
        bgt.s   .done
        cmp.w   d5,d4                 ; Z vs $0200
        bgt.s   .done
        move.w  #$0002,$00C0(a1)      ; Zone 2 (near)
        cmp.w   d4,d2                 ; X vs Z (closest axis check)
        bgt.s   .done
        cmp.w   d4,d4                 ; NOP (always EQ, BGT never taken)
        bgt.s   .done
        move.w  #$0001,$00C0(a1)      ; Zone 1 (closest)
.done:
        rts
