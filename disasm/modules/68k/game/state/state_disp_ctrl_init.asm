; ============================================================================
; State Dispatcher + Controller Init (Jump Table)
; ROM Range: $0143C6-$0143FA (52 bytes)
; ============================================================================
; Category: game
; Purpose: Calls SH2 init ($882080), reads game_state ($C87E), dispatches
;   via 3-entry longword jump table:
;     State 0 → $008943E2 (controller poll + advance, within this fn)
;     State 4 → $008943FA (external handler)
;     State 8 → $00894400 (external handler)
;   State 0 handler: polls controllers, calls $01440E, advances game_state,
;   sets display mode $0020.
;
; Uses: D0, A1
; RAM:
;   $C87E: game_state (word)
; Calls:
;   $00882080: SH2 init
;   $0088179E: controller_poll
;   $01440E: input handler (via bsr.w)
; ============================================================================

state_disp_ctrl_init:
        jsr     $00882080                       ; $0143C6  SH2 init
        move.w  ($FFFFC87E).w,D0               ; $0143CC  D0 = game_state
        movea.l .jump_table(PC,D0.W),A1        ; $0143D0  A1 = handler address
        jmp     (A1)                            ; $0143D4  dispatch
; --- jump table (3 longword entries) ---
.jump_table:
        dc.l    $008943E2                       ; $0143D6  state 0 → .state0_handler
        dc.l    $008943FA                       ; $0143DA  state 4 → external
        dc.l    $00894400                       ; $0143DE  state 8 → external
; --- state 0 handler: controller poll + advance ---
.state0_handler:
        jsr     $0088179E                       ; $0143E2  controller_poll
        jsr     menu_state_dispatch_042(pc); $4EBA $0024
        addq.w  #4,($FFFFC87E).w               ; $0143EC  advance game_state
        move.w  #$0020,$00FF0008               ; $0143F0  display mode = $0020
        rts                                     ; $0143F8
