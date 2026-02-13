; ============================================================================
; FM Sound Priority Check — compare and accept higher-priority commands
; ROM Range: $030536-$03056A (52 bytes)
; ============================================================================
; Reads new sound command from A6+$0A, looks up its priority in table at
; $032B30 (128 entries, indexed by command-$81). Compares with current
; priority level (A6+$00). If new command has equal or higher priority,
; accepts it: updates priority, stores command byte to A6+$09. Otherwise
; discards the new command and keeps current state.
;
; Entry: A6 = sound channel state (+$00=priority, +$09=cmd, +$0A=new_cmd)
; Uses: D0, D1, D2, D3, A0, A1, A6
; Confidence: medium
; ============================================================================

fn_30200_011:
        DC.W    $41FA,$25F8         ; LEA     $032B30(PC),A0; $030536
        LEA     $000A(A6),A1                    ; $03053A
        MOVE.B  $0000(A6),D3                    ; $03053E
        MOVE.B  (A1),D0                         ; $030542
        MOVE.B  D0,D1                           ; $030544
        CLR.B  (A1)                             ; $030546
        SUBI.B  #$81,D0                         ; $030548
        BCS.S  .loc_002A                        ; $03054C
        ANDI.W  #$007F,D0                       ; $03054E
        MOVE.B  $00(A0,D0.W),D2                 ; $030552
        CMP.B  D3,D2                            ; $030556
        BCS.S  .loc_002A                        ; $030558
        MOVE.B  D2,D3                           ; $03055A
        MOVE.B  D1,$0009(A6)                    ; $03055C
.loc_002A:
        TST.B  D3                               ; $030560
        BMI.S  .loc_0032                        ; $030562
        MOVE.B  D3,$0000(A6)                    ; $030564
.loc_0032:
        RTS                                     ; $030568
