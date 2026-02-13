; ============================================================================
; Fm Set Volume 002 (auto-analyzed)
; ROM Range: $03023A-$030242 (8 bytes)
; ============================================================================
; Category: sound
; Purpose: Small leaf function
;   Calls: fm_set_volume
;
; Calls:
;   $030FB2: fm_set_volume
; Confidence: medium
; ============================================================================

fn_30200_002:
        DC.W    $4EBA,$0D76         ; JSR     $030FB2(PC); $03023A
        ADDQ.W  #4,A7                           ; $03023E
        RTS                                     ; $030240
