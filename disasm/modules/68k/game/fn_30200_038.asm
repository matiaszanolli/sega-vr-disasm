; ============================================================================
; Vdp 038 (auto-analyzed)
; ROM Range: $030FC8-$030FE0 (24 bytes)
; ============================================================================
; Category: vdp
; Purpose: Short helper function
;   Accesses VDP registers
;
; Uses: A0
; Confidence: medium
; ============================================================================

fn_30200_038:
        LEA     $00C00011,A0                    ; $030FC8
        MOVE.B  #$9F,(A0)                       ; $030FCE
        MOVE.B  #$BF,(A0)                       ; $030FD2
        MOVE.B  #$DF,(A0)                       ; $030FD6
        MOVE.B  #$FF,(A0)                       ; $030FDA
        RTS                                     ; $030FDE
