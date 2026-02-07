; ============================================================================
; Ai 016 (auto-analyzed)
; ROM Range: $00B43C-$00B478 (60 bytes)
; ============================================================================
; Category: game
; Purpose: Object (A1, A3): +$01, +$02 (flags/type), +$03, +$04 (speed_index/velocity), +$05, +$06 (speed)
;
; Entry: A1 = object/entity pointer
; Entry: A3 = object/entity pointer
; Uses: D0, A1, A3
; Object fields:
;   +$01: [unknown]
;   +$02: flags/type
;   +$03: [unknown]
;   +$04: speed_index/velocity
;   +$05: [unknown]
;   +$06: speed
;   +$07: [unknown]
; Confidence: low
; ============================================================================

fn_a200_016:
        MOVE.W  $0002(A1),D0                    ; $00B43C
        MOVE.B  D0,$0007(A3)                    ; $00B440
        LSR.W  #4,D0                            ; $00B444
        MOVE.B  D0,$0006(A3)                    ; $00B446
        LSR.W  #4,D0                            ; $00B44A
        MOVE.B  D0,$0005(A3)                    ; $00B44C
        MOVE.W  (A1),D0                         ; $00B450
        MOVE.B  D0,$0004(A3)                    ; $00B452
        LSR.W  #4,D0                            ; $00B456
        MOVE.B  D0,$0003(A3)                    ; $00B458
        LSR.W  #4,D0                            ; $00B45C
        MOVE.B  D0,$0002(A3)                    ; $00B45E
        LSR.W  #4,D0                            ; $00B462
        MOVE.B  D0,$0001(A3)                    ; $00B464
        ANDI.W  #$0F0F,$0002(A3)                ; $00B468
        ANDI.L  #$0F0F0F0F,$0004(A3)            ; $00B46E
        RTS                                     ; $00B476
