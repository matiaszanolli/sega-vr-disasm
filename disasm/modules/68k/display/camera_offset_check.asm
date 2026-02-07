; ============================================================================
; Camera Offset Check (2-Player)
; ROM Range: $003116-$003124 (16 bytes)
; ============================================================================
; In 2-player mode, adds $40 vertical offset to camera position.
;
; Entry: none
; Uses: none (only modifies memory)
; ============================================================================

camera_offset_check:
        dc.w    $0838,$0005,$C30E     ; BTST #5,($C30E).W - 2P mode flag
        beq.s   .done                 ; If not 2P, skip
        dc.w    $0678,$0040,$C0B0     ; ADDI.W #$0040,($C0B0).W - camera Y
.done:
        rts
