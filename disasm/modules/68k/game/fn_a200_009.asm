; ============================================================================
; Ai 009 (auto-analyzed)
; ROM Range: $00B2D8-$00B2FC (36 bytes)
; ============================================================================
; Category: game
; Purpose: Short helper function
;   Object (A0, A1): +$00, +$2C
;
; Entry: A0 = object/entity pointer
; Entry: A1 = object/entity pointer
; Uses: D0, D3, A0, A1
; Object fields:
;   +$00: [unknown]
;   +$2C: [unknown]
; Confidence: low
; ============================================================================

fn_a200_009:
        ORI.L  #$01100080,-(A0)                 ; $00B2D8
        ORI.L  #$00D00100,D0                    ; $00B2DE
        MOVE.W  $002C(A0),D3                    ; $00B2E4
        SUBQ.W  #1,D3                           ; $00B2E8
        LSL.W  #2,D3                            ; $00B2EA
        LEA     (-15872).W,A1                   ; $00B2EC
        LEA     $00(A1,D3.W),A1                 ; $00B2F0
        CMPI.B  #$60,(A1)                       ; $00B2F4
        DC.W    $6D02               ; BLT.S  $00B2FC; $00B2F8
        RTS                                     ; $00B2FA
