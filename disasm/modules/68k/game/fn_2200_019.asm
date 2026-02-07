; ============================================================================
; Sh2 Comm Vdpprep 019 (auto-analyzed)
; ROM Range: $0027DA-$00281E (68 bytes)
; ============================================================================
; Category: sh2
; Purpose: Accesses 32X registers: adapter_ctrl
;   Calls: VDPPrep
;   Object (A4): +$84, +$8B
;
; Entry: A4 = object/entity pointer
; Uses: D0, D1, D2, D7, A2, A3, A4
; Calls:
;   $00281E: VDPPrep
; Object fields:
;   +$84: [unknown]
;   +$8B: [unknown]
; Confidence: high
; ============================================================================

fn_2200_019:
        DC.W    $6142               ; BSR.S  $00281E; $0027DA
        LEA     $00A15100,A4                    ; $0027DC
        LEA     $00A15186,A2                    ; $0027E2
        LEA     $00A15188,A3                    ; $0027E8
        MOVE.W  #$2000,D1                       ; $0027EE
        BSR.S  .loc_001E                        ; $0027F2
        MOVE.W  #$F000,D1                       ; $0027F4
.loc_001E:
        MOVE.W  #$000F,D7                       ; $0027F8
        MOVE.W  #$0101,D0                       ; $0027FC
        MOVE.W  #$0100,D2                       ; $002800
        MOVE.W  #$00FF,$0084(A4)                ; $002804
.loc_0030:
        MOVE.W  D1,(A2)                         ; $00280A
        MOVE.W  D0,(A3)                         ; $00280C
.loc_0034:
        BTST    #1,$008B(A4)                    ; $00280E
        BNE.S  .loc_0034                        ; $002814
        DC.W    $D242                           ; $002816
        DBRA    D7,.loc_0030                    ; $002818
        RTS                                     ; $00281C
