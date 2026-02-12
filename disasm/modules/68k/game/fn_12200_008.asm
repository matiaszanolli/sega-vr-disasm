; ============================================================================
; Camera Selection Counter (Replay Angle)
; ROM Range: $0136AA-$0136EA (64 bytes)
; ============================================================================
; Category: game
; Purpose: Data prefix (24 bytes), then code at $0136C2.
;   If D2 == 0: adds D0 to replay angle counter ($A01A), wraps 0-2.
;   If D2 != 0: reverts game_state by 4.
;
; Entry: D0 = increment/decrement, D2 = action flag
; Uses: D0, D2
; RAM:
;   $A01A: replay angle counter (word, range 0-2)
;   $C87E: game_state (word)
; ============================================================================

fn_12200_008:
        dc.w    $0089                           ; $0136AA  [data prefix]
        move.w  D2,(A3)+                        ; $0136AC  [data]
        dc.w    $0089                           ; $0136AE  [data]
        move.w  $0089(A2),(A3)+                 ; $0136B0  [data]
        move.w  -$77(A4,D0.W),-(A3)             ; $0136B4  [data]
        dc.w    $377A,$0089,$37C0               ; $0136B8  [data]
        dc.w    $0089                           ; $0136BE  [data]
        dc.w    $37F4                           ; $0136C0  [data]
        tst.w   D2                              ; $0136C2  action flag
        bne.s   .revert_state                   ; $0136C4  non-zero → revert
        add.w   D0,($FFFFA01A).w                ; $0136C6  add increment to counter
        tst.w   ($FFFFA01A).w                   ; $0136CA  counter < 0?
        bge.s   .check_max                      ; $0136CE  no → check max
        move.w  #$0002,($FFFFA01A).w            ; $0136D0  wrap to 2
.check_max:
        cmpi.w  #$0002,($FFFFA01A).w            ; $0136D6  counter <= 2?
        ble.s   .done                           ; $0136DC  yes → done
        clr.w   ($FFFFA01A).w                   ; $0136DE  wrap to 0
        bra.s   .done                           ; $0136E2
.revert_state:
        subq.w  #4,($FFFFC87E).w                ; $0136E4  revert game_state
.done:
        rts                                     ; $0136E8
