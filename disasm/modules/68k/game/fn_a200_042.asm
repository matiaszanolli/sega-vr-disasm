; ============================================================================
; AI Dispatch + Triple Object Setup
; ROM Range: $00BEC4-$00BEFC (56 bytes)
; ============================================================================
; Category: game
; Purpose: Advances AI dispatch counter, clears substate.
;   Initializes 3 SH2 objects at $FF6800/$FF6810/$FF6820 (byte +$00 = $01).
;   Loads race_state as index into handler table at $BEFC(PC),
;   stores handler address into third object's +$08 field.
;
; Uses: D0, A1
; RAM:
;   $A0EA: AI dispatch counter (word, advanced by 4)
;   $A0EC: AI substate (word, cleared)
;   $C8A0: race_state (word, used as table index)
;   $FF6800: SH2 object 0 base
;   $FF6810: SH2 object 1 base
;   $FF6820: SH2 object 2 base
; ============================================================================

fn_a200_042:
        addq.w  #4,($FFFFA0EA).w                ; $00BEC4  advance AI dispatch
        clr.w   ($FFFFA0EC).w                   ; $00BEC8  clear AI substate
        lea     $00FF6800,A1                    ; $00BECC  A1 = SH2 object 0
        move.b  #$01,$0000(A1)                  ; $00BED2  enable object 0
        lea     $00FF6810,A1                    ; $00BED8  A1 = SH2 object 1
        move.b  #$01,$0000(A1)                  ; $00BEDE  enable object 1
        lea     $00FF6820,A1                    ; $00BEE4  A1 = SH2 object 2
        move.b  #$01,$0000(A1)                  ; $00BEEA  enable object 2
        move.w  ($FFFFC8A0).w,D0                ; $00BEF0  D0 = race_state index
        move.l  $00BEFC(PC,D0.W),$0008(A1)      ; $00BEF4  obj2+$08 = handler[race_state]
        rts                                     ; $00BEFA
