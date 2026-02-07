; ============================================================================
; Name Entry 019 (auto-analyzed)
; ROM Range: $010796-$01084C (182 bytes)
; ============================================================================
; Category: game
; Purpose: Function in 10200 section (182 bytes)
;
; Uses: D0, A0, A1, A4
; Confidence: low
; ============================================================================

fn_10200_019:
        SUBQ.B  #1,(-24531).W                   ; $010796
        BCC.S  .loc_0012                        ; $01079A
        BCHG    #0,(-24532).W                   ; $01079C
        MOVE.B  #$00,(-24531).W                 ; $0107A2
.loc_0012:
        TST.B  (-24544).W                       ; $0107A8
        BEQ.W  .loc_006E                        ; $0107AC
        CMPI.B  #$01,(-24544).W                 ; $0107B0
        BEQ.W  .loc_0088                        ; $0107B6
        MOVEA.L A0,A4                           ; $0107BA
        CLR.W  D0                               ; $0107BC
        MOVE.B  (A0),D0                         ; $0107BE
        CMPI.B  #$20,D0                         ; $0107C0
        BEQ.W  .loc_003C                        ; $0107C4
        MOVEA.L #$24034060,A1                   ; $0107C8
        DC.W    $6100,$FEA4         ; BSR.W  $010674; $0107CE
.loc_003C:
        MOVE.W  (A4),D0                         ; $0107D2
        ANDI.W  #$00FF,D0                       ; $0107D4
        CMPI.B  #$20,D0                         ; $0107D8
        BEQ.W  .loc_0054                        ; $0107DC
        MOVEA.L #$24034090,A1                   ; $0107E0
        DC.W    $6100,$FE8C         ; BSR.W  $010674; $0107E6
.loc_0054:
        TST.B  (-24532).W                       ; $0107EA
        BEQ.W  .loc_00B4                        ; $0107EE
        MOVE.W  (-24540).W,D0                   ; $0107F2
        MOVEA.L #$240340C0,A1                   ; $0107F6
        DC.W    $6100,$FE76         ; BSR.W  $010674; $0107FC
        BRA.W  .loc_00B4                        ; $010800
.loc_006E:
        TST.B  (-24532).W                       ; $010804
        BEQ.W  .loc_00B4                        ; $010808
        MOVE.W  (-24540).W,D0                   ; $01080C
        MOVEA.L #$24034060,A1                   ; $010810
        DC.W    $6100,$FE5C         ; BSR.W  $010674; $010816
        BRA.W  .loc_00B4                        ; $01081A
.loc_0088:
        CLR.W  D0                               ; $01081E
        MOVE.B  (A0),D0                         ; $010820
        CMPI.B  #$20,D0                         ; $010822
        BEQ.W  .loc_009E                        ; $010826
        MOVEA.L #$24034060,A1                   ; $01082A
        DC.W    $6100,$FE42         ; BSR.W  $010674; $010830
.loc_009E:
        TST.B  (-24532).W                       ; $010834
        BEQ.W  .loc_00B4                        ; $010838
        MOVE.W  (-24540).W,D0                   ; $01083C
        MOVEA.L #$24034090,A1                   ; $010840
        DC.W    $6100,$FE2C         ; BSR.W  $010674; $010846
.loc_00B4:
        RTS                                     ; $01084A
