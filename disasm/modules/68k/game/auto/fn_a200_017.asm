; ============================================================================
; Ai 017 (auto-analyzed)
; ROM Range: $00B478-$00B4CA (82 bytes)
; ============================================================================
; Category: game
; Purpose: Object (A4): +$01, +$02 (flags/type), +$03, +$04 (speed_index/velocity), +$05, +$06 (speed)
;
; Entry: A4 = object/entity pointer
; Uses: D0, D1, A4
; Object fields:
;   +$01: [unknown]
;   +$02: flags/type
;   +$03: [unknown]
;   +$04: speed_index/velocity
;   +$05: [unknown]
;   +$06: speed
;   +$07: [unknown]
; Confidence: low
; ============================================================================

fn_a200_017:
        DC.W    $023C                           ; $00B478
        DC.W    $00EF                           ; $00B47A
        MOVE.B  $0003(A4),D1                    ; $00B47C
        MOVE.B  $0007(A4),D0                    ; $00B480
        DC.W    $8300                           ; $00B484
        MOVE.B  D1,$0003(A4)                    ; $00B486
        MOVE.B  $0002(A4),D1                    ; $00B48A
        MOVE.B  $0006(A4),D0                    ; $00B48E
        DC.W    $8300                           ; $00B492
        ANDI.B  #$0F,D1                         ; $00B494
        MOVE.B  D1,$0002(A4)                    ; $00B498
        MOVE.B  $0001(A4),D1                    ; $00B49C
        MOVE.B  $0005(A4),D0                    ; $00B4A0
        DC.W    $8300                           ; $00B4A4
        BCC.S  .loc_0038                        ; $00B4A6
        SUBI.B  #$40,D1                         ; $00B4A8
        DC.W    $003C                           ; $00B4AC
        DC.W    $0010                           ; $00B4AE
.loc_0038:
        MOVE.B  D1,$0001(A4)                    ; $00B4B0
        MOVE.B  (A4),D1                         ; $00B4B4
        MOVE.B  $0004(A4),D0                    ; $00B4B6
        DC.W    $8300                           ; $00B4BA
        CMPI.B  #$59,D1                         ; $00B4BC
        BLE.S  .loc_004E                        ; $00B4C0
        MOVE.B  #$59,D1                         ; $00B4C2
.loc_004E:
        MOVE.B  D1,(A4)                         ; $00B4C6
        RTS                                     ; $00B4C8
