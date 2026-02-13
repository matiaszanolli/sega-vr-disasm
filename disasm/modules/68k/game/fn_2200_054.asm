; ============================================================================
; fn_2200_054 — Object Proximity Check + Jump Table Dispatch
; ROM Range: $0037B6-$00385E (168 bytes)
; ============================================================================
; Checks distance between an object at ($FFFF9000) and up to 3 target objects.
; If any target is within $0C80 range in both X and Y, copies its data into
; the proximity buffer at $FF659C and dispatches via jump table at end.
;
; Jump table (6 longword entries) selects the next handler based on race_state.
;
; Entry: (implicit — uses RAM addresses directly)
; Uses: D0, D1, D2, D4, D7, A0, A1, A2
; RAM: $9000 (object_base), $C008 (proximity_counter),
;      $C8A0 (race_state)
; Object fields (via A0 at $9000):
;   +$30: x_position
;   +$34: y_position
; ============================================================================

fn_2200_054:
        lea     ($FFFF9000).w,A0                ; $0037B6  object base
        move.w  ($FFFFC8A0).w,D1                ; $0037BA  race_state
        lea     $00895A64,A1                    ; $0037BE  target object table (ROM)
        movea.l $00(A1,D1.W),A1                 ; $0037C4  table[race_state]
        lea     $00FF659C,A2                    ; $0037C8  proximity buffer
        move.w  #$0C80,D1                       ; $0037CE  proximity threshold
        moveq   #$02,D7                         ; $0037D2  check 3 targets
.check_target:
        move.w  $0030(A0),D2                    ; $0037D4  player X
        move.w  $0034(A0),D4                    ; $0037D8  player Y
        sub.w   (A1),D2                         ; $0037DC  delta X
        bpl.s   .x_positive                     ; $0037DE
        neg.w   D2                              ; $0037E0  abs(delta X)
.x_positive:
        cmp.w   D1,D2                           ; $0037E2  within threshold?
        bgt.s   .next_target                    ; $0037E4  no → skip
        sub.w   $0004(A1),D4                    ; $0037E6  delta Y
        bpl.s   .y_positive                     ; $0037EA
        neg.w   D4                              ; $0037EC  abs(delta Y)
.y_positive:
        cmp.w   D1,D4                           ; $0037EE  within threshold?
        bgt.s   .next_target                    ; $0037F0  no → skip
        move.w  #$0001,$0000(A2)                ; $0037F2  proximity flag = 1
        move.l  (A1)+,$0002(A2)                 ; $0037F8  copy target X/Y
        move.w  (A1)+,$0006(A2)                 ; $0037FC  copy target data
        move.w  (A1)+,$000A(A2)                 ; $003800
        move.w  (A1)+,$000E(A2)                 ; $003804
        movea.l (A1),A1                         ; $003808  follow linked list pointer
        move.w  ($FFFFC008).w,D0                ; $00380A  proximity counter
        addq.w  #1,D0                           ; $00380E
        cmpi.w  #$000C,D0                       ; $003810  wrap at 12
        bne.s   .store_counter                  ; $003814
        move.w  #$0000,D0                       ; $003816  reset to 0
.store_counter:
        move.w  D0,($FFFFC008).w                ; $00381A
        lsr.w   #1,D0                           ; $00381E  D0 /= 2
        dc.w    $D040                ; add.w   D0,D0  ; D0 *= 2
        dc.w    $D040                ; add.w   D0,D0  ; D0 *= 4 (longword index)
        move.l  $00(A1,D0.W),$0010(A2)          ; $003824  target animation frame
        bra.s   .dispatch                       ; $00382A
.next_target:
        lea     $000E(A1),A1                    ; $00382C  skip to next target entry
        dbra    D7,.check_target                ; $003830
        move.w  #$0000,$0000(A2)                ; $003834  proximity flag = 0
.dispatch:
        move.w  ($FFFFC8A0).w,D0                ; $00383A  race_state
        movea.l .jump_table(PC,D0.W),A1         ; $00383E  handler address
        jmp     (A1)                            ; $003842
; --- jump table (6 longword entries) ------------------------------------------
.jump_table:
        dc.l    $0088385E                       ; $003844  state 0 → $385E
        dc.l    $0088395C                       ; $003848  state 1 → $395C
        dc.l    $0088385C                       ; $00384C  state 2 → $385C
        dc.l    $00883AAA                       ; $003850  state 3 → $3AAA
        dc.l    $0088385C                       ; $003854  state 4 → $385C
        dc.l    $0088385C                       ; $003858  state 5 → $385C
        rts                                     ; $00385C
