; ============================================================================
; State Dispatcher (5-Entry Jump Table + 5 Subroutines)
; ROM Range: $005308-$005348 (64 bytes)
; ============================================================================
; Category: game
; Purpose: Dispatches via 5-entry longword jump table indexed by
;   state_dispatch_idx ($C87E). State 0 handler: calls VDPSyncSH2,
;   init ($0020D6), animation_update, frame_update ($00B02C),
;   sprite_setup ($00B632), then advances state by 4 and writes
;   $10 to SH2 COMM.
;
; Uses: D0, A0, A1, A6
; RAM:
;   $C87E: state_dispatch_idx (word)
; Calls:
;   $0020D6: init handler
;   $0028C2: VDPSyncSH2
;   $00B02C: frame_update
;   $00B09E: animation_update
;   $00B632: sprite_setup
; ============================================================================

fn_4200_019:
        move.w  ($FFFFC87E).w,D0               ; $005308  D0 = state_dispatch_idx
        movea.l $005312(PC,D0.W),A1            ; $00530C  A1 = handler address
        jmp     (A1)                            ; $005310  dispatch
; --- jump table (5 longword entries) ---
        dc.l    $00885326                       ; $005312  [00] → state 0 handler
        dc.l    $00885348                       ; $005316  [04] → $005348 (past fn)
        dc.l    $0088535E                       ; $00531A  [08] → $00535E (past fn)
        dc.l    $00885396                       ; $00531E  [0C] → $005396 (past fn)
        dc.l    $0088573C                       ; $005322  [10] → $00573C (past fn)
; --- state 0 handler ---
        dc.w    $4EBA,$D59A                     ; $005326  jsr $0028C2(pc) — VDPSyncSH2
        dc.w    $4EBA,$CDAA                     ; $00532A  jsr $0020D6(pc) — init handler
        dc.w    $4EBA,$5D6E                     ; $00532E  jsr $00B09E(pc) — animation_update
        dc.w    $4EBA,$5CF8                     ; $005332  jsr $00B02C(pc) — frame_update
        dc.w    $4EBA,$62FA                     ; $005336  jsr $00B632(pc) — sprite_setup
        addq.w  #4,($FFFFC87E).w               ; $00533A  advance state
        move.w  #$0010,$00FF0008               ; $00533E  SH2 COMM = $10
        rts                                     ; $005346
