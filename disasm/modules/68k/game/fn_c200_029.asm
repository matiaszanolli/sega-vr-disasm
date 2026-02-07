; ============================================================================
; Sh2 Comm Object Update 029 (auto-analyzed)
; ROM Range: $00DE98-$00DFEC (340 bytes)
; ============================================================================
; Category: sh2
; Purpose: Orchestrator calling 5 subroutines
;   Accesses 32X registers: COMM0
;   RAM: $C87E (game_state)
;   Calls: dma_transfer, object_update, sprite_update, sh2_send_cmd
;   Object (A5): +$3B
;
; Entry: A5 = object/entity pointer
; Uses: D0, D1, D2, D3, A0, A1, A2, A5
; RAM:
;   $C87E: game_state
; Calls:
;   $00B684: object_update
;   $00B6DA: sprite_update
;   $00E35A: sh2_send_cmd
;   $00E52C: dma_transfer
; Object fields:
;   +$3B: [unknown]
; Confidence: high
; ============================================================================

fn_c200_029:
        MOVE.L  D1,D2                           ; $00DE98
        OR.B   (A0),D0                          ; $00DE9A
        DC.W    $003A                           ; $00DE9C
        MOVE.L  D1,D2                           ; $00DE9E
        DC.W    $8049                           ; $00DEA0
        DC.W    $003B                           ; $00DEA2
        MOVE.L  D1,D2                           ; $00DEA4
        DC.W    $8083                           ; $00DEA6
        DC.W    $003A                           ; $00DEA8
        MOVE.L  D1,D2                           ; $00DEAA
        OR.L   #$003A2401,D0                    ; $00DEAC
        DIVU    $3B(A5,D0.W),D0                 ; $00DEB2
        MOVE.L  D3,D2                           ; $00DEB6
        OR.B   (A2),D2                          ; $00DEB8
        MOVE.L  D3,D2                           ; $00DEBA
        DC.W    $844C                           ; $00DEBC
        MOVE.L  D3,D2                           ; $00DEBE
        DC.W    $8486                           ; $00DEC0
        MOVE.L  D3,D2                           ; $00DEC2
        DC.W    $84BE                           ; $00DEC4
        MOVE.L  D3,D2                           ; $00DEC6
        DIVU    (-13108).W,D2                   ; $00DEC8
        DC.W    $0CCC                           ; $00DECC
        CLR.W  D0                               ; $00DECE
        MOVE.B  (-24537).W,D0                   ; $00DED0
        DC.W    $4EBA,$0656         ; JSR     $00E52C(PC); $00DED4
        DC.W    $4EBA,$D7AA         ; JSR     $00B684(PC); $00DED8
        DC.W    $4EBA,$D7FC         ; JSR     $00B6DA(PC); $00DEDC
.loc_0048:
        TST.B  $00A15120                        ; $00DEE0
        BNE.S  .loc_0048                        ; $00DEE6
        MOVEA.L #$06037000,A0                   ; $00DEE8
        MOVEA.L #$24014010,A1                   ; $00DEEE
        MOVE.W  #$0120,D0                       ; $00DEF4
        MOVE.W  #$0030,D1                       ; $00DEF8
        DC.W    $6100,$045C         ; BSR.W  $00E35A; $00DEFC
        MOVEA.L #$0603B600,A0                   ; $00DF00
        MOVEA.L #$2401C010,A1                   ; $00DF06
        MOVE.W  #$0120,D0                       ; $00DF0C
        MOVE.W  #$0010,D1                       ; $00DF10
        DC.W    $6100,$0444         ; BSR.W  $00E35A; $00DF14
.loc_0080:
        TST.B  $00A15120                        ; $00DF18
        BNE.S  .loc_0080                        ; $00DF1E
        DC.W    $6100,$01F6         ; BSR.W  $00E118; $00DF20
        MOVEA.L #$0603DA00,A0                   ; $00DF24
        MOVEA.L #$2401AC88,A1                   ; $00DF2A
        MOVE.W  #$0038,D0                       ; $00DF30
        MOVE.W  #$0010,D1                       ; $00DF34
        DC.W    $6100,$0420         ; BSR.W  $00E35A; $00DF38
        MOVE.W  #$0018,$00FF0008                ; $00DF3C
        CMPI.W  #$0001,(-24532).W               ; $00DF44
        BEQ.W  .loc_0124                        ; $00DF4A
        CMPI.W  #$0002,(-24532).W               ; $00DF4E
        BEQ.W  .loc_0134                        ; $00DF54
        MOVE.W  (-14228).W,D1                   ; $00DF58
        ANDI.B  #$E0,D1                         ; $00DF5C
        BNE.S  .loc_00FC                        ; $00DF60
        CMPI.B  #$02,(-24540).W                 ; $00DF62
        BNE.W  .loc_00E6                        ; $00DF68
        MOVE.W  (-14226).W,D1                   ; $00DF6C
        MOVE.W  D1,D2                           ; $00DF70
        ANDI.B  #$E0,D2                         ; $00DF72
        BNE.S  .loc_00FC                        ; $00DF76
        ANDI.B  #$10,D1                         ; $00DF78
        BNE.S  .loc_00F8                        ; $00DF7C
.loc_00E6:
        MOVE.W  (-14228).W,D1                   ; $00DF7E
        ANDI.B  #$10,D1                         ; $00DF82
        BNE.S  .loc_00F8                        ; $00DF86
        SUBQ.W  #8,(-14210).W                   ; $00DF88
        BRA.W  .loc_014C                        ; $00DF8C
.loc_00F8:
        ST      (-24552).W                      ; $00DF90
.loc_00FC:
        MOVE.B  #$A8,(-14172).W                 ; $00DF94
        MOVE.B  #$01,(-14327).W                 ; $00DF9A
        MOVE.B  #$01,(-14326).W                 ; $00DFA0
        BSET    #7,(-14322).W                   ; $00DFA6
        MOVE.B  #$01,(-14334).W                 ; $00DFAC
        MOVE.W  #$0002,(-24532).W               ; $00DFB2
        BRA.W  .loc_0148                        ; $00DFB8
.loc_0124:
        BTST    #6,(-14322).W                   ; $00DFBC
        BNE.S  .loc_0148                        ; $00DFC2
        CLR.W  (-24532).W                       ; $00DFC4
        BRA.W  .loc_0148                        ; $00DFC8
.loc_0134:
        BTST    #7,(-14322).W                   ; $00DFCC
        BNE.S  .loc_0148                        ; $00DFD2
        CLR.W  (-24532).W                       ; $00DFD4
        ADDQ.W  #4,(-14210).W                   ; $00DFD8
        BRA.W  .loc_014C                        ; $00DFDC
.loc_0148:
        SUBQ.W  #8,(-14210).W                   ; $00DFE0
.loc_014C:
        MOVE.B  #$01,(-14303).W                 ; $00DFE4
        RTS                                     ; $00DFEA
