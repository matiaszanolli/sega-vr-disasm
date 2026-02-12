; ============================================================================
; Frame Update Orchestrator (8 Subroutines)
; ROM Range: $005070-$00509E (46 bytes)
; ============================================================================
; Category: game
; Purpose: Calls 8 subroutines via bsr.w in sequence:
;   $002180 (frame init), $00179E (controller_poll),
;   $00B09E (animation_update), $00B094, $00B0DE, $00B128, $00B136,
;   $00640E (object handler).
;   Advances game_state by 4, sets display mode $001C.
;
; Uses: D0 (from called routines)
; RAM:
;   $C87E: game_state (word, advanced by 4)
; Calls:
;   $002180: frame init
;   $00179E: controller_poll
;   $00B09E: animation_update
;   $00B094: animation sub B
;   $00B0DE: animation sub C
;   $00B128: animation sub D
;   $00B136: animation sub E
;   $00640E: object handler
; ============================================================================

fn_4200_016:
        dc.w    $4EBA,$D10E                     ; $005070  bsr.w $002180 (frame init)
        dc.w    $4EBA,$C728                     ; $005074  bsr.w $00179E (controller_poll)
        dc.w    $4EBA,$6024                     ; $005078  bsr.w $00B09E (animation_update)
        dc.w    $4EBA,$6016                     ; $00507C  bsr.w $00B094 (animation sub B)
        dc.w    $4EBA,$605C                     ; $005080  bsr.w $00B0DE (animation sub C)
        dc.w    $4EBA,$60A2                     ; $005084  bsr.w $00B128 (animation sub D)
        dc.w    $4EBA,$60AC                     ; $005088  bsr.w $00B136 (animation sub E)
        dc.w    $4EBA,$1380                     ; $00508C  bsr.w $00640E (object handler)
        addq.w  #4,($FFFFC87E).w               ; $005090  advance game_state
        move.w  #$001C,$00FF0008               ; $005094  display mode = $001C
        rts                                     ; $00509C
