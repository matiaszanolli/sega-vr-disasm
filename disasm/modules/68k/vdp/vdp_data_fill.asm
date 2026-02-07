; ============================================================================
; VDP Data Fill
; ROM Range: $0010C4-$0010DA (24 bytes)
; ============================================================================
; 2D block transfer from RAM to VDP data port.
; Writes words from (A0)+ to VDP port (A6) in a nested loop,
; advancing the VDP address by $01000000 per outer iteration.
;
; Entry: A0 = source data, A5 = VDP control port, A6 = VDP data port
;        D0 = VDP address command, D1 = inner count, D2 = outer count
; Uses: D0, D1, D3, D4, A0
; ============================================================================

vdp_data_fill:
        move.l  #$01000000,d4           ; Row increment
.outer:
        move.l  d0,(a5)                 ; Set VDP address via control port
        move.w  d1,d3                   ; Copy inner loop count
.inner:
        move.w  (a0)+,(a6)              ; Write word to VDP data port
        dbra    d3,.inner               ; Inner loop
        add.l   d4,d0                   ; Advance to next row
        dbra    d2,.outer               ; Outer loop
        rts
