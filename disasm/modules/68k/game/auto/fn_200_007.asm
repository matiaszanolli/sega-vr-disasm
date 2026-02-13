; ============================================================================
; fn_200_007 — Hardware Initialization
; ROM Range: $000C70-$000D68 (248 bytes)
; ============================================================================
; Data prefix ($000C70-$000C7F): Register initialization values read by
; fn_200_006 via MOVEM.L (decoded as ORI.B #$00,D0 no-ops by disassembler).
;
; Code entry at $000C80: Performs hardware initialization sequence:
;   1. Resets Z80 (loads halt program: $F3 $F3 $C3 $00 $00)
;   2. Silences PSG (4 channels: $FF, $DF, $BF, $9F)
;   3. Clears work RAM ($C9A0-$FF00 range, $0D57+1 longwords)
;   4. Reads hardware version from $A10001
;   5. Detects expansion port and NTSC/PAL via version register bits 6-7
;   6. Initializes I/O ports and controller drivers
;
; Entry: Called from system_boot_init at $000C80
; Uses: D0, D1, D7, A1
; Calls:
;   $0018D8: io_port_init (JSR PC-relative)
;   $00170C: controller_port_init (JSR PC-relative)
; Hardware:
;   Z80_BUSREQ/Z80_RESET/Z80_RAM: Z80 management
;   PSG ($C00011): Sound chip silence
;   $A10001: Hardware version register
; ============================================================================

fn_200_007:
        ORI.B  #$00,D0                          ; $000C70
        ORI.B  #$00,D0                          ; $000C74
        ORI.B  #$00,D0                          ; $000C78
        ORI.B  #$00,D0                          ; $000C7C
        MOVE    SR,-(A7)                        ; $000C80
        MOVE    #$2700,SR                       ; $000C82
        MOVE.W  #$0100,Z80_BUSREQ                ; $000C86
        MOVE.W  #$0100,Z80_RESET                ; $000C8E
.loc_0026:
        BTST    #0,Z80_BUSREQ                    ; $000C96
        BNE.S  .loc_0026                        ; $000C9E
        LEA     Z80_RAM,A1                    ; $000CA0
        MOVE.B  #$F3,(A1)+                      ; $000CA6
        MOVE.B  #$F3,(A1)+                      ; $000CAA
        MOVE.B  #$C3,(A1)+                      ; $000CAE
        MOVE.B  #$00,(A1)+                      ; $000CB2
        MOVE.B  #$00,(A1)+                      ; $000CB6
        MOVE.W  #$0000,Z80_RESET                ; $000CBA
        NOP                                     ; $000CC2
        NOP                                     ; $000CC4
        NOP                                     ; $000CC6
        NOP                                     ; $000CC8
        NOP                                     ; $000CCA
        NOP                                     ; $000CCC
        NOP                                     ; $000CCE
        NOP                                     ; $000CD0
        NOP                                     ; $000CD2
        NOP                                     ; $000CD4
        NOP                                     ; $000CD6
        NOP                                     ; $000CD8
        NOP                                     ; $000CDA
        NOP                                     ; $000CDC
        MOVE.W  #$0000,Z80_BUSREQ                ; $000CDE
        MOVE.W  #$0100,Z80_RESET                ; $000CE6
        MOVE    (A7)+,SR                        ; $000CEE
        MOVEQ   #-$01,D0                        ; $000CF0
        MOVE.B  D0,PSG                    ; $000CF2
        NOP                                     ; $000CF8
        NOP                                     ; $000CFA
        SUBI.B  #$20,D0                         ; $000CFC
        MOVE.B  D0,PSG                    ; $000D00
        NOP                                     ; $000D06
        NOP                                     ; $000D08
        SUBI.B  #$20,D0                         ; $000D0A
        MOVE.B  D0,PSG                    ; $000D0E
        NOP                                     ; $000D14
        NOP                                     ; $000D16
        SUBI.B  #$20,D0                         ; $000D18
        MOVE.B  D0,PSG                    ; $000D1C
        LEA     (-13920).W,A1                   ; $000D22
        MOVEQ   #$00,D1                         ; $000D26
        MOVE.W  #$0D57,D7                       ; $000D28
.loc_00BC:
        MOVE.L  D1,(A1)+                        ; $000D2C
        DBRA    D7,.loc_00BC                    ; $000D2E
        MOVE.B  $00A10001,D0                    ; $000D32
        MOVE.B  D0,(-4348).W                    ; $000D38
        BTST    #7,D0                           ; $000D3C
        SNE     (-4347).W                       ; $000D40
        BTST    #6,D0                           ; $000D44
        SNE     (-4346).W                       ; $000D48
        JSR     $0088C7E8                       ; $000D4C
        DC.W    $4EBA,$0B84         ; JSR     $0018D8(PC); $000D52
        DC.W    $4EBA,$09B4         ; JSR     $00170C(PC); $000D56
        MOVE.B  #$01,(-599).W                   ; $000D5A
        MOVE.B  (-14312).W,(-348).W             ; $000D60
        RTS                                     ; $000D66
