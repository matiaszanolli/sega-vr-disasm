; ============================================================================
; Physics Lookup Tables Module
; ROM Range: $00A200-$00A34F (336 bytes)
; ============================================================================
; Contains:
; - physics_lookup_accessor: Index calculation function for table access
; - Acceleration/speed lookup tables
; - Sine/cosine table (64 entries, $00A2D8-$00A347)
; ============================================================================

; ============================================================================
; physics_lookup_accessor
; Entry: D0 = base index, A0 = context pointer
; Uses: D0, D1
; Returns: Writes indexed value to A0+$6
; ============================================================================
physics_lookup_accessor:
        dc.w    $1238,$C30F             ; MOVE.B ($C30F).w,D1 - Read game state byte
        add.b   d1,d0                   ; Add to base index
        asl.w   #5,d0                   ; Multiply by 32 (shift left 5)
        move.w  $8A(a0),d1              ; Read multiplier from context
        add.w   d1,d1                   ; Double it (word offset)
        add.w   d1,d0                   ; Add to index
        dc.w    $317B                   ; MOVE.W opcode (PC-relative indexed)
        dc.w    $0006                   ; Destination: $6(a0)
        dc.w    $000A                   ; Source: PC-relative offset to lookup_table_base
        dc.w    $4E75                   ; RTS

; ============================================================================
; Acceleration/Speed Lookup Tables
; $00A218-$00A2D7 (192 bytes = 96 words)
; ============================================================================
lookup_table_base:
        dc.w    $048F,$048B,$048B,$0481,$0481,$0468,$0456,$03D0
        dc.w    $03D0,$03D0,$03D0,$03CF,$03CF,$035A,$035A,$035A
        dc.w    $0496,$0495,$0495,$0495,$048F,$0481,$0477,$046B
        dc.w    $0459,$03E9,$03E0,$03E0,$03DF,$03DF,$03DF,$03DF
        dc.w    $03FC,$03EB,$03EA,$03EA,$03EA,$03EA,$03EA,$03EA
        dc.w    $03EA,$03E4,$03E4,$03E4,$03E4,$03E1,$03D9,$03D9
        dc.w    $040B,$0408,$0404,$03FC,$03FC,$03FC,$03FC,$03F4
        dc.w    $03F4,$03F3,$03F3,$03F3,$03F3,$03F2,$03EB,$03EA
        dc.w    $054C,$053D,$0528,$043C,$043C,$043C,$043C,$043C
        dc.w    $042B,$042A,$0429,$0429,$0429,$0429,$0429,$03A8
        dc.w    $0563,$054B,$054B,$0536,$052B,$050B,$04DD,$04D2
        dc.w    $04CF,$04C7,$04BC,$0498,$0498,$0416,$0416,$0410

; ============================================================================
; Sine/Cosine Table (64 entries, fixed-point format)
; $00A2D8-$00A347 (112 bytes = 56 words)
; Values appear to be 16-bit fixed-point sine wave (0-360° in 64 steps)
; ============================================================================
sine_table:
        dc.w    $0200,$0F74,$1EDB,$2E25,$3D43,$4C29,$5AC7,$6910
        dc.w    $76F8,$8470,$916C,$9DE1,$A9C2,$B504,$BF9E,$C984
        dc.w    $D2AF,$DB14,$E2AD,$E972,$EF5D,$F468,$F88F,$FBCE
        dc.w    $FE22,$FF88,$0060,$0040,$0020,$0000,$FF88,$FE22
        dc.w    $FBCE,$F88F,$F468,$EF5D,$E972,$E2AD,$DB14,$D2AF
        dc.w    $C984,$BF9E,$B504,$A9C2,$9DE1,$916C,$8470,$76F8
        dc.w    $6910,$5AC7,$4C29,$3D43,$2E25,$1EDB,$0F74,$0200

; ============================================================================
; Small Lookup Table (4 entries)
; $00A348-$00A34F (8 bytes = 4 words)
; ============================================================================
small_table:
        dc.w    $FFA0,$FFC0,$FFE0,$0000
