; ============================================================================
; Sh2 Comm Framebuffer Prep 018 (auto-analyzed)
; ROM Range: $00270A-$00273C (50 bytes)
; ============================================================================
; Category: sh2
; Purpose: Orchestrator calling 3 subroutines
;   Accesses 32X registers: adapter_ctrl
;   Calls: sh2_framebuffer_prep
;   Object (A4): +$8B
;
; Entry: A4 = object/entity pointer
; Uses: D0, D2, A4
; Calls:
;   $0027DA: sh2_framebuffer_prep
; Object fields:
;   +$8B: [unknown]
; Confidence: high
; ============================================================================

fn_2200_018:
        LEA     $00A15100,A4                    ; $00270A
        DC.W    $6130               ; BSR.S  $002742; $002710
        DC.W    $4EBA,$008C         ; JSR     $0027A0(PC); $002712
        DC.W    $4EBA,$00C2         ; JSR     $0027DA(PC); $002716
        MOVEQ   #$01,D0                         ; $00271A
        MOVEQ   #$00,D2                         ; $00271C
        BTST    #0,(-14324).W                   ; $00271E
        BEQ.S  .loc_0020                        ; $002724
        MOVEQ   #$00,D0                         ; $002726
        MOVEQ   #$01,D2                         ; $002728
.loc_0020:
        MOVE.B  D0,$008B(A4)                    ; $00272A
        DC.W    $6112               ; BSR.S  $002742; $00272E
        DC.W    $616E               ; BSR.S  $0027A0; $002730
        DC.W    $4EBA,$00A6         ; JSR     $0027DA(PC); $002732
        MOVE.B  D2,$008B(A4)                    ; $002736
        RTS                                     ; $00273A
