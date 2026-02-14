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

state_disp_005020:
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
        jsr     mars_dma_xfer_vdp_fill(pc); $4EBA $D87E
        jsr     sound_update_disp+126(pc); $4EBA $D10C
        jsr     cascaded_frame_counter+10(pc); $4EBA $6052
        jsr     cascaded_frame_counter(pc); $4EBA $6044
        jsr     ai_timer_inc(pc)        ; $4EBA $608A
        jsr     speed_scale_conditional(pc); $4EBA $5FE4
        jsr     lap_value_store_1(pc)   ; $4EBA $65D6
        jsr     lap_value_store_2(pc)   ; $4EBA $65E6
        addq.w  #4,($FFFFC87E).w                ; $005062  advance state
        move.w  #$0014,$00FF0008                ; $005066  SH2 COMM = $14
        rts                                     ; $00506E

