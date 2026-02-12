; ============================================================================
; Input Guard + Conditional Decrement
; ROM Range: $008032-$008054 (34 bytes)
; ============================================================================
; Category: game
; Purpose: Guards against large position differences.
;   If input_state is active or obj+$2C >= 20: returns immediately.
;   If position difference (obj+$24 - obj+$26) > 100: decrements obj+$2E.
;   If difference <= 100: falls through to next function (no return).
;
; Entry: A0 = object pointer
; Uses: D0
; RAM:
;   $C07C: input_state (word)
; Object fields:
;   +$24: position value A (word)
;   +$26: position value B (word)
;   +$2C: guard threshold (word)
;   +$2E: adjustment counter (word, decremented)
; ============================================================================

fn_6200_066:
        tst.w   ($FFFFC07C).w                   ; $008032  test input_state
        bne.s   .done                           ; $008036  if active → return
        cmpi.w  #$0014,$002C(A0)                ; $008038  obj+$2C >= 20?
        bge.s   .done                           ; $00803E  yes → return
        move.w  $0024(A0),D0                    ; $008040  D0 = position A
        sub.w   $0026(A0),D0                    ; $008044  D0 = A - B (difference)
        cmpi.w  #$0064,D0                       ; $008048  difference <= 100?
        dc.w    $6F06                           ; $00804C  ble.s past_module — fall through
        subq.w  #1,$002E(A0)                    ; $00804E  decrement adjustment counter
.done:
        rts                                     ; $008052
