; ============================================================================
; State Dispatcher (4-Entry Jump Table, Variant B)
; ROM Range: $00573C-$005772 (54 bytes)
; ============================================================================
; Category: game
; Purpose: Calls sfx_queue_process, increments $A510 tick counter,
;   then dispatches via 4-entry longword jump table indexed by
;   sub_state ($C8C4). State 0 handler: calls VDPSyncSH2, advances
;   sub_state by 4, writes $20 to SH2 COMM register ($FF0008).
;
; Uses: D0, A0, A1
; RAM:
;   $A510: tick counter (byte, +1 per call)
;   $C8C4: sub_state (byte, dispatch index)
; Calls:
;   $0021CA: sfx_queue_process
;   $0028C2: VDPSyncSH2
; ============================================================================

state_disp_00573c:
        jsr     sound_update_disp+244(pc); $4EBA $CA8C
        addq.b  #1,($FFFFA510).w               ; $005740  tick counter++
        moveq   #$00,D0                         ; $005744  clear high bits
        move.b  ($FFFFC8C4).w,D0               ; $005746  D0 = sub_state
        movea.l $005750(PC,D0.W),A1            ; $00574A  A1 = handler address
        jmp     (A1)                            ; $00574E  dispatch
; --- jump table (4 longword entries) ---
        dc.l    $00885760                       ; $005750  [0] → state 0 handler
        dc.l    $00885772                       ; $005754  [4] → $005772 (past fn)
        dc.l    $00885780                       ; $005758  [8] → $005780 (past fn)
        dc.l    $008857BC                       ; $00575C  [C] → $0057BC (past fn)
; --- state 0 handler ---
        jsr     mars_dma_xfer_vdp_fill(pc); $4EBA $D160
        addq.b  #4,($FFFFC8C4).w               ; $005764  advance sub_state
        move.w  #$0020,$00FF0008               ; $005768  SH2 COMM = $20
        rts                                     ; $005770
