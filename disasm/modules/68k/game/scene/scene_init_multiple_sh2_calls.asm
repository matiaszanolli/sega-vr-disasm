; ============================================================================
; Scene Init with Multiple SH2 Calls
; ROM Range: $00C368-$00C390 (40 bytes)
; ============================================================================
; Calls four subroutines (3 SH2 + 1 local), increments the frame
; counter ($C886), advances game state dispatch ($C87E) by 4,
; and sets display mode/frame delay to $0010.
;
; Memory:
;   $FFFFC886 = frame counter (byte, incremented by 1)
;   $FFFFC87E = game state dispatch (word, advanced by 4)
;   $00FF0008 = SH2 display mode/frame delay (word, set to $0010)
; Entry: none | Exit: scene initialized | Uses: none
; ============================================================================

scene_init_multiple_sh2_calls:
        jsr     $008821CA                       ; $00C368: $4EB9 $0088 $21CA — SH2 routine 1
        jsr     $008825B0                       ; $00C36E: $4EB9 $0088 $25B0 — SH2 routine 2
        dc.w    $4EBA,$F6A2                     ; BSR.W $00BA18 ; $00C374: — call local sub
        jsr     $00885908                       ; $00C378: $4EB9 $0088 $5908 — SH2 routine 3
        addq.b  #1,($FFFFC886).w               ; $00C37E: $5238 $C886 — increment frame counter
        addq.w  #4,($FFFFC87E).w               ; $00C382: $5878 $C87E — advance game state
        move.w  #$0010,$00FF0008                ; $00C386: $33FC $0010 $00FF $0008 — set display mode
        rts                                     ; $00C38E: $4E75

