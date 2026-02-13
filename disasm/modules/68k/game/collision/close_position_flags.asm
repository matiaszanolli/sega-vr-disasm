; ============================================================================
; Close Position Flags
; ROM Range: $00AFC2-$00AFFC (58 bytes)
; ============================================================================
; Stores speed param D1 to A0+$06, then sets status flag bits based on
; direction flags in A0+$88 (same logic as entity_target_action .close_position).
; Swaps bit 12/13 assignment between A0 and A1 based on direction bits 0 and 2.
; Sets AI mode byte to $B2 in ($C8A4).W.
;
; Entry: A0 = entity, A1 = target, D1 = speed param value
; Uses: D0, D1
; Fields accessed:
;   A0+$02: Status flags (ORI.W bit-set)
;   A1+$02: Status flags (ORI.W bit-set)
;   A0+$06: Speed param (written with D1)
;   A0+$88: Direction flags (tested bits 0, 2)
; RAM:
;   ($C8A4).W: Active AI mode byte (set to $B2)
; ============================================================================

close_position_flags:
        move.w  d1,$06(a0)              ; Store speed param
        move.w  $88(a0),d0              ; Load direction flags
        moveq   #1,d1                   ; Test bit 0
        and.w   d0,d1
        bne.s   .alt_bits               ; If bit 0 set, use alternate
        moveq   #4,d1                   ; Test bit 2
        and.w   d0,d1
        bne.s   .alt_bits               ; If bit 2 set, use alternate
        ori.w   #$2000,$02(a0)          ; Set bit 13 in A0 flags
        ori.w   #$1000,$02(a1)          ; Set bit 12 in A1 flags
        dc.w    $11FC,$00B2,$C8A4       ; MOVE.B #$B2,($C8A4).W - set AI mode
        rts
.alt_bits:
        ori.w   #$1000,$02(a0)          ; Set bit 12 in A0 flags
        ori.w   #$2000,$02(a1)          ; Set bit 13 in A1 flags
        dc.w    $11FC,$00B2,$C8A4       ; MOVE.B #$B2,($C8A4).W - set AI mode
        rts
