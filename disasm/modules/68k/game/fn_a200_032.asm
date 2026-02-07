; ============================================================================
; Ai 032 (auto-analyzed)
; ROM Range: $00BA1A-$00BA5E (68 bytes)
; ============================================================================
; Category: game
; Purpose: Object (A1): +$00
;
; Entry: A1 = object/entity pointer
; Uses: D0, A1
; Object fields:
;   +$00: [unknown]
; Confidence: low
; ============================================================================

fn_a200_032:
        MOVEQ   #$00,D0                         ; $00BA1A
        MOVE.B  (-14228).W,D0                   ; $00BA1C
        DC.W    $D040                           ; $00BA20
        DC.W    $D040                           ; $00BA22
        LEA     $00894888,A1                    ; $00BA24
        MOVEA.L $00(A1,D0.W),A1                 ; $00BA2A
        JSR     (A1)                            ; $00BA2E
        MOVEQ   #$00,D0                         ; $00BA30
        MOVE.B  (-14227).W,D0                   ; $00BA32
        DC.W    $D040                           ; $00BA36
        DC.W    $D040                           ; $00BA38
        LEA     $00894C88,A1                    ; $00BA3A
        MOVEA.L $00(A1,D0.W),A1                 ; $00BA40
        JSR     (A1)                            ; $00BA44
        MOVEQ   #$00,D0                         ; $00BA46
        MOVE.B  (-14226).W,D0                   ; $00BA48
        DC.W    $D040                           ; $00BA4C
        DC.W    $D040                           ; $00BA4E
        LEA     $00895088,A1                    ; $00BA50
        MOVEA.L $00(A1,D0.W),A1                 ; $00BA56
        JSR     (A1)                            ; $00BA5A
        RTS                                     ; $00BA5C
