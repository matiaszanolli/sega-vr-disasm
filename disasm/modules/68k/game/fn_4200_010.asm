; ============================================================================
; Logic Pre Dispatch Common 010 (auto-analyzed)
; ROM Range: $004C8A-$004CB8 (46 bytes)
; ============================================================================
; Category: game
; Purpose: Calls: pre_dispatch_common, WaitForVBlank
;
; Calls:
;   $002080: pre_dispatch_common
;   $004998: WaitForVBlank
; Confidence: low
; ============================================================================

fn_4200_010:
        MOVE.B  #$9A,(-14171).W                 ; $004C8A
        DC.W    $4EBA,$D3EE         ; JSR     $002080(PC); $004C90
        DC.W    $4EBA,$FD02         ; JSR     $004998(PC); $004C94
        MOVE.L  #$00885618,$00FF0002            ; $004C98
        MOVE.L  #$00000000,$00FF5FF8            ; $004CA2
        MOVE.L  #$00000000,$00FF5FFC            ; $004CAC
        RTS                                     ; $004CB6
