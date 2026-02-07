; ============================================================================
; Ai 046 (auto-analyzed)
; ROM Range: $00BFDE-$00C01E (64 bytes)
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

fn_a200_046:
        ADDQ.W  #1,(-24340).W                   ; $00BFDE
        MOVEQ   #$00,D0                         ; $00BFE2
        MOVE.W  (-24340).W,D0                   ; $00BFE4
        DC.W    $D040                           ; $00BFE8
        DIVU    #$001C,D0                       ; $00BFEA
        CMPI.W  #$0005,D0                       ; $00BFEE
        DC.W    $6C2A               ; BGE.S  $00C01E; $00BFF2
        MOVE.W  D0,D1                           ; $00BFF4
        SWAP    D0                              ; $00BFF6
        ADDQ.W  #2,D0                           ; $00BFF8
        NEG.W  D0                               ; $00BFFA
        CMPI.W  #$FFE4,D0                       ; $00BFFC
        BNE.S  .loc_0026                        ; $00C000
        MOVEQ   #$00,D0                         ; $00C002
.loc_0026:
        DC.W    $D241                           ; $00C004
        DC.W    $D241                           ; $00C006
        MOVE.W  D1,D2                           ; $00C008
        DC.W    $D241                           ; $00C00A
        DC.W    $D241                           ; $00C00C
        DC.W    $D242                           ; $00C00E
        LEA     $00FF6900,A1                    ; $00C010
        LEA     $00(A1,D1.W),A1                 ; $00C016
        MOVE.W  D0,(A1)                         ; $00C01A
        RTS                                     ; $00C01C
