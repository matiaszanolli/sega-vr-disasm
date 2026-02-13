; ============================================================================
; Scene Frame Update + Display Mode Set
; ROM Range: $00C4A4-$00C4C2 (30 bytes)
; ============================================================================
; Calls two SH2 routines, increments the frame counter ($C886),
; advances the sub-sequence state ($C8C4) by 4, and sets the
; display mode/frame delay to $0010.
;
; Memory:
;   $FFFFC886 = frame counter (byte, incremented by 1)
;   $FFFFC8C4 = sub-sequence state (byte, advanced by 4)
;   $00FF0008 = SH2 display mode/frame delay (word, set to $0010)
; Entry: none | Exit: frame updated | Uses: none
; ============================================================================

scene_frame_update_disp_mode_set:
        jsr     $0088BA18                       ; $00C4A4: $4EB9 $0088 $BA18 — call SH2 routine 1
        jsr     $00886DC8                       ; $00C4AA: $4EB9 $0088 $6DC8 — call SH2 routine 2
        addq.b  #1,($FFFFC886).w               ; $00C4B0: $5238 $C886 — increment frame counter
        addq.b  #4,($FFFFC8C4).w               ; $00C4B4: $5838 $C8C4 — advance sub-sequence state
        move.w  #$0010,$00FF0008                ; $00C4B8: $33FC $0010 $00FF $0008 — set display mode
        rts                                     ; $00C4C0: $4E75

