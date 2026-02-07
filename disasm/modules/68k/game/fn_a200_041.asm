; ============================================================================
; Ai Dispatch 041 (auto-analyzed)
; ROM Range: $00BE50-$00BEC4 (116 bytes)
; ============================================================================
; Category: game
; Purpose: State dispatcher using jump table
;   Object (A6): +$88
;
; Entry: A6 = object/entity pointer
; Uses: D0, D4, D7, A0, A2, A4, A6
; Object fields:
;   +$88: [unknown]
; Confidence: low
; ============================================================================

fn_a200_041:
        ORI.B  #$02,D0                          ; $00BE50
        ORI.B  #$08,D4                          ; $00BE54
        DC.W    $000C                           ; $00BE58
        ORI.B  #$1A,(A2)                        ; $00BE5A
        ORI.B  #$30,-(A4)                       ; $00BE5E
        DC.W    $003E                           ; $00BE62
        DC.W    $004E                           ; $00BE64
        ORI.W  #$3038,-(A0)                     ; $00BE66
        DC.W    $A0EA                           ; $00BE6A
        MOVEA.L $00BE72(PC,D0.W),A0             ; $00BE6C
        JMP     (A0)                            ; $00BE70
        DC.W    $0088                           ; $00BE72
        CMP.L  $0088(A6),D7                     ; $00BE74
        CMPA.W  D4,A7                           ; $00BE78
        DC.W    $0088                           ; $00BE7A
        EOR.B  D7,(A4)                          ; $00BE7C
        DC.W    $0088                           ; $00BE7E
        EOR.L  D7,(A6)+                         ; $00BE80
        DC.W    $0088                           ; $00BE82
        CMPA.L  (A6)+,A7                        ; $00BE84
        DC.W    $0088                           ; $00BE86
        EOR.B  D7,(A4)                          ; $00BE88
        DC.W    $0088                           ; $00BE8A
        EOR.L  D7,(A6)+                         ; $00BE8C
        DC.W    $0088                           ; $00BE8E
        CMPA.L  (A6)+,A7                        ; $00BE90
        DC.W    $0088                           ; $00BE92
        EOR.B  D7,(A4)                          ; $00BE94
        DC.W    $0088                           ; $00BE96
        EOR.L  D7,(A6)+                         ; $00BE98
        DC.W    $0088                           ; $00BE9A
        CMPA.L  (A6)+,A7                        ; $00BE9C
        DC.W    $0088                           ; $00BE9E
        EOR.B  D7,(A4)                          ; $00BEA0
        DC.W    $0088                           ; $00BEA2
        EOR.L  D7,(A6)+                         ; $00BEA4
        DC.W    $0088                           ; $00BEA6
        CMPA.L  (A6)+,A7                        ; $00BEA8
        DC.W    $0088                           ; $00BEAA
        AND.B  $5278(A0),D0                     ; $00BEAC
        DC.W    $A0EC                           ; $00BEB0
        CMPI.W  #$0078,(-24340).W               ; $00BEB2
        BLT.S  .loc_0072                        ; $00BEB8
        ADDQ.W  #4,(-24342).W                   ; $00BEBA
        CLR.W  (-24340).W                       ; $00BEBE
.loc_0072:
        RTS                                     ; $00BEC2
