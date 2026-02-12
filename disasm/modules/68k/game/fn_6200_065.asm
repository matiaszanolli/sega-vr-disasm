; ============================================================================
; Object Position Compare + Flag Set
; ROM Range: $008004-$008032 (46 bytes)
; ============================================================================
; Category: game
; Purpose: Compares object fields $2C/$2E (current/target position).
;   If equal: compares $24 vs $28 (progress vs threshold).
;   If $24 > $28: copies $24 → $28, checks $C319 sign bit,
;   and if negative: sets bit 14 of obj.flags ($02) and writes
;   $0050 to $C04E (timer/counter).
;
; Entry: A0 = object pointer
; Uses: D0, A0
; Object fields:
;   A0+$02: flags (word, bit 14 set on trigger)
;   A0+$24: progress value (word)
;   A0+$28: threshold value (word)
;   A0+$2C: current position (word)
;   A0+$2E: target position (word)
; RAM:
;   $C319: control flag (byte, bit 7 = sign)
;   $C04E: timer/counter (word, set to $0050)
; ============================================================================

fn_6200_065:
        move.w  $002C(A0),D0                    ; $008004  D0 = current position
        cmp.w   $002E(A0),D0                    ; $008008  == target?
        bne.s   .done                           ; $00800C  no → done
        move.w  $0024(A0),D0                    ; $00800E  D0 = progress
        cmp.w   $0028(A0),D0                    ; $008012  progress ≤ threshold?
        ble.s   .done                           ; $008016  yes → done
        move.w  $0024(A0),$0028(A0)             ; $008018  update threshold
        tst.b   ($FFFFC319).w                   ; $00801E  sign bit set?
        bpl.s   .done                           ; $008022  no (positive) → done
        ori.w   #$4000,$0002(A0)                ; $008024  set bit 14 of flags
        move.w  #$0050,($FFFFC04E).w           ; $00802A  set timer = $50
.done:
        rts                                     ; $008030
