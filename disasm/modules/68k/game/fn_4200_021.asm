; ============================================================================
; Frame Orchestrator (9 Subroutines + Controller Tail-Jump)
; ROM Range: $00535E-$0053B0 (82 bytes)
; ============================================================================
; Category: game
; Purpose: Two entry points:
;   Entry 1 ($00535E): Full frame — calls 9 subroutines (init, controllers,
;     animation, 2 updates, 2 setups, sprite+object). Increments
;     scene_state ($C8AA), advances state_dispatch_idx ($C87E) by 4,
;     writes $54 to SH2 COMM, tail-jumps to controller check ($0056F8).
;   Entry 2 ($005396): Reduced frame — calls init, controllers,
;     animation, increments scene counter ($C886), writes $54 to SH2 COMM.
;
; Uses: D0, D2, A0, A1, A2, A6
; RAM:
;   $C886: scene counter (byte, +1)
;   $C87E: state_dispatch_idx (word, +4)
;   $C8AA: scene_state (word, +1)
; Calls:
;   $00179E: poll_controllers
;   $0020D6: init handler (from $00212E)
;   $00212E: frame init
;   $006840: sprite_handler
;   $00B02C: frame_update (from $00B11A)
;   $00B09E: animation_update
;   $00B11A: update_A
;   $00B504: setup_A
;   $00B5A4: setup_B
;   $00B684: object_update
;   $00B6DA: sprite_update
; ============================================================================

fn_4200_021:
; --- entry 1: full frame orchestrator ---
        dc.w    $4EBA,$CDCE                     ; $00535E  jsr $00212E(pc) — frame init
        dc.w    $4EBA,$C43A                     ; $005362  jsr $00179E(pc) — poll_controllers
        dc.w    $4EBA,$5D36                     ; $005366  jsr $00B09E(pc) — animation_update
        dc.w    $4EBA,$5DAE                     ; $00536A  jsr $00B11A(pc) — update_A
        dc.w    $4EBA,$6194                     ; $00536E  jsr $00B504(pc) — setup_A
        dc.w    $4EBA,$6230                     ; $005372  jsr $00B5A4(pc) — setup_B
        addq.w  #1,($FFFFC8AA).w               ; $005376  scene_state++
        dc.w    $4EBA,$14C4                     ; $00537A  jsr $006840(pc) — sprite_handler
        dc.w    $4EBA,$635A                     ; $00537E  jsr $00B6DA(pc) — sprite_update
        dc.w    $4EBA,$6300                     ; $005382  jsr $00B684(pc) — object_update
        addq.w  #4,($FFFFC87E).w               ; $005386  advance state_dispatch
        move.w  #$0054,$00FF0008               ; $00538A  SH2 COMM = $54
        dc.w    $4EFA,$0364                     ; $005392  jmp $0056F8(pc) — controller check (tail)
; --- entry 2: reduced frame ---
        dc.w    $4EBA,$CD96                     ; $005396  jsr $00212E(pc) — frame init
        dc.w    $4EBA,$C402                     ; $00539A  jsr $00179E(pc) — poll_controllers
        dc.w    $4EBA,$5CFE                     ; $00539E  jsr $00B09E(pc) — animation_update
        addq.b  #1,($FFFFC886).w               ; $0053A2  scene counter++
        move.w  #$0054,$00FF0008               ; $0053A6  SH2 COMM = $54
        rts                                     ; $0053AE
