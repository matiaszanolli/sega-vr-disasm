; ============================================================================
; sound_buffer_copy_with_offset — Sound Buffer Copy with Offset
; ROM Range: $00B422-$00B43C (26 bytes)
; Variant of sound_buffer_copy_with_decode with D3-based offset into decode buffer $FF68D8.
; Scales D3 by 4 to select entry, calls shared decoder at $00B43C, copies
; 8 bytes to sound output at $FF6958.
;
; Entry: D3 = buffer entry index
; Uses: D3, A1, A3
; Confidence: high
; ============================================================================

sound_buffer_copy_with_offset:
        LSL.W  #2,D3                            ; $00B422
        LEA     $00FF68D8,A3                    ; $00B424
        LEA     $00(A3,D3.W),A3                 ; $00B42A
        DC.W    $610C               ; BSR.S  $00B43C; $00B42E
        LEA     $00FF6958,A1                    ; $00B430
        MOVE.L  (A3)+,(A1)+                     ; $00B436
        MOVE.L  (A3),(A1)                       ; $00B438
        RTS                                     ; $00B43A
