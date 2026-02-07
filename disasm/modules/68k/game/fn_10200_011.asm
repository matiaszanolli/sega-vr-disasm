; ============================================================================
; Name Entry Object Update 011 (auto-analyzed)
; ROM Range: $01035C-$0103C4 (104 bytes)
; ============================================================================
; Category: game
; Purpose: Orchestrator calling 5 subroutines
;   RAM: $C87E (game_state)
;   Calls: dma_transfer, object_update, sh2_send_cmd
;
; Uses: D0, D1, A0, A1, A2
; RAM:
;   $C87E: game_state
; Calls:
;   $00B684: object_update
;   $00E35A: sh2_send_cmd
;   $00E52C: dma_transfer
; Confidence: medium
; ============================================================================

fn_10200_011:
        CLR.W  D0                               ; $01035C
        DC.W    $6100,$E1CC         ; BSR.W  $00E52C; $01035E
        DC.W    $4EBA,$B320         ; JSR     $00B684(PC); $010362
        DC.W    $6100,$03B4         ; BSR.W  $01071C; $010366
        MOVEA.L #$0601C300,A0                   ; $01036A
        MOVEA.L #$2400E030,A1                   ; $010370
        MOVE.W  #$0080,D0                       ; $010376
        MOVE.W  #$0020,D1                       ; $01037A
        DC.W    $4EBA,$DFDA         ; JSR     $00E35A(PC); $01037E
        LEA     $2402F0C0,A1                    ; $010382
        LEA     (-1464).W,A2                    ; $010388
        MOVEQ   #$00,D0                         ; $01038C
        MOVE.B  (-335).W,D0                     ; $01038E
        DC.W    $D040                           ; $010392
        DC.W    $D040                           ; $010394
        DC.W    $D040                           ; $010396
        MOVE.W  D0,D1                           ; $010398
        DC.W    $D040                           ; $01039A
        DC.W    $D041                           ; $01039C
        DC.W    $D040                           ; $01039E
        ADDA.L  D0,A2                           ; $0103A0
        MOVEQ   #$00,D0                         ; $0103A2
        MOVE.B  (-347).W,D0                     ; $0103A4
        DC.W    $D040                           ; $0103A8
        DC.W    $D040                           ; $0103AA
        DC.W    $D040                           ; $0103AC
        ADDQ.W  #4,D0                           ; $0103AE
        ADDA.L  D0,A2                           ; $0103B0
        DC.W    $6100,$0252         ; BSR.W  $010606; $0103B2
        ADDQ.W  #4,(-14210).W                   ; $0103B6
        MOVE.W  #$0020,$00FF0008                ; $0103BA
        RTS                                     ; $0103C2
