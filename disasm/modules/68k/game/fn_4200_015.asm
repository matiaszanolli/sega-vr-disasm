; ============================================================================
; State Dispatcher (5-Entry Jump Table + 8 Subroutines, Data Prefix)
; ROM Range: $005020-$005070 (80 bytes)
; ============================================================================
; Category: game
; Purpose: Data prefix: 2 words ($A5A3, $A400) — RAM buffer addresses.
;   Dispatches via 5-entry longword jump table indexed by
;   state_dispatch_idx ($C87E). State 0 handler: calls VDPSyncSH2,
;   init ($002154), animation_update, frame_sync, display_update,
;   frame_update ($00B03C), sprite_setup ($00B632), sprite_finalize
;   ($00B646). Advances state by 4, writes $14 to SH2 COMM.
;
; Uses: D0, D2, A0, A1, A6
; RAM:
;   $C87E: state_dispatch_idx (word)
; Calls:
;   $002154: init handler
;   $0028C2: VDPSyncSH2
;   $00B03C: frame_update
;   $00B094: frame_sync
;   $00B09E: animation_update
;   $00B0DE: display_update
;   $00B632: sprite_setup
;   $00B646: sprite_finalize
; ============================================================================

fn_4200_015:
; --- data prefix: 2-word buffer addresses ---
        dc.w    $A5A3                           ; $005020  buffer addr A
        dc.w    $A400                           ; $005022  buffer addr B
; --- code ---
        move.w  ($FFFFC87E).w,D0                ; $005024  D0 = state_dispatch_idx
        movea.l $00502E(PC,D0.W),A1             ; $005028  A1 = handler address
        jmp     (A1)                            ; $00502C  dispatch
; --- jump table (5 longword entries) ---
        dc.l    $00885042                       ; $00502E  [00] → state 0 handler
        dc.l    $00885070                       ; $005032  [04] → $005070 (past fn)
        dc.l    $0088509E                       ; $005036  [08] → $00509E (past fn)
        dc.l    $008850DE                       ; $00503A  [0C] → $0050DE (past fn)
        dc.l    $0088573C                       ; $00503E  [10] → $00573C (past fn)
; --- state 0 handler ---
        dc.w    $4EBA,$D87E                     ; $005042  jsr $0028C2(pc) — VDPSyncSH2
        dc.w    $4EBA,$D10C                     ; $005046  jsr $002154(pc) — init handler
        dc.w    $4EBA,$6052                     ; $00504A  jsr $00B09E(pc) — animation_update
        dc.w    $4EBA,$6044                     ; $00504E  jsr $00B094(pc) — frame_sync
        dc.w    $4EBA,$608A                     ; $005052  jsr $00B0DE(pc) — display_update
        dc.w    $4EBA,$5FE4                     ; $005056  jsr $00B03C(pc) — frame_update
        dc.w    $4EBA,$65D6                     ; $00505A  jsr $00B632(pc) — sprite_setup
        dc.w    $4EBA,$65E6                     ; $00505E  jsr $00B646(pc) — sprite_finalize
        addq.w  #4,($FFFFC87E).w                ; $005062  advance state
        move.w  #$0014,$00FF0008                ; $005066  SH2 COMM = $14
        rts                                     ; $00506E

