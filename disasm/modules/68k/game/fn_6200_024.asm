; ============================================================================
; Obj 024 (auto-analyzed)
; ROM Range: $00714A-$0071A6 (92 bytes)
; ============================================================================
; Category: game
; Purpose: Object (A0, A1, A2): +$00, +$02 (flags/type), +$19, +$1A (direction), +$1B, +$1D
;
; Entry: A0 = object/entity pointer
; Entry: A1 = object/entity pointer
; Entry: A2 = object/entity pointer
; Uses: D0, D1, A0, A1, A2
; Object fields:
;   +$00: [unknown]
;   +$02: flags/type
;   +$19: [unknown]
;   +$1A: direction
;   +$1B: [unknown]
;   +$1D: [unknown]
;   +$1E: [unknown]
;   +$20: [unknown]
; Confidence: low
; ============================================================================

fn_6200_024:
        MOVEQ   #$00,D0                         ; $00714A
        MOVEA.L $00CE(A0),A1                    ; $00714C
        MOVE.B  $001B(A1),D0                    ; $007150
        MOVE.B  D0,$001D(A0)                    ; $007154
        MOVE.B  $0025(A0),$0027(A0)             ; $007158
        MOVEA.L (-14588).W,A2                   ; $00715E
        MOVE.B  $00(A2,D0.W),D1                 ; $007162
        MOVE.B  D1,$0025(A0)                    ; $007166
        MOVEA.L (-14592).W,A2                   ; $00716A
        DC.W    $D040                           ; $00716E
        DC.W    $D040                           ; $007170
        MOVE.W  $00(A2,D0.W),$0020(A0)          ; $007172
        MOVE.W  $02(A2,D0.W),$0022(A0)          ; $007178
        MOVE.W  $001A(A1),D1                    ; $00717E
        ANDI.W  #$FF00,D1                       ; $007182
        MOVE.W  D1,$001E(A0)                    ; $007186
        MOVE.B  $0019(A1),$00E5(A0)             ; $00718A
        MOVE.B  #$00,$00E4(A0)                  ; $007190
        BTST    #0,$00E5(A0)                    ; $007196
        BEQ.S  .loc_005A                        ; $00719C
        MOVE.B  #$01,$00E4(A0)                  ; $00719E
.loc_005A:
        RTS                                     ; $0071A4
