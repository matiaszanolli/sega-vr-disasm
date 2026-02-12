; ============================================================================
; Conditional Set State Byte from Object Comparison
; ROM Range: $007FEE-$008004 (22 bytes)
; ============================================================================
; Compares D0 with object+$2D. If they match AND object+$1C < $0064,
; sets $C8A4 to $BE. Otherwise does nothing.
;
; Memory:
;   $FFFFC8A4 = state byte (byte, conditionally set to $BE)
; Entry: A0 = object pointer, D0 = comparison value
; Exit: $C8A4 optionally set | Uses: D0, A0
; ============================================================================

fn_6200_064:
        cmp.b   $002D(a0),d0                    ; $007FEE: $B028 $002D — compare with object+$2D
        bne.s   .done                           ; $007FF2: $660E — mismatch → skip
        cmpi.w  #$0064,$001C(a0)                ; $007FF4: $0C68 $0064 $001C — object+$1C >= $64?
        bcc.s   .done                           ; $007FFA: $6406 — yes → skip
        move.b  #$BE,($FFFFC8A4).w             ; $007FFC: $11FC $00BE $C8A4 — set state byte
.done:
        rts                                     ; $008002: $4E75
