; ============================================================================
; Name Entry SH2 COMM Setup + DMA
; ROM Range: $01141A-$01146E (84 bytes)
; ============================================================================
; Category: game
; Purpose: DMA transfer, then sends two SH2 COMM commands.
;   First: waits for COMM0 idle, sends cmd $2C with COMM6=$0101/COMM4=$8000.
;   Second: waits for COMM6 idle, sends COMM4=$0050/COMM6=$0101.
;   Advances game_state, display mode $0020.
;
; Uses: D0
; RAM:
;   $C87E: game_state (word, advanced by 4)
; Calls:
;   $00E52C: dma_transfer (D0=mode)
; ============================================================================

name_entry_sh2_comm_setup_dma:
        clr.w   D0                              ; $01141A  mode = 0
        dc.w    $4EBA,$D10E                     ; $01141C  bsr.w dma_transfer ($00E52C)
.wait_comm0:
        tst.b   COMM0_HI                        ; $011420  COMM0 busy?
        bne.s   .wait_comm0                     ; $011426  yes → wait
        move.w  #$0101,COMM6                    ; $011428  COMM6 = $0101
        move.w  #$8000,COMM4                    ; $011430  COMM4 = $8000
        move.b  #$2C,COMM0_LO                   ; $011438  cmd = $2C
        move.b  #$01,COMM0_HI                   ; $011440  trigger command
.wait_comm6:
        tst.b   COMM6                           ; $011448  COMM6 busy?
        bne.s   .wait_comm6                     ; $01144E  yes → wait
        move.w  #$0050,COMM4                    ; $011450  COMM4 = $0050
        move.w  #$0101,COMM6                    ; $011458  COMM6 = $0101
        move.w  #$0020,$00FF0008                ; $011460  display mode = $0020
        addq.w  #4,($FFFFC87E).w                ; $011468  advance game_state
        rts                                     ; $01146C
