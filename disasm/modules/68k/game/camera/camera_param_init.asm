; ============================================================================
; Camera Parameter Init (Two-Level Dispatch)
; ROM Range: $008C40-$008CB0 (112 bytes)
; ============================================================================
; Category: game
; Purpose: Clears $C0BA, then dispatches via 3-entry word-offset table
;   indexed by $C896 (two-level: load offset, then JMP).
;   State 0 handler: initializes 15+ camera/display parameters:
;     $C0C8 = $C0, $FF60CC = $100, copies $C8DA → $C0AE,
;     clears $C0C6/$C0AE/$C0B0/$C0B2/$C086/$C88C/$C88E/$C890/$C8F6,
;     copies $C8DC → $C054/$C892, copies $C8DE → $C056/$C894.
;     Advances $C896 by 2.
;
; Uses: D0, D6
; RAM:
;   $C054: display param A (word)
;   $C056: display param B (word)
;   $C086: camera parameter (word, cleared)
;   $C0AE: camera offset X (word, set then cleared)
;   $C0B0: camera offset Y (word, cleared)
;   $C0B2: camera offset Z (word, cleared)
;   $C0BA: param base (word, cleared)
;   $C0C6: display offset delta (word, cleared)
;   $C0C8: display scale (word, set to $C0)
;   $C88C: work param A (word, cleared)
;   $C88E: work param B (word, cleared)
;   $C890: work param C (word, cleared)
;   $C892: reference param A (word, set from $C8DC)
;   $C894: reference param B (word, set from $C8DE)
;   $C896: sub_state (byte, +2 per call)
;   $C8DA: initial camera offset (word)
;   $C8DC: reference value A (word)
;   $C8DE: reference value B (word)
;   $C8F6: counter (word, cleared)
; ============================================================================

camera_param_init:
        moveq   #$00,D0                         ; $008C40  D0 = 0
        move.w  D0,($FFFFC0BA).w               ; $008C42  clear param base
        move.b  ($FFFFC896).w,D0               ; $008C46  D0 = sub_state
        move.w  $008C52(PC,D0.W),D0            ; $008C4A  D0 = word offset from table
        jmp     $008C52(PC,D0.W)               ; $008C4E  jump to handler
; --- word-offset dispatch table (3 entries) ---
        dc.w    $0006                           ; $008C52  [0] → $008C58 (state 0)
        dc.w    $005E                           ; $008C54  [2] → $008CB0 (past fn)
        dc.w    $007A                           ; $008C56  [4] → $008CCC (past fn)
; --- state 0 handler: camera parameter init ---
        move.w  #$00C0,($FFFFC0C8).w          ; $008C58  display scale = $C0
        move.w  #$0100,$00FF60CC               ; $008C5E  VDP param = $100
        move.w  ($FFFFC8DA).w,($FFFFC0AE).w   ; $008C66  camera offset X = init value
        moveq   #$00,D0                         ; $008C6C  D0 = 0
        move.w  D0,($FFFFC0C6).w              ; $008C6E  clear display offset delta
        move.w  D0,($FFFFC0AE).w              ; $008C72  clear camera offset X
        move.w  D0,($FFFFC0B0).w              ; $008C76  clear camera offset Y
        move.w  D0,($FFFFC0B2).w              ; $008C7A  clear camera offset Z
        move.w  D0,($FFFFC086).w              ; $008C7E  clear camera parameter
        move.w  D0,($FFFFC88C).w              ; $008C82  clear work param A
        move.w  D0,($FFFFC88E).w              ; $008C86  clear work param B
        move.w  D0,($FFFFC890).w              ; $008C8A  clear work param C
        move.w  D0,($FFFFC8F6).w              ; $008C8E  clear counter
        move.w  ($FFFFC8DC).w,D0              ; $008C92  D0 = reference A
        move.w  D0,($FFFFC054).w              ; $008C96  display param A = ref A
        move.w  D0,($FFFFC892).w              ; $008C9A  reference param A = ref A
        move.w  ($FFFFC8DE).w,D0              ; $008C9E  D0 = reference B
        move.w  D0,($FFFFC056).w              ; $008CA2  display param B = ref B
        move.w  D0,($FFFFC894).w              ; $008CA6  reference param B = ref B
        addq.b  #2,($FFFFC896).w              ; $008CAA  advance sub_state
        rts                                     ; $008CAE
