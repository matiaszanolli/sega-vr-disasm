; ============================================================================
; Vint Heading 067 (auto-analyzed)
; ROM Range: $003D22-$003D5A (56 bytes)
; ============================================================================
; Category: game
; Purpose: Object (A1): +$00, +$14 (effect_duration), +$28, +$3C (heading_mirror)
;
; Entry: A1 = object/entity pointer
; Uses: D0, D1, A1
; Object fields:
;   +$00: [unknown]
;   +$14: effect_duration
;   +$28: [unknown]
;   +$3C: heading_mirror
; Confidence: low
; ============================================================================

fn_2200_067:
        CMPI.W  #$0004,D1                       ; $003D22
        BNE.S  .loc_000C                        ; $003D26
        MOVE.B  #$BA,(-14172).W                 ; $003D28
.loc_000C:
        CMPI.W  #$0016,D1                       ; $003D2E
        BNE.S  .loc_0018                        ; $003D32
        MOVE.B  #$BA,(-14172).W                 ; $003D34
.loc_0018:
        MOVEQ   #$01,D0                         ; $003D3A
        LEA     $00FF6128,A1                    ; $003D3C
        MOVE.W  D0,$0000(A1)                    ; $003D42
        MOVE.W  D0,$0014(A1)                    ; $003D46
        TST.W  (-16308).W                       ; $003D4A
        BNE.S  .loc_0036                        ; $003D4E
        MOVE.W  D0,$0028(A1)                    ; $003D50
        MOVE.W  D0,$003C(A1)                    ; $003D54
.loc_0036:
        RTS                                     ; $003D58
