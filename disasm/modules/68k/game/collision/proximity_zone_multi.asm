; ============================================================================
; Proximity Zone Multi (Entity Loop with Camera Override)
; ROM Range: $0086C8-$00877A (178 bytes)
; ============================================================================
; Multi-entity proximity check with camera position override.
; Loops 15 entities at ($9100).W with $100 stride.
; 3 entry paths with different threshold sets based on flag bits.
;
; Entry: A0 = entity
; Uses: D0-D7, A1
; ============================================================================

proximity_zone_multi:
        move.w  $0030(a0),d0          ; Entity X
        move.w  $0034(a0),d1          ; Entity Z
        dc.w    $4A78,$C0BA           ; TST.W ($C0BA).W - camera override
        beq.s   .no_override
        dc.w    $3038,$C0BA           ; MOVE.W ($C0BA).W,D0 - override X
        dc.w    $3238,$C0BE           ; MOVE.W ($C0BE).W,D1 - override Z
.no_override:
        move.l  #$014001C0,d4         ; D4.H=$0140 D4.L=$01C0 (zone thresholds)
        move.w  #$0400,d5             ; Near threshold
        move.w  #$0800,d6             ; Approach threshold
        dc.w    $0838,$0000,$C313     ; BTST #0,($C313).W - mode flag
        bne.s   .start_loop
        move.w  #$0800,d5             ; Wide: near = $0800
        move.w  #$0FA0,d6             ; Wide: approach = $0FA0
        bra.s   .start_loop
.wide_mode:
        move.w  $0030(a0),d0
        move.w  $0034(a0),d1
        move.l  #$014001C0,d4
        move.w  #$02C0,d5
        move.w  #$1000,d6
.start_loop:
        moveq   #14,d7               ; 15 entities
        dc.w    $43F8,$9100           ; LEA ($9100).W,A1
.loop:
        move.w  #$0000,$00C0(a1)      ; Default zone 0
        move.w  $0030(a1),d2          ; Entity X
        sub.w   d0,d2                 ; X diff
        bpl.s   .xp
        neg.w   d2
.xp:   cmp.w   d6,d2                 ; X vs approach threshold
        bgt.s   .next
        move.w  $0034(a1),d3          ; Entity Z
        sub.w   d1,d3                 ; Z diff
        bpl.s   .zp
        neg.w   d3
.zp:   cmp.w   d6,d3                 ; Z vs approach threshold
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
        move.w  #$8002,$00C0(a1)      ; Zone inner 2 (bit 15 set)
        swap    d4
        cmp.w   d4,d2
        bgt.s   .next_swap
        cmp.w   d4,d3
        bgt.s   .next_swap
        move.w  #$8001,$00C0(a1)      ; Zone inner 1
.next_swap:
        swap    d4
.next: lea     $0100(a1),a1          ; Next entity (+$100)
        dbra    d7,.loop
        rts
