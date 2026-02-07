; ============================================================================
; Logic Dispatch 008 (auto-analyzed)
; ROM Range: $00471E-$0047CA (172 bytes)
; ============================================================================
; Category: game
; Purpose: State dispatcher using jump table
;   RAM: $C87E (game_state), $C048 (camera_state), $C07C (input_state), $C8AA (scene_state)
;
; Uses: D0, A1, A5
; RAM:
;   $C048: camera_state
;   $C07C: input_state
;   $C87E: game_state
;   $C8AA: scene_state
; Confidence: high
; ============================================================================

fn_4200_008:
        BTST    #5,(-15602).W                   ; $00471E
        BNE.S  .loc_0010                        ; $004724
        MOVE.L  #$60000000,(-15776).W           ; $004726
.loc_0010:
        ANDI.B  #$7F,(-14322).W                 ; $00472E
        MOVE.W  #$0000,(-14210).W               ; $004734
        MOVEQ   #$00,D0                         ; $00473A
        MOVE.W  D0,(-14208).W                   ; $00473C
        MOVE.W  D0,(-14206).W                   ; $004740
        MOVE.W  #$8B00,(A5)                     ; $004744
        MOVE.W  #$0000,(-14168).W               ; $004748
        MOVE.W  #$0020,$00FF0008                ; $00474E
        MOVE.L  #$0088FB98,$00FF0002            ; $004756
        MOVE.B  #$00,(-14336).W                 ; $004760
        DC.W    $4EFA,$E128         ; JMP     $002890(PC); $004766
        MOVE.W  #$0001,(-16312).W               ; $00476A
        MOVE.W  (-16260).W,D0                   ; $004770
        MOVEA.L $00477A(PC,D0.W),A1             ; $004774
        JMP     (A1)                            ; $004778
        DC.W    $0088                           ; $00477A
        DC.W    $478A                           ; $00477C
        DC.W    $0088                           ; $00477E
        DC.W    $479E                           ; $004780
        DC.W    $0088                           ; $004782
        DC.W    $47CA                           ; $004784
        DC.W    $0088                           ; $004786
        DC.W    $47E4                           ; $004788
        MOVE.B  #$01,(-14336).W                 ; $00478A
        MOVE.W  #$0000,(-14166).W               ; $004790
        ADDQ.W  #4,(-16260).W                   ; $004796
        DC.W    $4EFA,$6AC2         ; JMP     $00B25E(PC); $00479A
        CMPI.W  #$0028,(-14166).W               ; $00479E
        BNE.S  .loc_00AA                        ; $0047A4
        MOVE.W  #$0000,(-14166).W               ; $0047A6
        ADDQ.W  #4,(-16260).W                   ; $0047AC
        MOVE.B  #$01,(-14327).W                 ; $0047B0
        MOVE.B  #$01,(-14326).W                 ; $0047B6
        BSET    #7,(-14322).W                   ; $0047BC
        MOVE.B  #$01,(-14334).W                 ; $0047C2
.loc_00AA:
        RTS                                     ; $0047C8
