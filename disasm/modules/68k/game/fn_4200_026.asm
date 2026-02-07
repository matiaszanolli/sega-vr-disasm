; ============================================================================
; Logic Poll Controllers 026 (auto-analyzed)
; ROM Range: $0055FE-$005618 (26 bytes)
; ============================================================================
; Category: game
; Purpose: Orchestrator calling 3 subroutines
;   Calls: sfx_queue_process, poll_controllers
;
; Calls:
;   $00179E: poll_controllers
;   $0021CA: sfx_queue_process
; Confidence: low
; ============================================================================

fn_4200_026:
        DC.W    $4EBA,$CBCA         ; JSR     $0021CA(PC); $0055FE
        DC.W    $4EBA,$C19A         ; JSR     $00179E(PC); $005602
        DC.W    $4EBA,$64CC         ; JSR     $00BAD4(PC); $005606
        ADDQ.B  #1,(-14202).W                   ; $00560A
        MOVE.W  #$0054,$00FF0008                ; $00560E
        RTS                                     ; $005616
