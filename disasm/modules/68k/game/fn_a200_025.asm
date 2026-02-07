; ============================================================================
; Ai 025 (auto-analyzed)
; ROM Range: $00B722-$00B770 (78 bytes)
; ============================================================================
; Category: game
; Purpose: Object (A0, A1, A2, A3): +$00, +$01, +$02 (flags/type)
;
; Entry: A0 = object/entity pointer
; Entry: A1 = object/entity pointer
; Entry: A2 = object/entity pointer
; Entry: A3 = object/entity pointer
; Uses: D0, D1, D2, D3, D4, D6, D7, A0
; Object fields:
;   +$00: [unknown]
;   +$01: [unknown]
;   +$02: flags/type
; Confidence: low
; ============================================================================

fn_a200_025:
        BTST    D0,D2                           ; $00B722
        BTST    D1,D4                           ; $00B724
        BTST    D2,D6                           ; $00B726
        DC.W    $0708                           ; $00B728
        DC.W    $0800                           ; $00B72A
        MOVEQ   #$00,D0                         ; $00B72C
        MOVEQ   #$00,D1                         ; $00B72E
        MOVEQ   #$00,D2                         ; $00B730
        LEA     (-31616).W,A0                   ; $00B732
.loc_0014:
        SUBQ.B  #1,$01(A1,D0.W)                 ; $00B736
        BNE.S  .loc_0046                        ; $00B73A
        MOVEA.L A2,A3                           ; $00B73C
        ADDA.W  $00(A2,D0.W),A3                 ; $00B73E
        MOVE.B  $00(A1,D0.W),D2                 ; $00B742
        DC.W    $D442                           ; $00B746
        MOVE.B  (A3),D1                         ; $00B748
        MOVE.B  $0001(A3),$01(A1,D0.W)          ; $00B74A
        MOVE.W  $00(A3,D2.W),D3                 ; $00B750
        BPL.S  .loc_003E                        ; $00B754
        MOVE.B  #$01,$00(A1,D0.W)               ; $00B756
        MOVE.W  $0002(A3),D3                    ; $00B75C
.loc_003E:
        MOVE.W  D3,$00(A0,D1.W)                 ; $00B760
        ADDQ.B  #1,$00(A1,D0.W)                 ; $00B764
.loc_0046:
        ADDQ.B  #2,D0                           ; $00B768
        DBRA    D7,.loc_0014                    ; $00B76A
        RTS                                     ; $00B76E
