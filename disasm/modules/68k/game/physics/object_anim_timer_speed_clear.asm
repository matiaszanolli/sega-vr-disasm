; ============================================================================
; Object Animation Timer + Speed Clear
; ROM Range: $007E74-$007EA4 (48 bytes)
; ============================================================================
; Category: game
; Purpose: 6-byte data prefix ($0101 × 3, referenced externally).
;   Code checks obj.field55 bit 1: if set → clears $C02A, done.
;   If clear: increments frame counter $C02A; when > 80 ($50):
;   clears counter, clears obj.speed ($06), loads obj.field1C into D0,
;   and jumps to external handler at $007EA4.
;
; Entry: A0 = object pointer
; Uses: D0, D1, A0
; Object fields:
;   A0+$06: speed (word, cleared on timeout)
;   A0+$1C: next state param (word, loaded into D0)
;   A0+$55: control flags (byte, bit 1)
; RAM:
;   $C02A: frame counter (word, counts to 80)
; ============================================================================

object_anim_timer_speed_clear:
; --- data: 3 words (referenced externally) ---
        dc.w    $0101,$0101,$0101               ; $007E74  data prefix
; --- code: animation timer ---
        btst    #1,$0055(A0)                    ; $007E7A  bit 1 set?
        bne.s   .clear_counter                  ; $007E80  yes → clear + done
        addq.w  #1,($FFFFC02A).w               ; $007E82  counter++
        cmpi.w  #$0050,($FFFFC02A).w           ; $007E86  counter > 80?
        ble.s   .done                           ; $007E8C  no → done
        clr.w   ($FFFFC02A).w                  ; $007E8E  reset counter
        clr.w   $0006(A0)                       ; $007E92  clear speed
        move.w  $001C(A0),D0                    ; $007E96  D0 = next state param
        dc.w    $4EFA,$0008                     ; $007E9A  jmp $007EA4(pc) → external handler
.clear_counter:
        clr.w   ($FFFFC02A).w                  ; $007E9E  clear counter
.done:
        rts                                     ; $007EA2
