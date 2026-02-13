; ============================================================================
; Process SFX + Poll Controllers + Advance Frame
; ROM Range: $0055FE-$005618 (26 bytes)
; ============================================================================
; Calls SFX queue process ($0021CA), poll controllers ($00179E),
; and sub at $00BAD4. Increments frame counter ($C886) and sets
; SH2 display mode/frame delay to $0054.
;
; Memory:
;   $FFFFC886 = frame counter (byte, incremented by 1)
;   $00FF0008 = SH2 display mode/frame delay (word, set to $0054)
; Entry: none | Exit: controllers polled, frame advanced | Uses: none
; ============================================================================

process_sfx_poll_ctrls_advance_frame:
        dc.w    $4EBA,$CBCA                     ; BSR.W $0021CA ; $0055FE: — call SFX queue process
        dc.w    $4EBA,$C19A                     ; BSR.W $00179E ; $005602: — call poll controllers
        dc.w    $4EBA,$64CC                     ; BSR.W $00BAD4 ; $005606: — call sub
        addq.b  #1,($FFFFC886).w               ; $00560A: $5238 $C886 — increment frame counter
        move.w  #$0054,$00FF0008                ; $00560E: $33FC $0054 $00FF $0008 — set display mode
        rts                                     ; $005616: $4E75

