; ============================================================================
; HUD Element Initialization — configure 3 HUD display slots
; ROM Range: $003D5A-$003D9A (64 bytes)
; ============================================================================
; Initializes 3 HUD element slots with type $09 and ROM data pointers:
;   Slot 1 ($FF6980): type=$09, data=$040268F8, aux=$222F0FBE
;   Slot 2 ($FF69C0): type=$09 (data inherited/zero)
;   Slot 3 ($FF6990): type=$09, data=$0402C8EC, aux=$222F22A2
; Each slot is a 64-byte structure with type at +$00, data pointer at +$04,
; auxiliary pointer at +$08.
;
; Uses: A1
; Confidence: medium
; ============================================================================

hud_element_init:
        LEA     $00FF6980,A1                    ; $003D5A
        MOVE.B  #$09,(A1)                       ; $003D60
        MOVE.L  #$040268F8,$0004(A1)            ; $003D64
        MOVE.L  #$222F0FBE,$0008(A1)            ; $003D6C
        LEA     $00FF69C0,A1                    ; $003D74
        MOVE.B  #$09,(A1)                       ; $003D7A
        LEA     $00FF6990,A1                    ; $003D7E
        MOVE.B  #$09,(A1)                       ; $003D84
        MOVE.L  #$0402C8EC,$0004(A1)            ; $003D88
        MOVE.L  #$222F22A2,$0008(A1)            ; $003D90
        RTS                                     ; $003D98
