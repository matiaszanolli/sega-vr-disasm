; ============================================================================
; Display State Dispatcher (Two Jump Tables: 9 + 4 Entries)
; ROM Range: $0044E8-$004538 (80 bytes)
; ============================================================================
; Category: game
; Purpose: Sets camera_active ($C048) = 1. Dispatches via 9-entry
;   longword jump table A indexed by input_state ($C07C).
;   Entry 7 handler ($451C): dispatches via 4-entry jump table B
;   indexed by input_sub_state ($C882). Returns after dispatch.
;
; Uses: D0, D2, A1, A2, A4, A6
; RAM:
;   $C048: camera_active (word, set to 1)
;   $C07C: input_state (word)
;   $C8BE: input_sub_state (word)
; ============================================================================

fn_4200_004:
        move.w  #$0001,($FFFFC048).w            ; $0044E8  camera_active = 1
        move.w  ($FFFFC07C).w,D0                ; $0044EE  D0 = input_state
        movea.l $0044F8(PC,D0.W),A1             ; $0044F2  A1 = handler A
        jmp     (A1)                            ; $0044F6  dispatch
; --- jump table A (9 longword entries) ---
        dc.l    $00884536                       ; $0044F8  [00] → $004536 (RTS)
        dc.l    $00884538                       ; $0044FC  [04] → $004538 (past fn)
        dc.l    $00884566                       ; $004500  [08] → $004566 (past fn)
        dc.l    $00884566                       ; $004504  [0C] → $004566 (past fn)
        dc.l    $0088456C                       ; $004508  [10] → $00456C (past fn)
        dc.l    $00884638                       ; $00450C  [14] → $004638 (past fn)
        dc.l    $0088464A                       ; $004510  [18] → $00464A (past fn)
        dc.l    $0088465C                       ; $004514  [1C] → table B dispatcher
        dc.l    $00884682                       ; $004518  [20] → $004682 (past fn)
; --- table B dispatcher ---
        move.w  ($FFFFC8BE).w,D0                ; $00451C  D0 = input_sub_state
        movea.l $004526(PC,D0.W),A1             ; $004520  A1 = handler B
        jmp     (A1)                            ; $004524  dispatch
; --- jump table B (4 longword entries) ---
        dc.l    $00884696                       ; $004526  [00] → $004696 (past fn)
        dc.l    $008846AA                       ; $00452A  [04] → $0046AA (past fn)
        dc.l    $008846EE                       ; $00452E  [08] → $0046EE (past fn)
        dc.l    $0088471E                       ; $004532  [0C] → $00471E (past fn)
        rts                                     ; $004536
