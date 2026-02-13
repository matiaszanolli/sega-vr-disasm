; ============================================================================
; Scene Dispatch (Jump Table)
; ROM Range: $00C416-$00C44C (54 bytes)
; ============================================================================
; Category: game
; Purpose: Reads scene dispatch index from $C8F5, looks up target scene ID
;   from PC-relative table at $C44C. If it matches current scene ($C080),
;   initializes scene: SH2 call, sets game/menu/sub-sequence states,
;   advances dispatch index by 2, sets display mode $0044.
;
; Uses: D0
; RAM:
;   $C8F5: scene dispatch index (byte)
;   $C080: current scene ID (word)
;   $C87E: game_state (word, set to $0010)
;   $C8C4: sub-sequence state (word, set to $0C00)
;   $C082: menu_state (byte, set to $04)
; Calls:
;   $008849AA: SH2 scene init
; ============================================================================

scene_dispatch:
        moveq   #$00,D0                         ; $00C416  clear D0
        move.b  ($FFFFC8F5).w,D0                ; $00C418  D0 = dispatch index
        move.w  $00C44C(PC,D0.W),D0             ; $00C41C  D0 = table[index] (scene ID)
        cmp.w   ($FFFFC080).w,D0                ; $00C420  matches current scene?
        bne.s   .done                           ; $00C424  no → skip
        jsr     $008849AA                       ; $00C426  SH2 scene init
        move.w  #$0010,($FFFFC87E).w            ; $00C42C  game_state = $0010
        move.w  #$0C00,($FFFFC8C4).w            ; $00C432  sub-sequence = $0C00
        move.b  #$04,($FFFFC082).w              ; $00C438  menu_state = $04
        addq.b  #2,($FFFFC8F5).w                ; $00C43E  advance dispatch index
        move.w  #$0044,$00FF0008                ; $00C442  display mode = $0044
.done:
        rts                                     ; $00C44A
