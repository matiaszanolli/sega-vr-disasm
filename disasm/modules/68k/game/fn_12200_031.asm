; ============================================================================
; Camera Object Update 031 (auto-analyzed)
; ROM Range: $0134C8-$0135C4 (252 bytes)
; ============================================================================
; Category: game
; Purpose: Orchestrator calling 4 subroutines
;   RAM: $C87E (game_state)
;   Calls: dma_transfer, object_update, sprite_update
;   Object (A0): +$00
;
; Entry: A0 = object/entity pointer
; Uses: D0, D1, D2, D5, A0, A1, A6
; RAM:
;   $C87E: game_state
; Calls:
;   $00B684: object_update
;   $00B6DA: sprite_update
;   $00E52C: dma_transfer
; Object fields:
;   +$00: [unknown]
; Confidence: high
; ============================================================================

fn_12200_031:
        DC.W    $0400                           ; $0134C8
        SUB.B  ($0400).W,D0                     ; $0134CA
        AND.B  ($0400).W,D0                     ; $0134CE
        DC.W    $F038                           ; $0134D2
        DC.W    $0401                           ; $0134D4
        MOVE.L  ($0401).W,D0                    ; $0134D6
        ADDQ.B  #8,($0401).W                    ; $0134DA
        CMP.B  (-25600).W,D0                    ; $0134DE
        DC.W    $A8A3                           ; $0134E2
        DC.W    $B546                           ; $0134E4
        MULS    -$3238(A1),D0                   ; $0134E6
        DC.W    $D20B                           ; $0134EA
        ADD.W  -$1D2F(A6),D5                    ; $0134EC
        CLR.W  D0                               ; $0134F0
        DC.W    $4EBA,$B038         ; JSR     $00E52C(PC); $0134F2
        DC.W    $4EBA,$818C         ; JSR     $00B684(PC); $0134F6
        DC.W    $4EBA,$81DE         ; JSR     $00B6DA(PC); $0134FA
        CMPI.W  #$0001,(-24536).W               ; $0134FE
        BEQ.W  .loc_00BA                        ; $013504
        CMPI.W  #$0002,(-24536).W               ; $013508
        BEQ.W  .loc_00D0                        ; $01350E
        JSR     $0088179E                       ; $013512
        MOVE.W  (-14228).W,D1                   ; $013518
        DC.W    $6100,$00A6         ; BSR.W  $0135C4; $01351C
        MOVE.W  (-14226).W,D1                   ; $013520
        DC.W    $6100,$009E         ; BSR.W  $0135C4; $013524
        TST.W  (-24542).W                       ; $013528
        BEQ.W  .loc_00EA                        ; $01352C
        CMPI.W  #$0001,(-24542).W               ; $013530
        BNE.W  .loc_009A                        ; $013536
        MOVE.B  #$01,(-14327).W                 ; $01353A
        MOVE.B  #$01,(-14326).W                 ; $013540
        BSET    #7,(-14322).W                   ; $013546
        MOVE.B  #$01,(-14334).W                 ; $01354C
        JSR     $0088205E                       ; $013552
        MOVE.W  #$0002,(-24536).W               ; $013558
        BRA.W  .loc_00EE                        ; $01355E
.loc_009A:
        CLR.W  D0                               ; $013562
        LEA     $008936AA,A0                    ; $013564
        CLR.W  D2                               ; $01356A
        MOVE.B  (-24551).W,D2                   ; $01356C
        DC.W    $D442                           ; $013570
        DC.W    $D442                           ; $013572
        MOVEA.L $00(A0,D2.W),A0                 ; $013574
        MOVE.W  #$0001,D2                       ; $013578
        JSR     (A0)                            ; $01357C
        BRA.W  .loc_00EE                        ; $01357E
.loc_00BA:
        JSR     $0088FB36                       ; $013582
        BTST    #6,(-14322).W                   ; $013588
        BNE.S  .loc_00EA                        ; $01358E
        CLR.W  (-24536).W                       ; $013590
        BRA.W  .loc_00EA                        ; $013594
.loc_00D0:
        JSR     $0088FB36                       ; $013598
        BTST    #7,(-14322).W                   ; $01359E
        BNE.S  .loc_00EA                        ; $0135A4
        CLR.W  (-24536).W                       ; $0135A6
        ADDQ.W  #4,(-14210).W                   ; $0135AA
        BRA.W  .loc_00EE                        ; $0135AE
.loc_00EA:
        SUBQ.W  #4,(-14210).W                   ; $0135B2
.loc_00EE:
        CLR.W  (-24542).W                       ; $0135B6
        MOVE.W  #$0018,$00FF0008                ; $0135BA
        RTS                                     ; $0135C2
