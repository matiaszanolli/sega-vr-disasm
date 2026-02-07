; ============================================================================
; Ai Dispatch 023 (auto-analyzed)
; ROM Range: $00B65A-$00B6D0 (118 bytes)
; ============================================================================
; Category: game
; Purpose: State dispatcher using jump table
;
; Uses: D0, D1, A1, A2
; Confidence: medium
; ============================================================================

fn_a200_023:
        MOVE.B  #$01,(-14334).W                 ; $00B65A
        LEA     (-31616).W,A2                   ; $00B660
        DC.W    $4EBA,$000A         ; JSR     $00B670(PC); $00B664
        DC.W    $4EBA,$0006         ; JSR     $00B670(PC); $00B668
        DC.W    $4EBA,$0002         ; JSR     $00B670(PC); $00B66C
        LEA     $008BA000,A1                    ; $00B670
        MOVEQ   #$00,D1                         ; $00B676
        MOVE.B  D0,D1                           ; $00B678
        ROR.L  #8,D0                            ; $00B67A
        LSL.W  #5,D1                            ; $00B67C
        ADDA.W  D1,A1                           ; $00B67E
        DC.W    $4EFA,$9298         ; JMP     $00491A(PC); $00B680
        BTST    #6,(-14322).W                   ; $00B684
        BEQ.S  .loc_0074                        ; $00B68A
        SUBQ.B  #1,(-14326).W                   ; $00B68C
        BNE.S  .loc_0074                        ; $00B690
        MOVE.B  (-14327).W,(-14326).W           ; $00B692
        MOVEQ   #$00,D0                         ; $00B698
        MOVE.B  (-14299).W,D0                   ; $00B69A
        BNE.S  .loc_0052                        ; $00B69E
        MOVEA.L (-13972).W,A1                   ; $00B6A0
        LEA     (-31616).W,A2                   ; $00B6A4
        DC.W    $4EBA,$9240         ; JSR     $0048EA(PC); $00B6A8
.loc_0052:
        MOVE.B  $00B6D0(PC,D0.W),D1             ; $00B6AC
        MOVE.B  D1,$00FF60D5                    ; $00B6B0
        ADDQ.B  #1,D0                           ; $00B6B6
        MOVE.B  D0,(-14299).W                   ; $00B6B8
        CMPI.B  #$0A,D0                         ; $00B6BC
        BNE.S  .loc_0074                        ; $00B6C0
        MOVE.B  #$00,(-14299).W                 ; $00B6C2
        BCLR    #6,(-14322).W                   ; $00B6C8
.loc_0074:
        RTS                                     ; $00B6CE
