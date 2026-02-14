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
        btst    #5,($FFFFC30E).w        ; $0838 $0005 $C30E — 2P mode flag
        beq.s   .done                 ; If not 2P, skip
        addi.w  #$0040,($FFFFC0B0).w    ; $0678 $0040 $C0B0 — camera Y
.done:
        rts
