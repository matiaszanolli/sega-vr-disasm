; ============================================================================
; Scene Init + SH2 Buffer Clear Loop
; ROM Range: $00CD92-$00CDD2 (64 bytes)
; ============================================================================
; Category: game
; Purpose: Saves/restores $C260 across SH2 init call ($88483A with A1→$C000).
;   Then calls SH2 init ($884842) 16 times with A1→$9000, D1=0.
;   Clears $C30E, $C8AA, $C8AC, $C8AE. Sets $C026 = $FFFF.
;
; Uses: D1, D7, A1
; RAM:
;   $C000: SH2 buffer A (via LEA)
;   $C026: control flag (word, set to $FFFF)
;   $C260: saved value (long, preserved via stack)
;   $C30E: control flags (byte, cleared)
;   $C8AA: scene_state (word, cleared)
;   $C8AC: state_dispatch_idx (word, cleared)
;   $C8AE: effect_timer (word, cleared)
;   $9000: SH2 buffer B (via LEA)
; Calls:
;   $0088483A: SH2 init A
;   $00884842: SH2 init B (called 16 times)
; ============================================================================

scene_init_sh2_buffer_clear_loop:
        move.l  ($FFFFC260).w,-(A7)            ; $00CD92  save $C260 to stack
        lea     ($FFFFC000).w,A1               ; $00CD96  A1 → SH2 buffer A
        moveq   #$00,D1                         ; $00CD9A  D1 = 0
        jsr     $0088483A                       ; $00CD9C  SH2 init A
        move.l  (A7)+,($FFFFC260).w            ; $00CDA2  restore $C260
        lea     ($FFFF9000).w,A1               ; $00CDA6  A1 → SH2 buffer B
        moveq   #$00,D1                         ; $00CDAA  D1 = 0
        moveq   #$0F,D7                         ; $00CDAC  loop 16 times
.init_loop:
        jsr     $00884842                       ; $00CDAE  SH2 init B
        dbra    D7,.init_loop                   ; $00CDB4  next iteration
        moveq   #$00,D1                         ; $00CDB8  D1 = 0
        move.b  D1,($FFFFC30E).w               ; $00CDBA  clear control flags
        move.w  D1,($FFFFC8AA).w               ; $00CDBE  clear scene_state
        move.w  D1,($FFFFC8AC).w               ; $00CDC2  clear state_dispatch_idx
        move.w  D1,($FFFFC8AE).w               ; $00CDC6  clear effect_timer
        move.w  #$FFFF,($FFFFC026).w           ; $00CDCA  set control flag
        rts                                     ; $00CDD0
