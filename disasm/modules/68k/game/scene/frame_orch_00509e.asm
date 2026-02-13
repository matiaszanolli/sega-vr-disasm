; ============================================================================
; Frame Orchestrator (12 Subroutines, 2 Entry Points)
; ROM Range: $00509E-$005100 (98 bytes)
; ============================================================================
; Category: game
; Purpose: Two entry points:
;   Entry 1 ($509E): Full orchestrator — calls 12 subroutines (init,
;     scene logic, animation, frame update, sprite processing), increments
;     scene_state, advances state_dispatch_idx by 4, writes $54 to SH2
;     COMM, tail-jumps to controller handler ($0056F8).
;   Entry 2 ($50DE): Reduced — calls 5 subroutines (init, poll_controllers,
;     animation, update), increments scene_counter, writes $54 to SH2 COMM.
;
; Uses: D0, D3, D7, A1, A2
; RAM:
;   $C87E: state_dispatch_idx (word)
;   $C886: scene_counter (byte)
;   $C8AA: scene_state (word)
; Calls:
;   $00179E: poll_controllers
;   $0021A4: init handler A
;   $006496: scene logic
;   $00B094: frame_sync
;   $00B09E: animation_update
;   $00B0DE: display_update
;   $00B4F8: sprite_sort
;   $00B504: sprite_build
;   $00B55A: sprite_commit
;   $00B590: sprite_finalize
;   $00B684: object_update
;   $00B6DA: sprite_update
; ============================================================================

frame_orch_00509e:
; --- entry 1: full orchestrator ---
        dc.w    $4EBA,$D104                     ; $00509E  jsr $0021A4(pc) — init handler A
        dc.w    $4EBA,$13F2                     ; $0050A2  jsr $006496(pc) — scene logic
        dc.w    $4EBA,$5FF6                     ; $0050A6  jsr $00B09E(pc) — animation_update
        dc.w    $4EBA,$5FE8                     ; $0050AA  jsr $00B094(pc) — frame_sync
        dc.w    $4EBA,$602E                     ; $0050AE  jsr $00B0DE(pc) — display_update
        dc.w    $4EBA,$6450                     ; $0050B2  jsr $00B504(pc) — sprite_build
        dc.w    $4EBA,$6440                     ; $0050B6  jsr $00B4F8(pc) — sprite_sort
        dc.w    $4EBA,$649E                     ; $0050BA  jsr $00B55A(pc) — sprite_commit
        dc.w    $4EBA,$64D0                     ; $0050BE  jsr $00B590(pc) — sprite_finalize
        addq.w  #1,($FFFFC8AA).w                ; $0050C2  scene_state++
        dc.w    $4EBA,$6612                     ; $0050C6  jsr $00B6DA(pc) — sprite_update
        dc.w    $4EBA,$65B8                     ; $0050CA  jsr $00B684(pc) — object_update
        addq.w  #4,($FFFFC87E).w                ; $0050CE  advance state
        move.w  #$0054,$00FF0008                ; $0050D2  SH2 COMM = $54
        dc.w    $4EFA,$061C                     ; $0050DA  jmp $0056F8(pc) — controller handler
; --- entry 2: reduced orchestrator ---
        dc.w    $4EBA,$D0C4                     ; $0050DE  jsr $0021A4(pc) — init handler A
        dc.w    $4EBA,$C6BA                     ; $0050E2  jsr $00179E(pc) — poll_controllers
        dc.w    $4EBA,$5FB6                     ; $0050E6  jsr $00B09E(pc) — animation_update
        dc.w    $4EBA,$5FA8                     ; $0050EA  jsr $00B094(pc) — frame_sync
        dc.w    $4EBA,$5FEE                     ; $0050EE  jsr $00B0DE(pc) — display_update
        addq.b  #1,($FFFFC886).w                ; $0050F2  scene_counter++
        move.w  #$0054,$00FF0008                ; $0050F6  SH2 COMM = $54
        rts                                     ; $0050FE

