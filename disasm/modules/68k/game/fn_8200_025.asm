; ============================================================================
; Camera Yaw Increment + Mirror to Viewports
; ROM Range: $008D12-$008D38 (38 bytes)
; ============================================================================
; Increments working yaw ($C894) by $0050, clamped at $EC0A.
; If yaw exceeds max, falls through to next function (skips increment).
; Mirrors yaw to viewport backup ($C0BE), and if yaw > $E8E8,
; also copies to SH2 shared memory ($FF3028).
;
; Memory:
;   $FFFFC894 = working yaw (word, incremented by $0050, max $EC0A)
;   $FFFFC0BE = viewport backup (word, mirror of yaw)
;   $00FF3028 = SH2 shared yaw (word, conditionally updated)
; Entry: none | Exit: yaw incremented | Uses: none
; ============================================================================

fn_8200_025:
        cmpi.w  #$EC0A,($FFFFC894).w            ; $008D12: $0C78 $EC0A $C894 — yaw at max?
        dc.w    $6E1E                           ; BGT.S fn_8200_025_end ; $008D18: — exceeded → fall through
        addi.w  #$0050,($FFFFC894).w            ; $008D1A: $0678 $0050 $C894 — increment yaw
        move.w  ($FFFFC894).w,($FFFFC0BE).w     ; $008D20: $31F8 $C894 $C0BE — mirror to viewport backup
        cmpi.w  #$E8E8,($FFFFC894).w            ; $008D26: $0C78 $E8E8 $C894 — threshold for SH2 update?
        ble.s   .done                           ; $008D2C: $6F08 — below → skip SH2 update
        move.w  ($FFFFC894).w,($00FF3028).l     ; $008D2E: $33F8 $C894 $00FF $3028 — copy to SH2 shared
.done:
        rts                                     ; $008D36: $4E75

