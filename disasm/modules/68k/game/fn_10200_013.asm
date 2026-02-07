; ============================================================================
; Name Entry Sprite Update 013 (auto-analyzed)
; ROM Range: $0104A2-$0105DE (316 bytes)
; ============================================================================
; Category: game
; Purpose: Orchestrator calling 4 subroutines
;   RAM: $C87E (game_state)
;   Calls: dma_transfer, sprite_update, sh2_send_cmd
;   Object (A4): +$02 (flags/type)
;
; Entry: A4 = object/entity pointer
; Uses: D0, D1, A0, A1, A4
; RAM:
;   $C87E: game_state
; Calls:
;   $00B6DA: sprite_update
;   $00E35A: sh2_send_cmd
;   $00E52C: dma_transfer
; Object fields:
;   +$02: flags/type
; Confidence: high
; ============================================================================

fn_10200_013:
        CLR.W  D0                               ; $0104A2
        DC.W    $4EBA,$E086         ; JSR     $00E52C(PC); $0104A4
        DC.W    $4EBA,$B230         ; JSR     $00B6DA(PC); $0104A8
        MOVEA.L #$06014000,A0                   ; $0104AC
        MOVEA.L #$24014034,A1                   ; $0104B2
        MOVE.W  #$00D8,D0                       ; $0104B8
        MOVE.W  #$0050,D1                       ; $0104BC
        DC.W    $4EBA,$DE98         ; JSR     $00E35A(PC); $0104C0
        TST.W  (-24530).W                       ; $0104C4
        BPL.S  .loc_0064                        ; $0104C8
        MOVE.B  #$01,(-24532).W                 ; $0104CA
        MOVE.B  #$01,(-24531).W                 ; $0104D0
        SUBQ.W  #1,(-24528).W                   ; $0104D6
        BCC.S  .loc_0064                        ; $0104DA
        MOVE.W  #$0002,(-24522).W               ; $0104DC
        MOVE.B  #$01,(-14327).W                 ; $0104E2
        MOVE.B  #$01,(-14326).W                 ; $0104E8
        BSET    #7,(-14322).W                   ; $0104EE
        MOVE.B  #$01,(-14334).W                 ; $0104F4
        JSR     $0088205E                       ; $0104FA
        MOVE.W  #$0BB8,(-24528).W               ; $010500
.loc_0064:
        MOVEA.L (-24552).W,A0                   ; $010506
        BTST    #0,(-24556).W                   ; $01050A
        BNE.W  .loc_0076                        ; $010510
        MOVEA.L (-24548).W,A0                   ; $010514
.loc_0076:
        TST.B  (-24532).W                       ; $010518
        BEQ.W  .loc_009E                        ; $01051C
        MOVEA.L A0,A4                           ; $010520
        CLR.W  D0                               ; $010522
        MOVE.B  (A0),D0                         ; $010524
        CMPI.B  #$20,D0                         ; $010526
        BEQ.W  .loc_009E                        ; $01052A
        CMPI.B  #$03,D0                         ; $01052E
        BEQ.W  .loc_009E                        ; $010532
        MOVEA.L #$24034060,A1                   ; $010536
        DC.W    $6100,$0136         ; BSR.W  $010674; $01053C
.loc_009E:
        TST.B  (-24532).W                       ; $010540
        BEQ.W  .loc_00C6                        ; $010544
        MOVE.W  (A4),D0                         ; $010548
        ANDI.W  #$00FF,D0                       ; $01054A
        CMPI.B  #$20,D0                         ; $01054E
        BEQ.W  .loc_00C6                        ; $010552
        CMPI.B  #$03,D0                         ; $010556
        BEQ.W  .loc_00C6                        ; $01055A
        MOVEA.L #$24034090,A1                   ; $01055E
        DC.W    $6100,$010E         ; BSR.W  $010674; $010564
.loc_00C6:
        TST.B  (-24532).W                       ; $010568
        BEQ.W  .loc_00F0                        ; $01056C
        MOVE.B  $0002(A4),D0                    ; $010570
        ANDI.W  #$00FF,D0                       ; $010574
        CMPI.B  #$20,D0                         ; $010578
        BEQ.W  .loc_00F0                        ; $01057C
        CMPI.B  #$03,D0                         ; $010580
        BEQ.W  .loc_00F0                        ; $010584
        MOVEA.L #$240340C0,A1                   ; $010588
        DC.W    $6100,$00E4         ; BSR.W  $010674; $01058E
.loc_00F0:
        CMPI.W  #$0002,(-24522).W               ; $010592
        BEQ.W  .loc_011C                        ; $010598
        SUBQ.B  #1,(-24531).W                   ; $01059C
        BCC.S  .loc_0118                        ; $0105A0
        BCHG    #0,(-24532).W                   ; $0105A2
        MOVE.B  #$01,(-24531).W                 ; $0105A8
        BTST    #0,(-24532).W                   ; $0105AE
        BEQ.S  .loc_0118                        ; $0105B4
        SUBQ.W  #1,(-24530).W                   ; $0105B6
.loc_0118:
        BRA.W  .loc_0132                        ; $0105BA
.loc_011C:
        JSR     $0088FB36                       ; $0105BE
        BTST    #7,(-14322).W                   ; $0105C4
        BNE.S  .loc_0132                        ; $0105CA
        CLR.W  (-24522).W                       ; $0105CC
        ADDQ.W  #4,(-14210).W                   ; $0105D0
.loc_0132:
        MOVE.W  #$0018,$00FF0008                ; $0105D4
        RTS                                     ; $0105DC
