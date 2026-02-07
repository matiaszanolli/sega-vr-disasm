; ============================================================================
; Timer Complete with Conditional Flags
; ROM Range: $0046AA-$0046EE (68 bytes)
; ============================================================================
; After 40-frame wait, completes sequence: advances state, selects
; effect based on position flag, sets all transition control flags.
;
; Entry: none
; Uses: none
; ============================================================================

timer_complete_flags:
        dc.w    $0C78,$0028,$C8AA     ; CMPI.W #$0028,($C8AA).W
        bne.s   .done                 ; If not 40, skip
        dc.w    $5878,$C8BE           ; ADDQ.W #4,($C8BE).W
        dc.w    $31FC,$0000,$C8AA     ; MOVE.W #$0000,($C8AA).W
        dc.w    $11FC,$00AB,$C8A5     ; MOVE.B #$AB,($C8A5).W - default effect
        dc.w    $4A38,$C816           ; TST.B ($C816).W - position flag
        beq.s   .set_flags            ; If clear, keep $AB
        dc.w    $11FC,$00AA,$C8A5     ; MOVE.B #$AA,($C8A5).W - alt effect
.set_flags:
        dc.w    $11FC,$0001,$C800     ; MOVE.B #$01,($C800).W
        dc.w    $11FC,$0001,$C809     ; MOVE.B #$01,($C809).W
        dc.w    $11FC,$0001,$C80A     ; MOVE.B #$01,($C80A).W
        dc.w    $08F8,$0007,$C80E     ; BSET #7,($C80E).W
        dc.w    $11FC,$0001,$C802     ; MOVE.B #$01,($C802).W
.done:
        rts
