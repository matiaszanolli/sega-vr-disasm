; ============================================================================
; Obj Dispatch 032 (auto-analyzed)
; ROM Range: $005780-$0057CA (74 bytes)
; ============================================================================
; Category: object
; Purpose: State dispatcher using jump table
;   Calls: poll_controllers, sprite_update
;
; Uses: D0, D2, A0, A1, A2, A6
; Calls:
;   $00179E: poll_controllers
;   $00B6DA: sprite_update
; Confidence: medium
; ============================================================================

fn_4200_032:
        DC.W    $4EBA,$C01C         ; JSR     $00179E(PC); $005780
        ADDQ.B  #4,(-14140).W                   ; $005784
        MOVE.W  #$0044,$00FF0008                ; $005788
        MOVEQ   #$00,D0                         ; $005790
        MOVE.B  (-14139).W,D0                   ; $005792
        MOVEA.L $0057A4(PC,D0.W),A1             ; $005796
        JSR     (A1)                            ; $00579A
        DC.W    $4EBA,$5F3C         ; JSR     $00B6DA(PC); $00579C
        DC.W    $4EFA,$5EE2         ; JMP     $00B684(PC); $0057A0
        DC.W    $0088                           ; $0057A4
        DC.W    $57CA,$0088         ; DBEQ    D2,$005830; $0057A6
        SEQ     (A0)                            ; $0057AA
        DC.W    $0088                           ; $0057AC
        SEQ     (A0)+                           ; $0057AE
        DC.W    $0088                           ; $0057B0
        ADDQ.W  #4,A2                           ; $0057B2
        DC.W    $0088                           ; $0057B4
        ADDQ.W  #4,-(A6)                        ; $0057B6
        DC.W    $0088                           ; $0057B8
        DC.W    $58B4                           ; $0057BA
        ADDQ.B  #1,(-14202).W                   ; $0057BC
        MOVE.W  #$0044,$00FF0008                ; $0057C0
        RTS                                     ; $0057C8
