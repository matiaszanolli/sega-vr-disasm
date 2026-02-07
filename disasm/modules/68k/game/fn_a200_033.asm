; ============================================================================
; Ai Camera 033 (auto-analyzed)
; ROM Range: $00BA5E-$00BC1C (446 bytes)
; ============================================================================
; Category: game
; Purpose: RAM: $C082 (menu_state), $C048 (camera_state), $C8A0 (race_state)
;   Object (A0): +$00, +$10, +$2A, +$76, +$78
;
; Entry: A0 = object/entity pointer
; Uses: D0, A0
; RAM:
;   $C048: camera_state
;   $C082: menu_state
;   $C8A0: race_state
; Object fields:
;   +$00: [unknown]
;   +$10: [unknown]
;   +$2A: [unknown]
;   +$76: [unknown]
;   +$78: [unknown]
; Confidence: high
; ============================================================================

fn_a200_033:
        MOVE.W  #$0000,(-16178).W               ; $00BA5E
        MOVE.W  #$0020,(-16262).W               ; $00BA64
        MOVE.B  #$00,(-15608).W                 ; $00BA6A
        MOVE.W  #$0000,(-16254).W               ; $00BA70
        MOVE.W  #$0001,(-16312).W               ; $00BA76
        MOVE.B  #$04,(-15614).W                 ; $00BA7C
        CLR.W  (-24344).W                       ; $00BA82
        CLR.W  (-24340).W                       ; $00BA86
        CLR.W  (-24342).W                       ; $00BA8A
        CLR.W  (-24338).W                       ; $00BA8E
        CLR.W  (-24336).W                       ; $00BA92
        CLR.W  (-24332).W                       ; $00BA96
        CLR.W  (-24330).W                       ; $00BA9A
        LEA     (-28672).W,A0                   ; $00BA9E
        MOVE.W  #$0001,$002A(A0)                ; $00BAA2
        MOVE.W  #$0100,$0076(A0)                ; $00BAA8
        MOVE.W  #$0100,$0078(A0)                ; $00BAAE
        CLR.B  (-15601).W                       ; $00BAB4
        MOVE.W  #$0010,(-24346).W               ; $00BAB8
        LEA     $00897000,A0                    ; $00BABE
        MOVE.W  (-14176).W,D0                   ; $00BAC4
        MOVEA.L $00(A0,D0.W),A0                 ; $00BAC8
        LEA     $0010(A0),A0                    ; $00BACC
        DC.W    $4EFA,$0208         ; JMP     $00BCDA(PC); $00BAD0
        BTST    #6,(-14322).W                   ; $00BAD4
        BNE.W  .loc_01BC                        ; $00BADA
        TST.W  (-16256).W                       ; $00BADE
        BNE.W  .loc_012A                        ; $00BAE2
        CMPI.B  #$0D,(-14320).W                 ; $00BAE6
        BNE.S  .loc_00B0                        ; $00BAEC
        MOVE.B  (-14225).W,D0                   ; $00BAEE
        MOVE.B  #$01,(-14309).W                 ; $00BAF2
        BTST    #7,D0                           ; $00BAF8
        BNE.S  .loc_00DE                        ; $00BAFC
        MOVE.B  #$00,(-14309).W                 ; $00BAFE
        MOVE.B  (-14227).W,D0                   ; $00BB04
        BTST    #7,D0                           ; $00BB08
        BNE.S  .loc_00DE                        ; $00BB0C
.loc_00B0:
        TST.B  (-15608).W                       ; $00BB0E
        BEQ.W  .loc_01BC                        ; $00BB12
        MOVE.B  #$F0,(-14302).W                 ; $00BB16
        MOVE.B  #$01,(-14327).W                 ; $00BB1C
        MOVE.B  #$02,(-14326).W                 ; $00BB22
        BSET    #7,(-14322).W                   ; $00BB28
        MOVE.B  #$01,(-14334).W                 ; $00BB2E
        MOVE.W  #$0001,(-16256).W               ; $00BB34
        BRA.S  .loc_012A                        ; $00BB3A
.loc_00DE:
        OR.B   (-14228).W,D0                    ; $00BB3C
        MOVE.B  #$01,(-14327).W                 ; $00BB40
        MOVE.B  #$4B,(-14326).W                 ; $00BB46
        BSET    #7,(-14322).W                   ; $00BB4C
        MOVE.B  #$01,(-14334).W                 ; $00BB52
        MOVE.W  #$0002,(-16256).W               ; $00BB58
        MOVE.W  #$0038,(-24342).W               ; $00BB5E
        TST.W  (-24336).W                       ; $00BB64
        BNE.S  .loc_011E                        ; $00BB68
        MOVE.W  #$0001,(-24336).W               ; $00BB6A
        MOVE.B  #$9D,(-31478).W                 ; $00BB70
        MOVE.B  #$F0,(-14302).W                 ; $00BB76
.loc_011E:
        TST.W  (-24332).W                       ; $00BB7C
        BNE.S  .loc_012A                        ; $00BB80
        MOVE.W  #$003C,(-24332).W               ; $00BB82
.loc_012A:
        TST.W  (-24332).W                       ; $00BB88
        BEQ.S  .loc_0138                        ; $00BB8C
        SUBQ.W  #1,(-24332).W                   ; $00BB8E
        BGT.W  .loc_01BC                        ; $00BB92
.loc_0138:
        BTST    #7,(-14322).W                   ; $00BB96
        BNE.W  .loc_01BC                        ; $00BB9C
        MOVEQ   #$00,D0                         ; $00BBA0
        MOVE.W  D0,(-14208).W                   ; $00BBA2
        MOVE.W  D0,(-14206).W                   ; $00BBA6
        MOVE.W  #$0000,(-14168).W               ; $00BBAA
        MOVE.W  #$0020,$00FF0008                ; $00BBB0
        MOVE.L  #$008926D2,$00FF0002            ; $00BBB8
        LEA     $00897000,A0                    ; $00BBC2
        MOVE.W  (-14176).W,D0                   ; $00BBC8
        MOVEA.L $00(A0,D0.W),A0                 ; $00BBCC
        MOVE.W  (-16254).W,D0                   ; $00BBD0
        ASL.W  #4,D0                            ; $00BBD4
        LEA     $00(A0,D0.W),A0                 ; $00BBD6
        CMPI.W  #$0002,(-16256).W               ; $00BBDA
        BEQ.S  .loc_01B6                        ; $00BBE0
        CMPI.B  #$10,$0000(A0)                  ; $00BBE2
        BNE.S  .loc_01BC                        ; $00BBE8
        MOVE.L  #$00894262,$00FF0002            ; $00BBEA
        ADDQ.B  #1,(-330).W                     ; $00BBF4
        CMPI.B  #$04,(-330).W                   ; $00BBF8
        BLE.S  .loc_01B6                        ; $00BBFE
        CLR.B  (-330).W                         ; $00BC00
        ADDQ.B  #1,(-331).W                     ; $00BC04
        CMPI.B  #$02,(-331).W                   ; $00BC08
        BLE.S  .loc_01B6                        ; $00BC0E
        CLR.B  (-331).W                         ; $00BC10
.loc_01B6:
        JMP     $00882890                       ; $00BC14
.loc_01BC:
        RTS                                     ; $00BC1A
