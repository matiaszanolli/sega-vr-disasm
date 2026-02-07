; ============================================================================
; Obj 010 (auto-analyzed)
; ROM Range: $006BCA-$006C08 (62 bytes)
; ============================================================================
; Category: game
; Purpose: Function in 6200 section (62 bytes)
;
; Uses: D0, D1, D2, D4, A0
; Confidence: low
; ============================================================================

fn_6200_010:
        ORI.B  #$01,D1                          ; $006BCA
        ORI.B  #$02,D2                          ; $006BCE
        ORI.B  #$04,D4                          ; $006BD2
        DC.W    $0008                           ; $006BD6
        DC.W    $0008                           ; $006BD8
        ORI.B  #$10,(A0)                        ; $006BDA
        ORI.B  #$20,-(A0)                       ; $006BDE
        ORI.W  #$0040,D0                        ; $006BE2
        ORI.L  #$00801038,D0                    ; $006BE6
        DC.W    $C30E                           ; $006BEC
        ANDI.B  #$21,D0                         ; $006BEE
        BEQ.S  .loc_003C                        ; $006BF2
        BCLR    #4,(-15602).W                   ; $006BF4
        BTST    #5,D0                           ; $006BFA
        BEQ.S  .loc_003C                        ; $006BFE
        MOVE.W  (-16232).W,(-16262).W           ; $006C00
.loc_003C:
        RTS                                     ; $006C06
