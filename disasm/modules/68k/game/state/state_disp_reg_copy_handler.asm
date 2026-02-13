; ============================================================================
; State Dispatcher + Register Copy Handler
; ROM Range: $008CCE-$008D06 (56 bytes)
; ============================================================================
; Category: game
; Purpose: Reads state index from $C896, dispatches via PC-relative word-offset
;   jump table (4 entries for states 0/2/4/6). After handler returns,
;   jumps to $888DC0 (shared exit).
;   State 0 handler (within this fn): copies 3 word pairs from $C0BA/$C0BC/$C0BE
;   to $C8F8/$C892/$C894, sets $C8F6=5, advances state by 2.
;   States 2/4/6 handlers are external (at $008D06/$008D12/$008D52).
;
; Uses: D0
; RAM:
;   $C896: state index (byte, 0/2/4/6)
;   $C0BA: source param A (word)
;   $C0BC: source param B (word)
;   $C0BE: source param C (word)
;   $C892: target param B (word)
;   $C894: target param C (word)
;   $C8F6: counter/flag (byte, set to 5)
;   $C8F8: target param A (word)
; Calls:
;   $00888DC0: shared exit
; ============================================================================

state_disp_reg_copy_handler:
; --- dispatcher ---
        move.b  ($FFFFC896).w,D0               ; $008CCE  D0 = state index
        move.w  .jump_table(PC,D0.W),D0        ; $008CD2  D0 = handler offset
        jsr     .jump_table(PC,D0.W)           ; $008CD6  call handler
        jmp     $00888DC0                       ; $008CDA  shared exit
; --- jump table (4 word offsets from table base) ---
.jump_table:
        dc.w    $0008                           ; $008CE0  state 0 → .handler_0
        dc.w    $0026                           ; $008CE2  state 2 → $008D06 (external)
        dc.w    $0032                           ; $008CE4  state 4 → $008D12 (external)
        dc.w    $0072                           ; $008CE6  state 6 → $008D52 (external)
; --- state 0 handler: copy register triplet ---
.handler_0:
        move.w  ($FFFFC0BA).w,($FFFFC8F8).w    ; $008CE8  copy param A
        move.w  ($FFFFC0BC).w,($FFFFC892).w    ; $008CEE  copy param B
        move.w  ($FFFFC0BE).w,($FFFFC894).w    ; $008CF4  copy param C
        move.b  #$05,($FFFFC8F6).w             ; $008CFA  set counter = 5
        addq.b  #2,($FFFFC896).w               ; $008D00  advance state
        rts                                     ; $008D04
