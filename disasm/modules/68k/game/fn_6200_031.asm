; ============================================================================
; Obj Heading 031 (auto-analyzed)
; ROM Range: $007636-$00764E (24 bytes)
; ============================================================================
; Category: game
; Purpose: Short helper function
;   Object (A0): +$3C (heading_mirror), +$96, +$CC
;
; Entry: A0 = object/entity pointer
; Uses: D0, A0
; Object fields:
;   +$3C: heading_mirror
;   +$96: [unknown]
;   +$CC: [unknown]
; Confidence: low
; ============================================================================

fn_6200_031:
        MOVE.W  (-16182).W,D0                   ; $007636
        ADD.W  (-16208).W,D0                    ; $00763A
        ASL.W  #3,D0                            ; $00763E
        ADD.W  $003C(A0),D0                     ; $007640
        ADD.W  $0096(A0),D0                     ; $007644
        MOVE.W  D0,$00CC(A0)                    ; $007648
        RTS                                     ; $00764C
