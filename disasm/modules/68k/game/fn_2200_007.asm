; ============================================================================
; Vint Dispatch 007 (auto-analyzed)
; ROM Range: $00232A-$0023C2 (152 bytes)
; ============================================================================
; Category: vint
; Purpose: State dispatcher using jump table
;   RAM: $C8C8 (vint_state)
;
; Uses: D0, D1, A1
; RAM:
;   $C8C8: vint_state
; Confidence: medium
; ============================================================================

fn_2200_007:
        DC.W    $AFAD                           ; $00232A
        DC.W    $AE00                           ; $00232C
        MOVE.W  (-28556).W,D0                   ; $00232E
        LEA     (-30832).W,A1                   ; $002332
        BTST    #4,(-28443).W                   ; $002336
        BEQ.S  .loc_002E                        ; $00233C
        CMPI.B  #$01,(-14301).W                 ; $00233E
        BEQ.S  .loc_0040                        ; $002344
        MOVE.B  #$01,(-14301).W                 ; $002346
        MOVE.W  (-14136).W,D0                   ; $00234C
        MOVE.B  $00232A(PC,D0.W),(-14171).W     ; $002350
        BRA.S  .loc_0040                        ; $002356
.loc_002E:
        TST.B  (-14301).W                       ; $002358
        BEQ.S  .loc_0040                        ; $00235C
        MOVE.B  #$00,(-14301).W                 ; $00235E
        MOVE.B  #$AB,(-14171).W                 ; $002364
.loc_0040:
        BTST    #1,(-14325).W                   ; $00236A
        BEQ.S  .loc_005A                        ; $002370
        MOVE.B  (-14296).W,(-30839).W           ; $002372
        MOVE.B  #$01,(-31466).W                 ; $002378
        BCLR    #1,(-14325).W                   ; $00237E
.loc_005A:
        CMPI.W  #$0000,(-14136).W               ; $002384
        DC.W    $6750               ; BEQ.S  $0023DC; $00238A
        CMPI.W  #$0002,(-14136).W               ; $00238C
        DC.W    $6700,$0092         ; BEQ.W  $002426; $002392
        LSR.W  #5,D0                            ; $002396
        MOVE.W  D0,D1                           ; $002398
        LSR.W  #2,D0                            ; $00239A
        DC.W    $D240                           ; $00239C
        LSR.W  #1,D0                            ; $00239E
        DC.W    $D240                           ; $0023A0
        ADDI.W  #$1A5E,D1                       ; $0023A2
        ADD.W  (A1),D1                          ; $0023A6
        LSR.W  #1,D1                            ; $0023A8
        CMPI.W  #$1E00,D1                       ; $0023AA
        DC.W    $6E12               ; BGT.S  $0023C2; $0023AE
        CMPI.W  #$1A5E,D1                       ; $0023B0
        DC.W    $6E10               ; BGT.S  $0023C6; $0023B4
        MOVE.W  #$1A5E,D1                       ; $0023B6
        MOVE.W  D1,(A1)                         ; $0023BA
        MOVE.W  (A1),(-30880).W                 ; $0023BC
        RTS                                     ; $0023C0
