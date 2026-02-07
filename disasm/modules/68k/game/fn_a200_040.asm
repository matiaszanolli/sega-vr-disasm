; ============================================================================
; Ai Dispatch 040 (auto-analyzed)
; ROM Range: $00BDFE-$00BE50 (82 bytes)
; ============================================================================
; Category: game
; Purpose: State dispatcher using jump table
;   Object (A1, A2): +$02 (flags/type), +$04 (speed_index/velocity), +$12 (timer_12), +$14 (effect_duration)
;
; Entry: A1 = object/entity pointer
; Entry: A2 = object/entity pointer
; Uses: D0, D1, D2, A1, A2
; Object fields:
;   +$02: flags/type
;   +$04: speed_index/velocity
;   +$12: timer_12
;   +$14: effect_duration
; Confidence: low
; ============================================================================

fn_a200_040:
        DC.W    $D241                           ; $00BDFE
        MOVE.W  $00BE50(PC,D1.W),D0             ; $00BE00
        ADDI.W  #$0010,D0                       ; $00BE04
        MOVE.W  D0,(-24346).W                   ; $00BE08
        MOVE.W  D0,D2                           ; $00BE0C
        SUBI.W  #$0010,D2                       ; $00BE0E
        MOVE.W  D2,$0002(A1)                    ; $00BE12
        MOVE.W  D2,$0012(A1)                    ; $00BE16
        MOVE.W  #$00E0,D1                       ; $00BE1A
        DC.W    $9240                           ; $00BE1E
        LEA     $00FF60C8,A2                    ; $00BE20
        MOVE.W  D0,(A2)                         ; $00BE26
        MOVE.W  D1,$0002(A2)                    ; $00BE28
        SUBQ.W  #1,D0                           ; $00BE2C
        MOVEQ   #$09,D2                         ; $00BE2E
        EXT.L   D0                              ; $00BE30
        ASL.L  D2,D0                            ; $00BE32
        EXT.L   D1                              ; $00BE34
        ASL.L  D2,D1                            ; $00BE36
        MOVE.L  #$04024140,D2                   ; $00BE38
        DC.W    $D082                           ; $00BE3E
        DC.W    $D282                           ; $00BE40
        MOVE.L  D0,$0004(A1)                    ; $00BE42
        MOVE.L  D1,$0014(A1)                    ; $00BE46
        ADDQ.W  #1,(-24336).W                   ; $00BE4A
        RTS                                     ; $00BE4E
