; ============================================================================
; Vdp Dispatch 031 (auto-analyzed)
; ROM Range: $00573C-$005772 (54 bytes)
; ============================================================================
; Category: vdp
; Purpose: State dispatcher using jump table
;   Calls: sfx_queue_process, VDPSyncSH2
;   Object (A2): +$78
;
; Entry: A2 = object/entity pointer
; Uses: D0, A0, A1, A2
; Calls:
;   $0021CA: sfx_queue_process
;   $0028C2: VDPSyncSH2
; Object fields:
;   +$78: [unknown]
; Confidence: medium
; ============================================================================

fn_4200_031:
        DC.W    $4EBA,$CA8C         ; JSR     $0021CA(PC); $00573C
        ADDQ.B  #1,(-23280).W                   ; $005740
        MOVEQ   #$00,D0                         ; $005744
        MOVE.B  (-14140).W,D0                   ; $005746
        MOVEA.L $005750(PC,D0.W),A1             ; $00574A
        JMP     (A1)                            ; $00574E
        DC.W    $0088                           ; $005750
        SUBQ.W  #3,-(A0)                        ; $005752
        DC.W    $0088                           ; $005754
        SUBQ.W  #3,-$78(A2,D0.W)                ; $005756
        SUBQ.L  #3,D0                           ; $00575A
        DC.W    $0088                           ; $00575C
        DC.W    $57BC                           ; $00575E
        DC.W    $4EBA,$D160         ; JSR     $0028C2(PC); $005760
        ADDQ.B  #4,(-14140).W                   ; $005764
        MOVE.W  #$0020,$00FF0008                ; $005768
        RTS                                     ; $005770
