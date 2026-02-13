; ============================================================================
; Triple-Guard Set State to $BE
; ROM Range: $0080AE-$0080CC (30 bytes)
; ============================================================================
; Compares D0 with object+$2D. If mismatch, returns. Then checks
; $C08E against $C07A — if equal, returns. Then tests $C819
; (display config flag) — if non-zero, returns. Only when all
; three conditions pass does it set $C8A4 to $BE.
;
; Memory:
;   $FFFFC08E = position value (word, compared)
;   $FFFFC07A = state parameter (word, compared)
;   $FFFFC819 = display config flag (byte, tested)
;   $FFFFC8A4 = state variable (byte, conditionally set to $BE)
; Entry: A0 = object, D0 = comparison value | Exit: state set | Uses: D0
; ============================================================================

triple_guard_set_state_to_be:
        cmp.b   $002D(a0),d0                    ; $0080AE: $B028 $002D — compare with object+$2D
        bne.s   .done                           ; $0080B2: $6616 — mismatch → skip
        move.w  ($FFFFC08E).w,d0                ; $0080B4: $3038 $C08E — load position value
        cmp.w   ($FFFFC07A).w,d0                ; $0080B8: $B078 $C07A — compare with state param
        beq.s   .done                           ; $0080BC: $670C — equal → skip
        tst.b   ($FFFFC819).w                   ; $0080BE: $4A38 $C819 — test display config flag
        bne.s   .done                           ; $0080C2: $6606 — non-zero → skip
        move.b  #$BE,($FFFFC8A4).w              ; $0080C4: $11FC $00BE $C8A4 — set state = $BE
.done:
        rts                                     ; $0080CA: $4E75

