; ============================================================================
; Object Drift Check + SFX Trigger
; ROM Range: $007D56-$007D82 (44 bytes)
; ============================================================================
; Category: game
; Purpose: Plays SFX $B5 (skid sound). Computes absolute difference between
;   heading_angle (A0+$40) and field_1E. Checks if speed_index > $0118
;   AND angle difference > $0800 — if both true and velocity_x ≠ 0, returns.
;   Otherwise branches to $007E0C (external) or $007D82 (fall-through).
;
; Entry: A0 = object pointer
; Uses: D0, A0
; Object fields:
;   A0+$04: speed_index (word)
;   A0+$1E: reference angle (word)
;   A0+$40: heading_angle (word)
;   A0+$8C: velocity_x (word)
; RAM:
;   $C8A4: sound effect (byte)
; ============================================================================

fn_6200_055:
        move.b  #$B5,($FFFFC8A4).w             ; $007D56  play SFX $B5 (skid)
        move.w  $0040(A0),D0                    ; $007D5C  D0 = heading_angle
        sub.w   $001E(A0),D0                    ; $007D60  D0 -= reference angle
        bpl.s   .positive                       ; $007D64  positive → skip negate
        neg.w   D0                              ; $007D66  D0 = |difference|
.positive:
        cmpi.w  #$0118,$0004(A0)                ; $007D68  speed_index ≤ $0118?
        dc.w    $6F00,$009C                     ; $007D6E  ble.w $007E0C → external (slow)
        cmpi.w  #$0800,D0                       ; $007D72  angle diff ≤ $0800?
        dc.w    $6F00,$0094                     ; $007D76  ble.w $007E0C → external (small angle)
        tst.w   $008C(A0)                       ; $007D7A  velocity_x == 0?
        dc.w    $6702                           ; $007D7E  beq.s $007D82 → fall through
        rts                                     ; $007D80
