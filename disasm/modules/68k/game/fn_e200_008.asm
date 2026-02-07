; ============================================================================
; Sh2 Comm Object Update 008 (auto-analyzed)
; ROM Range: $00F682-$00F838 (438 bytes)
; ============================================================================
; Category: sh2
; Purpose: Orchestrator calling 6 subroutines
;   Accesses 32X registers: COMM0
;   RAM: $C87E (game_state)
;   Calls: sh2_send_cmd, object_update, sprite_update
;   Object (A0, A4): +$78, +$80
;
; Entry: A0 = object/entity pointer
; Entry: A4 = object/entity pointer
; Uses: D0, D1, D2, D3, D6, A0, A1, A2
; RAM:
;   $C87E: game_state
; Calls:
;   $00B684: object_update
;   $00B6DA: sprite_update
;   $00E35A: sh2_send_cmd
; Object fields:
;   +$78: [unknown]
;   +$80: [unknown]
; Confidence: high
; ============================================================================

fn_e200_008:
        DC.W    $0603                           ; $00F682
        CMP.B  D0,D3                            ; $00F684
        DC.W    $0401                           ; $00F686
        MOVE.L  -(A4),D0                        ; $00F688
        ORI.W  #$0010,-(A0)                     ; $00F68A
        DC.W    $0603                           ; $00F68E
        CMP.B  D0,D6                            ; $00F690
        DC.W    $0401                           ; $00F692
        NEGX.B (A4)                             ; $00F694
        ORI.L  #$00100603,D0                    ; $00F696
        DC.W    $C400                           ; $00F69C
        DC.W    $0401                           ; $00F69E
        MOVEQ   #$30,D0                         ; $00F6A0
        DC.W    $0048                           ; $00F6A2
        DC.W    $0010                           ; $00F6A4
        DC.W    $0603                           ; $00F6A6
        DC.W    $C880                           ; $00F6A8
        DC.W    $0401                           ; $00F6AA
        SUB.B  (A0)+,D0                         ; $00F6AC
        ORI.W  #$0020,($0603).W                 ; $00F6AE
        CMP.B  D0,D3                            ; $00F6B4
        DC.W    $0401                           ; $00F6B6
        MOVE.L  #$00600010,(A0)                 ; $00F6B8
        DC.W    $0603                           ; $00F6BE
        CMP.B  D0,D6                            ; $00F6C0
        DC.W    $0401                           ; $00F6C2
        NEGX.L $0080(A4)                        ; $00F6C4
        DC.W    $0010                           ; $00F6C8
        DC.W    $0603                           ; $00F6CA
        DC.W    $C400                           ; $00F6CC
        DC.W    $0401                           ; $00F6CE
        MOVEQ   #-$38,D0                        ; $00F6D0
        DC.W    $0048                           ; $00F6D2
        DC.W    $0010                           ; $00F6D4
        DC.W    $0603                           ; $00F6D6
        DC.W    $C880                           ; $00F6D8
        DC.W    $0401                           ; $00F6DA
        SUB.L  $78(A0,D0.W),D0                  ; $00F6DC
        DC.W    $0020                           ; $00F6E0
.loc_0060:
        TST.B  $00A15120                        ; $00F6E2
        BNE.S  .loc_0060                        ; $00F6E8
        DC.W    $6100,$022A         ; BSR.W  $00F916; $00F6EA
        LEA     $0088F838,A2                    ; $00F6EE
        MOVE.W  #$0002,D2                       ; $00F6F4
.loc_0076:
        MOVEA.L (A2)+,A0                        ; $00F6F8
        MOVEA.L (A2)+,A1                        ; $00F6FA
        MOVE.W  (A2)+,D0                        ; $00F6FC
        MOVE.W  (A2)+,D1                        ; $00F6FE
        DC.W    $4EBA,$EC58         ; JSR     $00E35A(PC); $00F700
        DBRA    D2,.loc_0076                    ; $00F704
        CLR.W  D0                               ; $00F708
        MOVE.B  (-24549).W,D0                   ; $00F70A
        DC.W    $6100,$017C         ; BSR.W  $00F88C; $00F70E
        DC.W    $4EBA,$BF70         ; JSR     $00B684(PC); $00F712
        DC.W    $4EBA,$BFC2         ; JSR     $00B6DA(PC); $00F716
        CMPI.W  #$0001,(-24540).W               ; $00F71A
        BEQ.W  .loc_0176                        ; $00F720
        CMPI.W  #$0002,(-24540).W               ; $00F724
        BEQ.W  .loc_018A                        ; $00F72A
        MOVE.W  (-14228).W,D1                   ; $00F72E
        ANDI.B  #$E0,D1                         ; $00F732
        BNE.S  .loc_00DE                        ; $00F736
        MOVE.W  (-14226).W,D1                   ; $00F738
        MOVE.W  D1,D2                           ; $00F73C
        ANDI.B  #$E0,D2                         ; $00F73E
        BNE.S  .loc_00DE                        ; $00F742
        ANDI.B  #$10,D1                         ; $00F744
        BNE.S  .loc_00DA                        ; $00F748
        MOVE.W  (-14228).W,D1                   ; $00F74A
        ANDI.B  #$10,D1                         ; $00F74E
        BNE.S  .loc_00DA                        ; $00F752
        SUBQ.W  #4,(-14210).W                   ; $00F754
        BRA.W  .loc_01A6                        ; $00F758
.loc_00DA:
        ST      (-24552).W                      ; $00F75C
.loc_00DE:
        MOVE.B  #$A8,(-14172).W                 ; $00F760
        TST.B  (-24549).W                       ; $00F766
        BEQ.S  .loc_0108                        ; $00F76A
        CMPI.B  #$01,(-24549).W                 ; $00F76C
        BEQ.S  .loc_011C                        ; $00F772
        MOVE.B  (-24545).W,(-333).W             ; $00F774
        MOVE.B  (-24544).W,(-337).W             ; $00F77A
        MOVE.B  (-24551).W,(-339).W             ; $00F780
        BRA.W  .loc_012E                        ; $00F786
.loc_0108:
        MOVE.B  (-24551).W,(-333).W             ; $00F78A
        MOVE.B  (-24544).W,(-337).W             ; $00F790
        MOVE.B  (-24543).W,(-339).W             ; $00F796
        BRA.S  .loc_012E                        ; $00F79C
.loc_011C:
        MOVE.B  (-24545).W,(-333).W             ; $00F79E
        MOVE.B  (-24551).W,(-337).W             ; $00F7A4
        MOVE.B  (-24543).W,(-339).W             ; $00F7AA
.loc_012E:
        CMPI.B  #$01,(-24548).W                 ; $00F7B0
        BEQ.S  .loc_0144                        ; $00F7B6
        MOVE.B  (-24542).W,(-336).W             ; $00F7B8
        MOVE.B  (-24550).W,(-338).W             ; $00F7BE
        BRA.S  .loc_0150                        ; $00F7C4
.loc_0144:
        MOVE.B  (-24550).W,(-336).W             ; $00F7C6
        MOVE.B  (-24541).W,(-338).W             ; $00F7CC
.loc_0150:
        CLR.B  (-24546).W                       ; $00F7D2
        MOVE.B  #$01,(-14327).W                 ; $00F7D6
        MOVE.B  #$01,(-14326).W                 ; $00F7DC
        BSET    #7,(-14322).W                   ; $00F7E2
        MOVE.B  #$01,(-14334).W                 ; $00F7E8
        MOVE.W  #$0002,(-24540).W               ; $00F7EE
        BRA.W  .loc_01A2                        ; $00F7F4
.loc_0176:
        DC.W    $6100,$033C         ; BSR.W  $00FB36; $00F7F8
        BTST    #6,(-14322).W                   ; $00F7FC
        BNE.S  .loc_01A2                        ; $00F802
        CLR.W  (-24540).W                       ; $00F804
        BRA.W  .loc_01A2                        ; $00F808
.loc_018A:
        DC.W    $6100,$0328         ; BSR.W  $00FB36; $00F80C
        BTST    #7,(-14322).W                   ; $00F810
        BNE.S  .loc_01A2                        ; $00F816
        CLR.W  (-24540).W                       ; $00F818
        ADDQ.W  #4,(-14210).W                   ; $00F81C
        BRA.W  .loc_01A6                        ; $00F820
.loc_01A2:
        SUBQ.W  #4,(-14210).W                   ; $00F824
.loc_01A6:
        MOVE.W  #$0018,$00FF0008                ; $00F828
        MOVE.B  #$01,(-14303).W                 ; $00F830
        RTS                                     ; $00F836
