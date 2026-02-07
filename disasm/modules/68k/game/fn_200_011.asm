; ============================================================================
; Io Port Init 011 (auto-analyzed)
; ROM Range: $000FEA-$001034 (74 bytes)
; ============================================================================
; Category: boot
; Purpose: Calls: io_port_init
;   Object (A0): +$01
;
; Entry: A0 = object/entity pointer
; Uses: D0, D7, A0, A5
; Calls:
;   $0018D8: io_port_init
; Object fields:
;   +$01: [unknown]
; Confidence: low
; ============================================================================

fn_200_011:
        MOVE    SR,-(A7)                        ; $000FEA
        MOVE    #$2700,SR                       ; $000FEC
        MOVE.W  #$0100,$00A11100                ; $000FF0
.loc_000E:
        BTST    #0,$00A11100                    ; $000FF8
        BNE.S  .loc_000E                        ; $001000
        DC.W    $4EBA,$08D4         ; JSR     $0018D8(PC); $001002
        MOVE.W  #$0000,$00A11100                ; $001006
        MOVE    (A7)+,SR                        ; $00100E
        DC.W    $41FA,$0022         ; LEA     $001034(PC),A0; $001010
        MOVE.B  #$81,(-14220).W                 ; $001014
        MOVE.B  $0001(A0),(-14219).W            ; $00101A
        MOVE.W  #$8000,D0                       ; $001020
        MOVEQ   #$12,D7                         ; $001024
.loc_003C:
        MOVE.B  (A0)+,D0                        ; $001026
        MOVE.W  D0,(A5)                         ; $001028
        ADDI.W  #$0100,D0                       ; $00102A
        DBRA    D7,.loc_003C                    ; $00102E
        RTS                                     ; $001032
