; ============================================================================
; Menu State Dispatch 042
; ROM Range: $01440E-$01446C (94 bytes)
; ============================================================================
; Category: game
; Purpose: Menu state dispatcher with 8-entry jump table
;   State 0: clears substate + fade, advances state
;   State 1: loads DMA transfer, calls menu_state_check
;   State 2: countdown timer, advances when done
;
; Uses: D0, D1, A0, A1, A2, A4
; RAM:
;   $C082: menu_state (dispatch index, increments by 4)
;   $C084: menu_substate
;   $A006: menu_timer
;   $A008: fade_counter
; Calls:
;   $0145F0: menu_state_check
; Confidence: high
; ============================================================================

fn_14200_042:
        move.w  ($FFFFC082).w,D0                ; $01440E  D0 = menu_state
        movea.l $014418(PC,D0.W),A1             ; $014412  A1 = jump table[D0]
        jmp     (A1)                            ; $014416
; --- jump table (8 longword entries) ---
        dc.l    $00894438                       ; $014418  [00] → .state_0
        dc.l    $00894450                       ; $01441C  [04] → .state_1
        dc.l    $0089446C                       ; $014420  [08] → .state_2 (past fn)
        dc.l    $008944A8                       ; $014424  [0C] → external
        dc.l    $008944D0                       ; $014428  [10] → external
        dc.l    $008944F2                       ; $01442C  [14] → external
        dc.l    $00894518                       ; $014430  [18] → external
        dc.l    $00894540                       ; $014434  [1C] → external
; --- state 0: init ---
.state_0:
        clr.w   ($FFFFC084).w                   ; $014438  menu_substate = 0
        clr.w   ($FFFFA008).w                   ; $01443C  fade_counter = 0
        addq.w  #4,($FFFFC082).w                ; $014440  menu_state += 4 (next state)
; --- state 1: DMA load + check ---
.state_1:
        move.w  #$001E,($FFFFA006).w            ; $014444  menu_timer = 30
        move.w  #$0801,($FFFFA008).w            ; $01444A  fade_counter = $0801
        lea     $0090E732,A1                    ; $014450  A1 → DMA source
        move.l  #$00009A00,D1                   ; $014456  D1 = DMA length/dest
        dc.w    $4EBA,$0192         ; JSR     $0145F0(PC); $01445C  menu_state_check
; --- state 2: countdown ---
        subq.w  #1,($FFFFA006).w                ; $014460  menu_timer--
        bgt.s   .done                           ; $014464  > 0 → wait
        addq.w  #4,($FFFFC082).w                ; $014466  menu_state += 4 (next state)
.done:
        rts                                     ; $01446A
