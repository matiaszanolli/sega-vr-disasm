; ============================================================================
; Scene Fastcopy16 011 (auto-analyzed)
; ROM Range: $00C7C2-$00C8E6 (292 bytes)
; ============================================================================
; Category: game
; Purpose: RAM: $C8CC (race_substate)
;   Calls: FastCopy16
;   Object (A1): +$00
;
; Entry: A1 = object/entity pointer
; Uses: D0, D1, D3, D4, D7, A0, A1, A2
; RAM:
;   $C8CC: race_substate
; Calls:
;   $004922: FastCopy16
; Object fields:
;   +$00: [unknown]
; Confidence: medium
; ============================================================================

fn_c200_011:
        SUBI.L  #$04830471,$046E(A1)            ; $00C7C2
        SUBI.W  #$0456,-(A2)                    ; $00C7CA
        SUBI.W  #$0433,D4                       ; $00C7CE
        DC.W    $0429                           ; $00C7D2
        DC.W    $040E                           ; $00C7D4
        DC.W    $03F3                           ; $00C7D6
        BSET    D1,-(A2)                        ; $00C7D8
        BSET    D1,(A7)                         ; $00C7DA
        BSET    D1,D1                           ; $00C7DC
        BSET    D1,D0                           ; $00C7DE
        DC.W    $003A                           ; $00C7E0
        ORI.W  #$0064,(A0)                      ; $00C7E2
        ORI.L  #$41F90089,D3                    ; $00C7E6
        DC.W    $AF3C                           ; $00C7EC
        LEA     (-4344).W,A1                    ; $00C7EE
        JSR     $008813B4                       ; $00C7F2
        LEA     $0089B6AC,A1                    ; $00C7F8
        LEA     (-1464).W,A2                    ; $00C7FE
        DC.W    $4EBA,$80E6         ; JSR     $0048EA(PC); $00C802
        DC.W    $4EBA,$811A         ; JSR     $004922(PC); $00C806
        LEA     $0089B73C,A1                    ; $00C80A
        LEA     (-598).W,A2                     ; $00C810
        MOVEQ   #$35,D7                         ; $00C814
.loc_0054:
        MOVE.L  (A1)+,(A2)+                     ; $00C816
        DBRA    D7,.loc_0054                    ; $00C818
        MOVEQ   #$00,D0                         ; $00C81C
        MOVE.B  D0,(-347).W                     ; $00C81E
        MOVE.B  D0,(-346).W                     ; $00C822
        MOVE.B  D0,(-341).W                     ; $00C826
        MOVE.B  D0,(-345).W                     ; $00C82A
        MOVE.B  D0,(-600).W                     ; $00C82E
        MOVE.B  D0,(-4345).W                    ; $00C832
        MOVE.B  D0,(-329).W                     ; $00C836
        MOVE.B  D0,(-335).W                     ; $00C83A
        MOVE.B  #$02,(-339).W                   ; $00C83E
        MOVE.B  #$02,(-338).W                   ; $00C844
        MOVE.B  #$FF,(-348).W                   ; $00C84A
        MOVE.B  #$00,(-14299).W                 ; $00C850
        JMP     $0088A83E                       ; $00C856
.loc_009A:
        MOVEQ   #$00,D1                         ; $00C85C
        LEA     $00FF6000,A1                    ; $00C85E
        JSR     $00884836                       ; $00C864
        JMP     $0088483E                       ; $00C86A
        BSR.S  .loc_009A                        ; $00C870
        MOVE.W  (-14132).W,D0                   ; $00C872
        LEA     $00895488,A1                    ; $00C876
        MOVEA.L $00(A1,D0.W),A1                 ; $00C87C
        TST.B  (-14321).W                       ; $00C880
        BEQ.S  .loc_00E4                        ; $00C884
        LEA     $00895560,A1                    ; $00C886
        MOVEA.L $00(A1,D0.W),A1                 ; $00C88C
        LEA     $00FF6330,A2                    ; $00C890
        JSR     $00884920                       ; $00C896
        LEA     $008954F4,A1                    ; $00C89C
        MOVEA.L $00(A1,D0.W),A1                 ; $00C8A2
.loc_00E4:
        LEA     $00FF6100,A2                    ; $00C8A6
        JSR     $00884920                       ; $00C8AC
        MOVE.W  (A1)+,(-16300).W                ; $00C8B2
        MOVE.W  (A1)+,(-16298).W                ; $00C8B6
        MOVE.L  (A1)+,(-16184).W                ; $00C8BA
        MOVE.W  (A1)+,(-16180).W                ; $00C8BE
        MOVE.W  (A1),$00FF60CC                  ; $00C8C2
        MOVE.W  #$0070,$00FF60CE                ; $00C8C8
        LEA     (-16210).W,A1                   ; $00C8D0
        MOVEQ   #$00,D1                         ; $00C8D4
        MOVE.L  D1,(A1)+                        ; $00C8D6
        MOVE.L  D1,(A1)+                        ; $00C8D8
        MOVE.L  D1,(A1)                         ; $00C8DA
        MOVE.L  #$00FF9000,(-14200).W           ; $00C8DC
        RTS                                     ; $00C8E4
