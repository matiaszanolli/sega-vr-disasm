; ============================================================================
; entity_heading_init — Entity Heading Initialization
; ROM Range: $007AB2-$007AD6 (36 bytes)
; Initializes entity heading angles. Has data prefix (4 bytes), then checks
; render flag bit 7 (+$C0); if clear, calls heading calculation at $007BAC,
; copies heading value (+$32) to both +$C6 and +$C8 (prev/current heading),
; and increments global object counter at $FF5FFE.
;
; Entry: A0 = entity base pointer
; Uses: D0, D1, A0
; Object fields: +$32 heading, +$C0 render_flags, +$C6 prev_heading,
;   +$C8 current_heading
; Confidence: high
; ============================================================================

entity_heading_init:
        DIVU    #$0000,D0                       ; $007AB2
        BTST    #7,$00C0(A0)                    ; $007AB6
        DC.W    $6618               ; BNE.S  $007AD6; $007ABC
        DC.W    $4EBA,$00EC         ; JSR     $007BAC(PC); $007ABE
        MOVE.W  $0032(A0),D1                    ; $007AC2
        MOVE.W  D1,$00C6(A0)                    ; $007AC6
        MOVE.W  D1,$00C8(A0)                    ; $007ACA
        ADDQ.B  #1,$00FF5FFE                    ; $007ACE
        RTS                                     ; $007AD4
