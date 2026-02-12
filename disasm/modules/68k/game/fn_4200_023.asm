; ============================================================================
; State Dispatcher (4-Entry Jump Table)
; ROM Range: $005586-$0055BA (52 bytes)
; ============================================================================
; Category: game
; Purpose: Dispatches via 4-entry longword jump table indexed by
;   state_dispatch_idx ($C87E). State 0 handler: calls VDPSyncSH2,
;   sfx_queue_process, sprite_input_check, then advances state by 4
;   and writes $10 to SH2 COMM register ($FF0008).
;
; Uses: D0, A0, A1
; RAM:
;   $C87E: state_dispatch_idx (word)
; Calls:
;   $0021CA: sfx_queue_process
;   $0028C2: VDPSyncSH2
;   $0058C8: sprite_input_check
; ============================================================================

fn_4200_023:
        move.w  ($FFFFC87E).w,D0               ; $005586  D0 = state_dispatch_idx
        movea.l $005590(PC,D0.W),A1            ; $00558A  A1 = handler address
        jmp     (A1)                            ; $00558E  dispatch
; --- jump table (4 longword entries) ---
        dc.l    $008855A0                       ; $005590  [0] → state 0 handler
        dc.l    $008855BA                       ; $005594  [4] → $0055BA (past fn)
        dc.l    $008855D0                       ; $005598  [8] → $0055D0 (past fn)
        dc.l    $008855FE                       ; $00559C  [C] → $0055FE (past fn)
; --- state 0 handler ---
        dc.w    $4EBA,$D320                     ; $0055A0  jsr $0028C2(pc) — VDPSyncSH2
        dc.w    $4EBA,$CC24                     ; $0055A4  jsr $0021CA(pc) — sfx_queue_process
        dc.w    $4EBA,$031E                     ; $0055A8  jsr $0058C8(pc) — sprite_input_check
        addq.w  #4,($FFFFC87E).w               ; $0055AC  advance state
        move.w  #$0010,$00FF0008               ; $0055B0  SH2 COMM = $10
        rts                                     ; $0055B8
