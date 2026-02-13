; ============================================================================
; Fm Write Wrapper 023 (auto-analyzed)
; ROM Range: $030B90-$030BE0 (80 bytes)
; ============================================================================
; Category: sound
; Purpose: Calls: fm_write_wrapper
;   Object (A6): +$00, +$09
;
; Entry: A6 = object/entity pointer
; Uses: D0, D1, A0, A6
; Calls:
;   $030CBA: fm_write_wrapper
; Object fields:
;   +$00: [unknown]
;   +$09: [unknown]
; Confidence: medium
; ============================================================================

fn_30200_023:
        MOVEQ   #$2B,D0                         ; $030B90
        MOVE.B  #$80,D1                         ; $030B92
        DC.W    $4EBA,$0122         ; JSR     $030CBA(PC); $030B96
        MOVEQ   #$27,D0                         ; $030B9A
        MOVEQ   #$00,D1                         ; $030B9C
        DC.W    $4EBA,$011A         ; JSR     $030CBA(PC); $030B9E
        MOVEA.L A6,A0                           ; $030BA2
        MOVE.W  #$00E3,D0                       ; $030BA4
.loc_0018:
        CLR.L  (A0)+                            ; $030BA8
        DBRA    D0,.loc_0018                    ; $030BAA
        MOVE.B  #$80,$0009(A6)                  ; $030BAE
        DC.W    $4EBA,$FF9A         ; JSR     $030B50(PC); $030BB4
        DC.W    $6000,$040E         ; BRA.W  $030FC8; $030BB8
        MOVEQ   #$27,D0                         ; $030BBC
        MOVEQ   #$00,D1                         ; $030BBE
        DC.W    $4EBA,$00F8         ; JSR     $030CBA(PC); $030BC0
        MOVEA.L A6,A0                           ; $030BC4
        MOVE.B  $0000(A6),D1                    ; $030BC6
        MOVE.W  #$0087,D0                       ; $030BCA
.loc_003E:
        CLR.L  (A0)+                            ; $030BCE
        DBRA    D0,.loc_003E                    ; $030BD0
        MOVE.B  D1,$0000(A6)                    ; $030BD4
        MOVE.B  #$80,$0009(A6)                  ; $030BD8
        RTS                                     ; $030BDE
