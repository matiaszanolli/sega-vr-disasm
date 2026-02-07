; ============================================================================
; Ai 044 (auto-analyzed)
; ROM Range: $00BF9E-$00BFD4 (54 bytes)
; ============================================================================
; Category: game
; Purpose: Object (A1): +$00
;
; Entry: A1 = object/entity pointer
; Uses: D0, D1, D2, A1
; Object fields:
;   +$00: [unknown]
; Confidence: low
; ============================================================================

fn_a200_044:
        ADDQ.W  #1,(-24340).W                   ; $00BF9E
        MOVEQ   #$00,D0                         ; $00BFA2
        MOVE.W  (-24340).W,D0                   ; $00BFA4
        DC.W    $D040                           ; $00BFA8
        DIVU    #$001C,D0                       ; $00BFAA
        CMPI.W  #$0005,D0                       ; $00BFAE
        DC.W    $6C20               ; BGE.S  $00BFD4; $00BFB2
        MOVE.W  D0,D1                           ; $00BFB4
        SWAP    D0                              ; $00BFB6
        ADDQ.W  #2,D0                           ; $00BFB8
        DC.W    $D241                           ; $00BFBA
        DC.W    $D241                           ; $00BFBC
        MOVE.W  D1,D2                           ; $00BFBE
        DC.W    $D241                           ; $00BFC0
        DC.W    $D241                           ; $00BFC2
        DC.W    $D242                           ; $00BFC4
        LEA     $00FF6900,A1                    ; $00BFC6
        LEA     $00(A1,D1.W),A1                 ; $00BFCC
        MOVE.W  D0,(A1)                         ; $00BFD0
        RTS                                     ; $00BFD2
