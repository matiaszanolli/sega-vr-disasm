; ============================================================================
; Block Copy 1KB with SH2 Check
; ROM Range: $0046EE-$00471E (48 bytes)
; ============================================================================
; Copies 1024 bytes from $B400 to $A400 using MOVEM block copy.
; Only executes if SH2 is not busy. Queues sound $F3 on completion.
;
; Entry: none
; Uses: D0-D6, A1-A3, D7
; ============================================================================

block_copy_with_check:
        dc.w    $31FC,$0001,$C048     ; MOVE.W #$0001,($C048).W
        dc.w    $0838,$0007,$C80E     ; BTST #7,($C80E).W
        bne.s   .done                 ; If SH2 busy, skip
        dc.w    $43F8,$B400           ; LEA ($B400).W,A1 - source palette
        dc.w    $45F8,$A400           ; LEA ($A400).W,A2 - dest palette
        moveq   #$1F,d7              ; Loop 32 times
.copy:
        movem.l (a1)+,d0-d6/a3       ; Read 32 bytes
        movem.l d0-d6/a3,-(a2)       ; Write 32 bytes (predecrement)
        dbra    d7,.copy              ; 32*32=1024 bytes
        dc.w    $11FC,$00F3,$C822     ; MOVE.B #$F3,($C822).W - queue sound
        dc.w    $5878,$C8BE           ; ADDQ.W #4,($C8BE).W
.done:
        rts
