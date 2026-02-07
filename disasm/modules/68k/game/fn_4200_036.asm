; ============================================================================
; Sh2 Comm Dispatch 036 (auto-analyzed)
; ROM Range: $005866-$0058EA (132 bytes)
; ============================================================================
; Category: sh2
; Purpose: State dispatcher using jump table
;   RAM: $C89C (sh2_comm_state)
;   Calls: SetDisplayParams
;   Object (A6): +$88
;
; Entry: A6 = object/entity pointer
; Uses: D0, D1, D4, D7, A0, A1, A4, A6
; RAM:
;   $C89C: sh2_comm_state
; Calls:
;   $0049AA: SetDisplayParams
; Object fields:
;   +$88: [unknown]
; Confidence: medium
; ============================================================================

fn_4200_036:
        DC.W    $4EBA,$5C62         ; JSR     $00B4CA(PC); $005866
        MOVE.L  $00FF0002,D0                    ; $00586A
        MOVEQ   #-$04,D1                        ; $005870
        MOVEQ   #$03,D7                         ; $005872
        DC.W    $43FA,$001E         ; LEA     $005894(PC),A1; $005874
.loc_0012:
        ADDQ.W  #4,D1                           ; $005878
        CMP.L  (A1)+,D0                         ; $00587A
        DBEQ    D7,.loc_0012                    ; $00587C
        MOVE.L  $0058A4(PC,D1.W),$00FF0002      ; $005880
        MOVE.W  #$0020,$00FF0008                ; $005888
        DC.W    $4EFA,$CFFE         ; JMP     $002890(PC); $005890
        DC.W    $0088                           ; $005894
        ADDQ.B  #3,(A0)+                        ; $005896
        DC.W    $0088                           ; $005898
        DC.W    $5308                           ; $00589A
        DC.W    $0088                           ; $00589C
        ADDQ.B  #8,-(A4)                        ; $00589E
        DC.W    $0088                           ; $0058A0
        DC.W    $4CBC                           ; $0058A2
        DC.W    $0089                           ; $0058A4
        BCLR    D4,$0088(A6)                    ; $0058A6
        DC.W    $FB98                           ; $0058AA
        DC.W    $0088                           ; $0058AC
        DC.W    $FB98                           ; $0058AE
        DC.W    $0088                           ; $0058B0
        DC.W    $FB98                           ; $0058B2
        MOVE.B  #$00,$00FF69F0                  ; $0058B4
        DC.W    $4EBA,$F0EC         ; JSR     $0049AA(PC); $0058BC
        ADDQ.B  #4,(-14139).W                   ; $0058C0
        DC.W    $4EFA,$CBAE         ; JMP     $002474(PC); $0058C4
        DC.W    $4EBA,$12C0         ; JSR     $006B8A(PC); $0058C8
        LEA     (-24576).W,A4                   ; $0058CC
        MOVE.W  (-15764).W,D0                   ; $0058D0
        BTST    #7,(-14308).W                   ; $0058D4
        BNE.S  .loc_007C                        ; $0058DA
        TST.W  (-14180).W                       ; $0058DC
        DC.W    $6708               ; BEQ.S  $0058EA; $0058E0
.loc_007C:
        ANDI.W  #$0138,D0                       ; $0058E2
        DC.W    $6708               ; BEQ.S  $0058F0; $0058E6
        RTS                                     ; $0058E8
