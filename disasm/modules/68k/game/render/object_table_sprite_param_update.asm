; ============================================================================
; object_table_sprite_param_update — Object Table Sprite Parameter Update
; ROM Range: $0036DE-$0037B6 (216 bytes)
; ============================================================================
; Iterates through 15 objects (D7=$0E), reading sprite type from entity
; +$C1 and computing render parameters for the SH2 3D pipeline.
; For each object with non-zero type:
;   1. Checks visibility (ghost mode, flag bit 3 at +$E5)
;   2. Looks up sprite definition from ROM table ($008958E4 + car_index)
;   3. Doubles type ID and adds +$C2 as sub-index
;   4. Stores sprite def pointer to output +$10
;   5. Computes scaled positions: lateral (div8), height with roll (+$6E),
;      depth (div8), and rotation (div8) to output slots
;   6. Copies speed (+$30) and heading (+$34) as-is
;   7. Sets visibility flags D5/D6 (type 1 = both visible)
;
; Entity stride: $100 bytes. Output stride: $3C bytes.
;
; Entry: Fixed addresses A0=$FF9100, A1=$FF6218
; Uses: D0, D5, D6, D7, A0, A1, A3
; ============================================================================

object_table_sprite_param_update:
        LEA     (-28416).W,A0                   ; $0036DE
        LEA     $00FF6218,A1                    ; $0036E2
        LEA     $008958E4,A3                    ; $0036E8
        MOVE.W  (-14132).W,D0                   ; $0036EE
        MOVEA.L $00(A3,D0.W),A3                 ; $0036F2
        MOVEQ   #$0E,D7                         ; $0036F6
.loc_001A:
        MOVEQ   #$00,D5                         ; $0036F8
        MOVEQ   #$00,D6                         ; $0036FA
        MOVEQ   #$00,D0                         ; $0036FC
        MOVE.B  $00C1(A0),D0                    ; $0036FE
        BEQ.W  .loc_00B2                        ; $003702
        MOVEQ   #$01,D5                         ; $003706
        MOVEQ   #$01,D6                         ; $003708
        TST.B  (-28444).W                       ; $00370A
        BNE.S  .loc_0038                        ; $00370E
        TST.B  (-15588).W                       ; $003710
        BEQ.S  .loc_0048                        ; $003714
.loc_0038:
        BTST    #3,$00E5(A0)                    ; $003716
        BEQ.S  .loc_0056                        ; $00371C
.loc_0040:
        MOVEQ   #$00,D5                         ; $00371E
        MOVEQ   #$00,D6                         ; $003720
        BRA.W  .loc_00B2                        ; $003722
.loc_0048:
        BTST    #3,(-28443).W                   ; $003726
        BEQ.S  .loc_0056                        ; $00372C
        TST.B  $00E4(A0)                        ; $00372E
        BNE.S  .loc_0040                        ; $003732
.loc_0056:
        CMPI.W  #$0001,D0                       ; $003734
        BEQ.S  .loc_005E                        ; $003738
        MOVEQ   #$00,D6                         ; $00373A
.loc_005E:
        ADD.W   D0,D0                           ; $00373C
        ADD.W   D0,D0                           ; $00373E
        ADD.W  $00C2(A0),D0                     ; $003740
        MOVE.L  $00(A3,D0.W),$0010(A1)          ; $003744
        MOVE.W  (-16156).W,D0                   ; $00374A
        ADD.W  $0032(A0),D0                     ; $00374E
        MOVE.W  D0,$0004(A1)                    ; $003752
        MOVE.W  $003A(A0),D0                    ; $003756
        ASR.W  #3,D0                            ; $00375A
        NEG.W  D0                               ; $00375C
        MOVE.W  D0,$0008(A1)                    ; $00375E
        MOVE.W  $003C(A0),D0                    ; $003762
        ADD.W  $006E(A0),D0                     ; $003766
        ASR.W  #3,D0                            ; $00376A
        MOVE.W  D0,$000A(A1)                    ; $00376C
        MOVE.W  $003E(A0),D0                    ; $003770
        ASR.W  #3,D0                            ; $003774
        NEG.W  D0                               ; $003776
        MOVE.W  D0,$000C(A1)                    ; $003778
        MOVE.W  $00BC(A0),D0                    ; $00377C
        ASR.W  #3,D0                            ; $003780
        MOVE.W  D0,$001C(A1)                    ; $003782
        MOVE.W  $00C4(A0),D0                    ; $003786
        ASR.W  #3,D0                            ; $00378A
        MOVE.W  D0,$0030(A1)                    ; $00378C
.loc_00B2:
        MOVE.W  $0030(A0),$0002(A1)             ; $003790
        MOVE.W  $0034(A0),$0006(A1)             ; $003796
        MOVE.W  D5,$0000(A1)                    ; $00379C
        MOVE.W  D6,$0014(A1)                    ; $0037A0
        MOVE.W  D6,$0028(A1)                    ; $0037A4
        LEA     $0100(A0),A0                    ; $0037A8
        LEA     $003C(A1),A1                    ; $0037AC
        DBRA    D7,.loc_001A                    ; $0037B0
        RTS                                     ; $0037B4
