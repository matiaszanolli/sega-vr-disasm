; ============================================================================
; Input Zbus Request 030 (auto-analyzed)
; ROM Range: $0018D8-$001992 (186 bytes)
; ============================================================================
; Category: input
; Purpose: Reads controller input
;   Calls: zbus_request
;
; Uses: D0, D7, A1
; Calls:
;   $00185E: zbus_request
; Confidence: high
; ============================================================================

fn_200_030:
        MOVEQ   #$00,D0                         ; $0018D8
        DC.W    $6100,$00B6         ; BSR.W  $001992; $0018DA
        MOVE.B  D0,(-14320).W                   ; $0018DE
        MOVEQ   #$01,D0                         ; $0018E2
        DC.W    $6100,$00AC         ; BSR.W  $001992; $0018E4
        MOVE.B  D0,(-14319).W                   ; $0018E8
        MOVEQ   #$02,D0                         ; $0018EC
        DC.W    $6100,$00A2         ; BSR.W  $001992; $0018EE
        MOVE.B  D0,(-14318).W                   ; $0018F2
        MOVE.W  #$0100,$00A11100                ; $0018F6
.loc_0026:
        BTST    #0,$00A11100                    ; $0018FE
        BNE.S  .loc_0026                        ; $001906
        MOVEQ   #$40,D0                         ; $001908
        MOVE.B  D0,$00A10009                    ; $00190A
        MOVE.B  D0,$00A1000B                    ; $001910
        MOVE.B  D0,$00A1000D                    ; $001916
        MOVE.W  #$00C0,D0                       ; $00191C
        MOVE.B  D0,$00A10003                    ; $001920
        MOVE.B  D0,$00A10005                    ; $001926
        MOVE.B  D0,$00A10007                    ; $00192C
        MOVE.W  #$0000,$00A11100                ; $001932
        MOVE.W  #$1400,D7                       ; $00193A
.loc_0066:
        DBRA    D7,.loc_0066                    ; $00193E
        MOVE.B  #$00,(-14312).W                 ; $001942
        LEA     $00A10003,A1                    ; $001948
        DC.W    $4EBA,$FF0E         ; JSR     $00185E(PC); $00194E
        BTST    #15,D0                          ; $001952
        BEQ.S  .loc_0086                        ; $001956
        BSET    #0,(-14312).W                   ; $001958
.loc_0086:
        LEA     $00A10005,A1                    ; $00195E
        DC.W    $4EBA,$FEF8         ; JSR     $00185E(PC); $001964
        BTST    #15,D0                          ; $001968
        BEQ.S  .loc_009C                        ; $00196C
        BSET    #1,(-14312).W                   ; $00196E
.loc_009C:
        CMPI.B  #$0D,(-14320).W                 ; $001974
        BEQ.S  .loc_00AA                        ; $00197A
        BSET    #2,(-14312).W                   ; $00197C
.loc_00AA:
        CMPI.B  #$0D,(-14319).W                 ; $001982
        BEQ.S  .loc_00B8                        ; $001988
        BSET    #3,(-14312).W                   ; $00198A
.loc_00B8:
        RTS                                     ; $001990
