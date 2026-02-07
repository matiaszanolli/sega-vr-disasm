; ============================================================================
; Sh2 Comm Z80 Bus Vdp Init 008 (auto-analyzed)
; ROM Range: $000D68-$000DC4 (92 bytes)
; ============================================================================
; Category: sh2
; Purpose: Orchestrator calling 4 subroutines
;   Accesses 32X registers: adapter_ctrl
;   Calls: z80_bus_vdp_init, controller_port_init
;
; Uses: D0, D1, D7, A1, A2
; Calls:
;   $000FEA: z80_bus_vdp_init
;   $00170C: controller_port_init
; Confidence: high
; ============================================================================

fn_200_008:
        DC.W    $4EBA,$0046         ; JSR     $000DB0(PC); $000D68
        DC.W    $4EBA,$027C         ; JSR     $000FEA(PC); $000D6C
        MOVE.B  (-348).W,D0                     ; $000D70
        CMP.B  (-14312).W,D0                    ; $000D74
        BEQ.S  .loc_001C                        ; $000D78
        DC.W    $4EBA,$0990         ; JSR     $00170C(PC); $000D7A
        MOVE.B  (-14312).W,(-348).W             ; $000D7E
.loc_001C:
        DC.W    $4EBA,$02C2         ; JSR     $001048(PC); $000D84
        MOVE.W  #$0083,$00A15100                ; $000D88
        ANDI.B  #$FC,$00A15181                  ; $000D90
        JSR     $0088266C                       ; $000D98
        JSR     $008826C8                       ; $000D9E
        LEA     $008BA020,A2                    ; $000DA4
        JMP     $0088284C                       ; $000DAA
        LEA     $00FF1000,A1                    ; $000DB0
        MOVEQ   #$00,D1                         ; $000DB6
        MOVE.W  #$2E67,D7                       ; $000DB8
.loc_0054:
        MOVE.L  D1,(A1)+                        ; $000DBC
        DBRA    D7,.loc_0054                    ; $000DBE
        RTS                                     ; $000DC2
