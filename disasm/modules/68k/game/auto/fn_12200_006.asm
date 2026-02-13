; ============================================================================
; fn_12200_006 — VDP Tile Fill with Data Table
; ROM Range: $012F9C-$012FE4 (72 bytes)
; ============================================================================
; Data prefix ($012F9C-$012FBF) contains structured VDP parameters: repeated
; $0401 entries with field offsets (+$38, +$39) defining tile fill regions.
;
; Code section ($012FC0-$012FE3) fills VDP VRAM with a repeated tile value.
; For each region: sets VDP address register via A5, then writes D3 to VDP
; data port (A6) for D1+1 words. Advances base address D0 by D4 per region,
; looping D2+1 times.
;
; Entry: D0 = VDP base address, D1 = words per row, D2 = row count,
;        D3 = fill value, D4 = row stride, A5 = VDP control, A6 = VDP data
; Uses: D0, D1, D2, D3, D4, D5, D6
; ============================================================================

fn_12200_006:
        DC.W    $0401                           ; $012F9C
        NEGX.B (A4)                             ; $012F9E
        DC.W    $0039                           ; $012FA0
        DC.W    $0401                           ; $012FA2
        DC.W    $404C                           ; $012FA4
        DC.W    $0038                           ; $012FA6
        DC.W    $0401                           ; $012FA8
        NEGX.L D3                               ; $012FAA
        DC.W    $0039                           ; $012FAC
        DC.W    $0401                           ; $012FAE
        DC.W    $40BB                           ; $012FB0
        DC.W    $0039                           ; $012FB2
        DC.W    $0401                           ; $012FB4
        MOVE    SR,$39(A3,D0.W)                 ; $012FB6
        DC.W    $0401                           ; $012FBA
        MOVE    SR,$39(A3,D0.W)                 ; $012FBC
        MOVE.W  #$0100,D4                       ; $012FC0
.loc_0028:
        MOVE.W  D0,D6                           ; $012FC4
        BCLR    #15,D6                          ; $012FC6
        BSET    #14,D6                          ; $012FCA
        MOVE.W  D6,(A5)                         ; $012FCE
        MOVE.W  #$0003,(A5)                     ; $012FD0
        MOVE.W  D1,D5                           ; $012FD4
.loc_003A:
        MOVE.W  D3,(A6)                         ; $012FD6
        DBRA    D5,.loc_003A                    ; $012FD8
        ADD.L   D4,D0                           ; $012FDC
        DBRA    D2,.loc_0028                    ; $012FDE
        RTS                                     ; $012FE2
