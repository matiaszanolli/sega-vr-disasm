; ============================================================================
; State Dispatcher (5-Entry Jump Table + 4 Subroutines)
; ROM Range: $005618-$005658 (64 bytes)
; ============================================================================
; Category: game
; Purpose: Dispatches via 5-entry longword jump table indexed by
;   state_dispatch_idx ($C87E). State 0 handler: calls VDPSyncSH2,
;   sfx_queue_process, $0088BE, sprite_input_check, increments
;   scene counter ($C886), advances state by 4, writes $10 to SH2 COMM.
;
; Uses: D0, D6, A0, A1, A6
; RAM:
;   $C886: scene counter (byte, +1)
;   $C87E: state_dispatch_idx (word)
; Calls:
;   $0021CA: sfx_queue_process
;   $0028C2: VDPSyncSH2
;   $0058C8: sprite_input_check
;   $0088BE: handler subroutine
; ============================================================================

fn_4200_027:
        move.w  ($FFFFC87E).w,D0               ; $005618  D0 = state_dispatch_idx
        movea.l $005622(PC,D0.W),A1            ; $00561C  A1 = handler address
        jmp     (A1)                            ; $005620  dispatch
; --- jump table (5 longword entries) ---
        dc.l    $00885636                       ; $005622  [00] → state 0 handler
        dc.l    $00885658                       ; $005626  [04] → $005658 (past fn)
        dc.l    $00885676                       ; $00562A  [08] → $005676 (past fn)
        dc.l    $008856CE                       ; $00562E  [0C] → $0056CE (past fn)
        dc.l    $0088573C                       ; $005632  [10] → $00573C (past fn)
; --- state 0 handler ---
        dc.w    $4EBA,$D28A                     ; $005636  jsr $0028C2(pc) — VDPSyncSH2
        dc.w    $4EBA,$CB8E                     ; $00563A  jsr $0021CA(pc) — sfx_queue_process
        dc.w    $4EBA,$327E                     ; $00563E  jsr $0088BE(pc) — handler sub
        dc.w    $4EBA,$0284                     ; $005642  jsr $0058C8(pc) — sprite_input_check
        addq.b  #1,($FFFFC886).w               ; $005646  scene counter++
        addq.w  #4,($FFFFC87E).w               ; $00564A  advance state
        move.w  #$0010,$00FF0008               ; $00564E  SH2 COMM = $10
        rts                                     ; $005656
