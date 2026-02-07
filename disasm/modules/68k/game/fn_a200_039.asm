; ============================================================================
; Ai 039 (auto-analyzed)
; ROM Range: $00BDD6-$00BDFE (40 bytes)
; ============================================================================
; Category: game
; Purpose: Short helper function
;   Object (A1): +$00, +$10
;
; Entry: A1 = object/entity pointer
; Uses: D1, A1
; Object fields:
;   +$00: [unknown]
;   +$10: [unknown]
; Confidence: low
; ============================================================================

fn_a200_039:
        MOVE.W  (-24336).W,D1                   ; $00BDD6
        BEQ.S  .loc_0026                        ; $00BDDA
        LEA     $00FF6860,A1                    ; $00BDDC
        MOVE.B  #$0B,$0000(A1)                  ; $00BDE2
        MOVE.B  #$0C,$0010(A1)                  ; $00BDE8
        CMPI.W  #$000C,D1                       ; $00BDEE
        DC.W    $6D0A               ; BLT.S  $00BDFE; $00BDF2
        MOVE.W  #$FFFF,$00FF60C8                ; $00BDF4
.loc_0026:
        RTS                                     ; $00BDFC
