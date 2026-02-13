; ============================================================================
; Proximity Zone Loop (Fixed Thresholds)
; ROM Range: $00877A-$0087E2 (104 bytes)
; ============================================================================
; Simplified proximity loop over 15 entities. Fixed thresholds.
; 3 zone levels plus inner zone ($8001). Entity table at ($9100).W.
;
; Entry: A0 = entity
; Uses: D0-D7, A1
; ============================================================================

proximity_zone_loop:
        move.w  $0030(a0),d0          ; Entity X
        move.w  $0034(a0),d1          ; Entity Z
        move.w  #$0140,d4             ; Close threshold
        move.w  #$02C0,d5             ; Near threshold
        move.w  #$1000,d6             ; Approach threshold
        moveq   #14,d7               ; 15 entities
        dc.w    $43F8,$9100           ; LEA ($9100).W,A1
.loop:
        move.w  #$0000,$00C0(a1)      ; Default zone 0
        move.w  $0030(a1),d2
        sub.w   d0,d2
        bpl.s   .xp
        neg.w   d2
.xp:   cmp.w   d6,d2
        bgt.s   .next
        move.w  $0034(a1),d3
        sub.w   d1,d3
        bpl.s   .zp
        neg.w   d3
.zp:   cmp.w   d6,d3
        bgt.s   .next
        move.w  #$0003,$00C0(a1)      ; Zone 3
        cmp.w   d5,d2
        bgt.s   .next
        cmp.w   d5,d3
        bgt.s   .next
        move.w  #$0002,$00C0(a1)      ; Zone 2
        cmp.w   d4,d2
        bgt.s   .next
        cmp.w   d4,d3
        bgt.s   .next
        move.w  #$8001,$00C0(a1)      ; Zone inner 1
.next: lea     $0100(a1),a1
        dbra    d7,.loop
        rts
