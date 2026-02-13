; ============================================================================
; Conditional Scroll State Init
; ROM Range: $006C26-$006C46 (32 bytes)
; ============================================================================
; Reads scroll trigger ($C050). If positive, returns. Otherwise
; sets bit 0 of control flag ($C30E), copies $C096 → $C07A
; (state parameter), sets input state ($C07C) to $0014, and
; clears the scroll trigger back to zero.
;
; Memory:
;   $FFFFC050 = scroll trigger (word, tested, conditionally cleared)
;   $FFFFC30E = control flag (byte, bit 0 set)
;   $FFFFC096 = state parameter source (word, read)
;   $FFFFC07A = state parameter dest (word, written)
;   $FFFFC07C = input state (word, set to $0014)
; Entry: none | Exit: scroll state initialized or no-op | Uses: D0
; ============================================================================

conditional_scroll_state_init:
        move.w  ($FFFFC050).w,d0                ; $006C26: $3038 $C050 — load scroll trigger
        bpl.s   .done                           ; $006C2A: $6A18 — positive → skip
        bset    #0,($FFFFC30E).w                ; $006C2C: $08F8 $0000 $C30E — set control bit 0
        move.w  ($FFFFC096).w,($FFFFC07A).w     ; $006C32: $31F8 $C096 $C07A — copy state parameter
        move.w  #$0014,($FFFFC07C).w            ; $006C38: $31FC $0014 $C07C — set input state
        move.w  #$0000,($FFFFC050).w            ; $006C3E: $31FC $0000 $C050 — clear scroll trigger
.done:
        rts                                     ; $006C44: $4E75

