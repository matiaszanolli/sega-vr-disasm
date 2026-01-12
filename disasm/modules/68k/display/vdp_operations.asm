; ============================================================================
; Virtua Racing Deluxe - Display   Vdp_Operations
; Module: 68k/display/vdp_operations.asm
; Address: $0027F8-$002877 (128 bytes)
; ============================================================================
;
; TODO: Add function annotations and documentation
;
; ============================================================================

        org     $0027F8

vdp_operations:
        DC.W    $3E3C,$000F,$303C,$0101,$343C,$0100,$397C,$00FF  ; $0027F8 MOVE.W  #$3E3C,D7 ; MOVE.W  #$303C,D0 ; MOVE.W  #$343C,D2 ; MOVE.W  #$397C,$00FF(A4)
        DC.W    $0084,$3481,$3680,$082C,$0001,$008B,$66F8,$D242  ; $002808 BCLR    #132,D4 ; MOVE.W  D0,(A3) ; BTST    #44,$0001(A4) ; BNE     $0000280E ; ADD.W  D2,D1
        DC.W    $51CF,$FFF0,$4E75,$49F9,$00A1,$5100,$45F9,$00A1  ; $002818 DBRA    D7,$000079E9 ; RTS ; LEA     $49F900A1,A4 ; LEA     $45F900A1,A2
        DC.W    $5186,$47F9,$00A1,$5188,$323C,$1F00,$303C,$0101  ; $002828 DC.W    $5186  ; Unknown ; LEA     $47F900A1,A3 ; MOVE.W  #$323C,D1 ; MOVE.W  #$303C,D0
        DC.W    $397C,$00FF,$0084,$3481,$3680,$082C,$0001,$008B  ; $002838 MOVE.W  #$397C,$00FF(A4) ; MOVE.W  D1,(A2) ; MOVE.W  D0,(A3) ; BTST    #44,$0001(A4)
        DC.W    $66F8,$4E75,$47F9,$00A1,$5200,$7E1F,$26DA,$26DA  ; $002848 BNE     $00002842 ; RTS ; LEA     $47F900A1,A3 ; MOVEQ   #$1F,D7 ; MOVE.L  (A2)+,(A3)+ ; MOVE.L  (A2)+,(A3)+
        DC.W    $26DA,$26DA,$51CF,$FFF6,$4E75,$47F9,$00A1,$5240  ; $002858 MOVE.L  (A2)+,(A3)+ ; MOVE.L  (A2)+,(A3)+ ; DBRA    D7,$00007A2D ; RTS ; LEA     $47F900A1,A3
        DC.W    $7E07,$26DA,$26DA,$26DA,$26DA,$51CF,$FFF6,$4E75  ; $002868 MOVEQ   #$07,D7 ; MOVE.L  (A2)+,(A3)+ ; MOVE.L  (A2)+,(A3)+ ; MOVE.L  (A2)+,(A3)+ ; MOVE.L  (A2)+,(A3)+ ; DBRA    D7,$00007A43 ; RTS

; ============================================================================
; End of Display   Vdp_Operations
; ============================================================================
