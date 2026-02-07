; ============================================================================
; VDP Data Fill Constant
; ROM Range: $0010DC-$0010F2 (24 bytes)
; ============================================================================
; Fills VDP region with a constant word value D3.
; Same structure as vdp_data_fill but writes D3 instead of (A0)+.
;
; Entry: A5 = VDP control port, A6 = VDP data port
;        D0 = VDP address command, D1 = inner count, D2 = outer count
;        D3 = constant value to fill
; Uses: D0, D1, D4, D5
; ============================================================================

vdp_data_fill_constant:
        move.l  #$01000000,d4           ; Row increment
.outer:
        move.l  d0,(a5)                 ; Set VDP address
        move.w  d1,d5                   ; Copy inner loop count
.inner:
        move.w  d3,(a6)                 ; Write constant to VDP data port
        dbra    d5,.inner               ; Inner loop
        add.l   d4,d0                   ; Advance row
        dbra    d2,.outer               ; Outer loop
        rts
