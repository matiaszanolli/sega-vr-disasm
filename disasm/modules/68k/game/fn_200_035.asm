; ============================================================================
; Init 035 (auto-analyzed)
; ROM Range: $001B14-$001C66 (338 bytes)
; ============================================================================
; Category: boot
; Purpose: Function in 200 section (338 bytes)
;
; Uses: D0, D4, A5, A6
; Confidence: low
; ============================================================================

fn_200_035:
        MOVE.W  (A5),D0                         ; $001B14
        MOVE.L  #$6C000003,(A5)                 ; $001B16
        MOVE.W  (-32768).W,(A6)                 ; $001B1C
        MOVE.W  (-32766).W,(A6)                 ; $001B20
        MOVE.L  #$40000010,(A5)                 ; $001B24
        MOVE.W  (-14208).W,(A6)                 ; $001B2A
        MOVE.W  (-14206).W,(A6)                 ; $001B2E
        MOVE.W  #$0100,$00A11100                ; $001B32
.loc_0026:
        BTST    #0,$00A11100                    ; $001B3A
        BNE.S  .loc_0026                        ; $001B42
        MOVE.W  (-14220).W,D4                   ; $001B44
        BSET    #4,D4                           ; $001B48
        MOVE.W  D4,(A5)                         ; $001B4C
        MOVE.L  #$93809403,(A5)                 ; $001B4E
        MOVE.L  #$95009688,(A5)                 ; $001B54
        MOVE.W  #$977F,(A5)                     ; $001B5A
        MOVE.W  #$6000,(A5)                     ; $001B5E
        MOVE.W  #$0082,(-14218).W               ; $001B62
        MOVE.W  (-14218).W,(A5)                 ; $001B68
        MOVE.W  (-14220).W,(A5)                 ; $001B6C
        MOVE.W  (-14220).W,D4                   ; $001B70
        BSET    #4,D4                           ; $001B74
        MOVE.W  D4,(A5)                         ; $001B78
        MOVE.L  #$93409400,(A5)                 ; $001B7A
        MOVE.L  #$954096C2,(A5)                 ; $001B80
        MOVE.W  #$977F,(A5)                     ; $001B86
        MOVE.W  #$C000,(A5)                     ; $001B8A
        MOVE.W  #$0080,(-14218).W               ; $001B8E
        MOVE.W  (-14218).W,(A5)                 ; $001B94
        MOVE.W  (-14220).W,(A5)                 ; $001B98
        MOVE.W  #$0000,$00A11100                ; $001B9C
        DC.W    $4EFA,$FBF8         ; JMP     $00179E(PC); $001BA4
        MOVE.W  (A5),D0                         ; $001BA8
        MOVE.W  #$0100,$00A11100                ; $001BAA
.loc_009E:
        BTST    #0,$00A11100                    ; $001BB2
        BNE.S  .loc_009E                        ; $001BBA
        MOVE.W  (-14220).W,D4                   ; $001BBC
        BSET    #4,D4                           ; $001BC0
        MOVE.W  D4,(A5)                         ; $001BC4
        MOVE.L  #$93809403,(A5)                 ; $001BC6
        MOVE.L  #$95009688,(A5)                 ; $001BCC
        MOVE.W  #$977F,(A5)                     ; $001BD2
        MOVE.W  #$6000,(A5)                     ; $001BD6
        MOVE.W  #$0082,(-14218).W               ; $001BDA
        MOVE.W  (-14218).W,(A5)                 ; $001BE0
        MOVE.W  (-14220).W,(A5)                 ; $001BE4
        MOVE.W  (-14220).W,D4                   ; $001BE8
        BSET    #4,D4                           ; $001BEC
        MOVE.W  D4,(A5)                         ; $001BF0
        MOVE.L  #$93809403,(A5)                 ; $001BF2
        MOVE.L  #$9580968B,(A5)                 ; $001BF8
        MOVE.W  #$977F,(A5)                     ; $001BFE
        MOVE.W  #$4000,(A5)                     ; $001C02
        MOVE.W  #$0083,(-14218).W               ; $001C06
        MOVE.W  (-14218).W,(A5)                 ; $001C0C
        MOVE.W  (-14220).W,(A5)                 ; $001C10
        MOVE.W  (-14220).W,D4                   ; $001C14
        BSET    #4,D4                           ; $001C18
        MOVE.W  D4,(A5)                         ; $001C1C
        MOVE.L  #$93409400,(A5)                 ; $001C1E
        MOVE.L  #$954096C2,(A5)                 ; $001C24
        MOVE.W  #$977F,(A5)                     ; $001C2A
        MOVE.W  #$C000,(A5)                     ; $001C2E
        MOVE.W  #$0080,(-14218).W               ; $001C32
        MOVE.W  (-14218).W,(A5)                 ; $001C38
        MOVE.W  (-14220).W,(A5)                 ; $001C3C
        MOVE.W  #$0000,$00A11100                ; $001C40
        MOVE.L  #$6C000003,(A5)                 ; $001C48
        MOVE.W  (-32768).W,(A6)                 ; $001C4E
        MOVE.W  (-32766).W,(A6)                 ; $001C52
        MOVE.L  #$40000010,(A5)                 ; $001C56
        MOVE.W  (-14208).W,(A6)                 ; $001C5C
        MOVE.W  (-14206).W,(A6)                 ; $001C60
        RTS                                     ; $001C64
