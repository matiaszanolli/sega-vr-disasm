; ============================================================================
; Sh2 Comm Send Cmd 027 (auto-analyzed)
; ROM Range: $0115A8-$011630 (136 bytes)
; ============================================================================
; Category: sh2
; Purpose: Orchestrator calling 3 subroutines
;   Accesses 32X registers: COMM0, COMM6, COMM4
;   RAM: $C87E (game_state)
;   Calls: dma_transfer, sh2_send_cmd
;
; Uses: D0, D1, A0, A1
; RAM:
;   $C87E: game_state
; Calls:
;   $00E35A: sh2_send_cmd
;   $00E52C: dma_transfer
; Confidence: high
; ============================================================================

fn_10200_027:
        CLR.W  D0                               ; $0115A8
        DC.W    $4EBA,$CF80         ; JSR     $00E52C(PC); $0115AA
.loc_0006:
        TST.B  $00A15120                        ; $0115AE
        BNE.S  .loc_0006                        ; $0115B4
        MOVE.W  #$0101,$00A1512C                ; $0115B6
        MOVE.W  #$8000,$00A15128                ; $0115BE
        MOVE.B  #$2C,$00A15121                  ; $0115C6
        MOVE.B  #$01,$00A15120                  ; $0115CE
.loc_002E:
        TST.B  $00A1512C                        ; $0115D6
        BNE.S  .loc_002E                        ; $0115DC
        MOVE.W  #$0050,$00A15128                ; $0115DE
        MOVE.W  #$0101,$00A1512C                ; $0115E6
        MOVEA.L #$26028000,A0                   ; $0115EE
        MOVE.L  (-24542).W,D0                   ; $0115F4
        ADDA.L  D0,A0                           ; $0115F8
        MOVEA.L #$24010018,A1                   ; $0115FA
        MOVE.W  #$0080,D0                       ; $011600
        MOVE.W  #$0050,D1                       ; $011604
        DC.W    $4EBA,$CD50         ; JSR     $00E35A(PC); $011608
        SUBQ.W  #1,(-24494).W                   ; $01160C
        BCC.S  .loc_0076                        ; $011610
        MOVE.W  #$0010,(-24494).W               ; $011612
        BCHG    #0,(-24496).W                   ; $011618
.loc_0076:
        DC.W    $6100,$065E         ; BSR.W  $011C7E; $01161E
        MOVE.W  #$0020,$00FF0008                ; $011622
        ADDQ.W  #4,(-14210).W                   ; $01162A
        RTS                                     ; $01162E
