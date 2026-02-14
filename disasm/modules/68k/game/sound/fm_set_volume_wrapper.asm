; ============================================================================
; FM Set Volume Wrapper — call fm_set_volume and skip caller
; ROM Range: $03023A-$030242 (8 bytes)
; ============================================================================
; Calls fm_set_volume subroutine, then pops return address from stack
; (ADDQ.W #4,A7), causing the caller's remaining code to be skipped.
; This is a tail-call optimization pattern used by the sound driver.
;
; Calls:
;   $030FB2: fm_set_volume
; Confidence: medium
; ============================================================================

fm_set_volume_wrapper:
        jsr     psg_set_pos_silence+16(pc); $4EBA $0D76
        ADDQ.W  #4,A7                           ; $03023E
        RTS                                     ; $030240
