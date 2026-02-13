; ============================================================================
; Name Entry Score Display Transfer
; ROM Range: $0111B6-$011240 (138 bytes)
; ============================================================================
; Category: game
; Purpose: Sends 4 SH2 DMA transfers for score display areas, then renders
;   two time digit fields from BCD buffers at $A046 and $A04A.
;   Also transfers two identical UI element blocks.
;   Advances game_state, display mode $0018.
;
; Uses: D0, D1, A0, A1, A2
; RAM:
;   $A046: time digits buffer 1 (long, BCD)
;   $A04A: time digits buffer 2 (long, BCD)
;   $C87E: game_state (word, advanced by 4)
; Calls:
;   $00E35A: sh2_send_cmd (A0=src, A1=dest, D0=size, D1=width)
;   $0118D4: time_digit_render (A1=dest, A2=BCD source)
; ============================================================================

name_entry_score_disp_xfer:
        movea.l #$06018F80,A0                   ; $0111B6  A0 = VRAM source (score area 1)
        movea.l #$0400D018,A1                   ; $0111BC  A1 = display dest 1
        move.w  #$0078,D0                       ; $0111C2  size = $78
        move.w  #$0018,D1                       ; $0111C6  width = $18
        dc.w    $4EBA,$D18E                     ; $0111CA  bsr.w sh2_send_cmd ($00E35A)
        movea.l #$06019AC0,A0                   ; $0111CE  A0 = VRAM source (score area 2)
        movea.l #$0400D0A0,A1                   ; $0111D4  A1 = display dest 2
        move.w  #$0078,D0                       ; $0111DA  size = $78
        move.w  #$0018,D1                       ; $0111DE  width = $18
        dc.w    $4EBA,$D176                     ; $0111E2  bsr.w sh2_send_cmd ($00E35A)
        lea     $0403B048,A1                    ; $0111E6  A1 = time digit dest 1
        lea     ($FFFFA046).w,A2                ; $0111EC  A2 = BCD buffer 1
        dc.w    $4EBA,$06E2                     ; $0111F0  bsr.w time_digit_render ($0118D4)
        lea     $0403B0D0,A1                    ; $0111F4  A1 = time digit dest 2
        lea     ($FFFFA04A).w,A2                ; $0111FA  A2 = BCD buffer 2
        dc.w    $4EBA,$06D4                     ; $0111FE  bsr.w time_digit_render ($0118D4)
        movea.l #$06018C00,A0                   ; $011202  A0 = UI element source
        movea.l #$0401B010,A1                   ; $011208  A1 = UI dest 1
        move.w  #$0038,D0                       ; $01120E  size = $38
        move.w  #$0010,D1                       ; $011212  width = $10
        dc.w    $4EBA,$D142                     ; $011216  bsr.w sh2_send_cmd ($00E35A)
        movea.l #$06018C00,A0                   ; $01121A  A0 = UI element source (same)
        movea.l #$0401B098,A1                   ; $011220  A1 = UI dest 2
        move.w  #$0038,D0                       ; $011226  size = $38
        move.w  #$0010,D1                       ; $01122A  width = $10
        dc.w    $4EBA,$D12A                     ; $01122E  bsr.w sh2_send_cmd ($00E35A)
        addq.w  #4,($FFFFC87E).w                ; $011232  advance game_state
        move.w  #$0018,$00FF0008                ; $011236  display mode = $0018
        rts                                     ; $01123E
