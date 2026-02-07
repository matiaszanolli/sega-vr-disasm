; ============================================================================
; Init 034 (auto-analyzed)
; ROM Range: $001ACA-$001B14 (74 bytes)
; ============================================================================
; Category: boot
; Purpose: Function in 200 section (74 bytes)
;
; Uses: D0, D4, A5
; Confidence: low
; ============================================================================

fn_200_034:
        MOVE.W  (A5),D0                         ; $001ACA
        MOVE.W  #$0100,$00A11100                ; $001ACC
.loc_000A:
        BTST    #0,$00A11100                    ; $001AD4
        BNE.S  .loc_000A                        ; $001ADC
        MOVE.W  (-14220).W,D4                   ; $001ADE
        BSET    #4,D4                           ; $001AE2
        MOVE.W  D4,(A5)                         ; $001AE6
        MOVE.L  #$93809401,(A5)                 ; $001AE8
        MOVE.L  #$951E96C0,(A5)                 ; $001AEE
        MOVE.W  #$977F,(A5)                     ; $001AF4
        MOVE.W  #$6C3C,(A5)                     ; $001AF8
        MOVE.W  #$0083,(-14218).W               ; $001AFC
        MOVE.W  (-14218).W,(A5)                 ; $001B02
        MOVE.W  (-14220).W,(A5)                 ; $001B06
        MOVE.W  #$0000,$00A11100                ; $001B0A
        RTS                                     ; $001B12
