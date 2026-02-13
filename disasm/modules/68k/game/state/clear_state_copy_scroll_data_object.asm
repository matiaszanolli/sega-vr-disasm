; ============================================================================
; Clear State + Copy Scroll Data from Object
; ROM Range: $00BCDA-$00BD00 (38 bytes)
; ============================================================================
; Category: game
; Purpose: Clears scene_state and menu_substate, then copies 6 words from
;   object data at A0+$02 to scroll/position registers.
;   Same destination registers as backward_object_scan_copy_scroll_data.
;
; Entry: A0 = object pointer
; Uses: A1
; RAM:
;   $C8AA: scene_state (word, cleared)
;   $C084: menu_substate (word, cleared)
;   $C086: scroll register 1 (word)
;   $C054: scroll register 2 (word)
;   $C056: scroll register 3 (word)
;   $C0AE: position register 1 (word)
;   $C0B0: position register 2 (word)
;   $C0B2: position register 3 (word)
; ============================================================================

clear_state_copy_scroll_data_object:
        clr.w   ($FFFFC8AA).w                   ; $00BCDA  clear scene_state
        clr.w   ($FFFFC084).w                   ; $00BCDE  clear menu_substate
        lea     $0002(A0),A1                    ; $00BCE2  A1 = object data + 2
        move.w  (A1)+,($FFFFC086).w             ; $00BCE6  copy word 1 → scroll reg 1
        move.w  (A1)+,($FFFFC054).w             ; $00BCEA  copy word 2 → scroll reg 2
        move.w  (A1)+,($FFFFC056).w             ; $00BCEE  copy word 3 → scroll reg 3
        move.w  (A1)+,($FFFFC0AE).w             ; $00BCF2  copy word 4 → position reg 1
        move.w  (A1)+,($FFFFC0B0).w             ; $00BCF6  copy word 5 → position reg 2
        move.w  (A1)+,($FFFFC0B2).w             ; $00BCFA  copy word 6 → position reg 3
        rts                                     ; $00BCFE
