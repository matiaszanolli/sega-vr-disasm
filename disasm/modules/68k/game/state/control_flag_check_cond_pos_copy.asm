; ============================================================================
; Control Flag Check + Conditional Position Copy
; ROM Range: $006C08-$006C26 (30 bytes)
; ============================================================================
; Reads control flag ($C30E), checks bits 0 and 5. If neither set,
; falls through to next function. Otherwise clears bit 4 of $C30E.
; If bit 5 was set, copies state parameter from $C098 → $C07A
; before returning.
;
; Memory:
;   $FFFFC30E = control flag (byte, bits 0/4/5 tested/modified)
;   $FFFFC098 = state parameter source (word, read)
;   $FFFFC07A = state parameter dest (word, conditionally written)
; Entry: none | Exit: flag processed | Uses: D0
; ============================================================================

control_flag_check_cond_pos_copy:
        move.b  ($FFFFC30E).w,d0                ; $006C08: $1038 $C30E — load control flag
        andi.b  #$21,d0                         ; $006C0C: $0200 $0021 — mask bits 0+5
        dc.w    $6714                           ; BEQ.S fn_6200_011_end ; $006C10: — neither set → fall through
        bclr    #4,($FFFFC30E).w                ; $006C12: $08B8 $0004 $C30E — clear bit 4
        btst    #5,d0                           ; $006C18: $0800 $0005 — bit 5 set?
        dc.w    $6708                           ; BEQ.S fn_6200_011_end ; $006C1C: — no → fall through
        move.w  ($FFFFC098).w,($FFFFC07A).w     ; $006C1E: $31F8 $C098 $C07A — copy state parameter
        rts                                     ; $006C24: $4E75

