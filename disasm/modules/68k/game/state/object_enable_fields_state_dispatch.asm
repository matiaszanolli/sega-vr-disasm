; ============================================================================
; Object Enable Fields + State Dispatch
; ROM Range: $002A72-$002AAA (56 bytes)
; ============================================================================
; Category: game
; Purpose: Sets 5 enable fields on object (A1) to 1 ($00/+$14/+$28/+$3C/+$50).
;   Then dispatches on object param_8a (A0+$8A):
;     == 0: exits to $002AC4 (past fn)
;     == 1: exits to $002AAA (past fn)
;     >= 2: copies $C74C to A1+$24 (position), sets field +$64
;       based on velocity_x (A0+$8C): nonzero → $0000, zero → $0001.
;
; Uses: D0, A0, A1
; RAM:
;   $C74C: position value (long)
; Object (A0):
;   +$8A: param_8a (word, dispatch key)
;   +$8C: velocity_x (word)
; Object (A1):
;   +$00/+$14/+$28/+$3C/+$50: enable flags (word, set to 1)
;   +$24: position (long, set from $C74C)
;   +$64: direction flag (word, 0 or 1)
; ============================================================================

object_enable_fields_state_dispatch:
        moveq   #$01,D0                         ; $002A72  D0 = 1
        move.w  D0,(A1)                         ; $002A74  field +$00 = 1
        move.w  D0,$0014(A1)                   ; $002A76  field +$14 = 1
        move.w  D0,$0028(A1)                   ; $002A7A  field +$28 = 1
        move.w  D0,$003C(A1)                   ; $002A7E  field +$3C = 1
        move.w  D0,$0050(A1)                   ; $002A82  field +$50 = 1
        move.w  $008A(A0),D0                   ; $002A86  D0 = param_8a
        dc.w    $6738                           ; $002A8A  beq.s $002AC4 → exit (past fn, state 0)
        subq.w  #1,D0                           ; $002A8C  param_8a == 1?
        dc.w    $671A                           ; $002A8E  beq.s $002AAA → exit (past fn, state 1)
        move.l  ($FFFFC74C).w,$0024(A1)        ; $002A90  A1+$24 = position from $C74C
        move.w  #$0001,$0064(A1)               ; $002A96  direction = 1 (default)
        tst.w   $008C(A0)                      ; $002A9C  velocity_x == 0?
        dc.w    $673A                           ; $002AA0  beq.s $002ADC → exit (past fn, vel=0)
        move.w  #$0000,$0064(A1)               ; $002AA2  direction = 0 (has velocity)
        rts                                     ; $002AA8
