; ============================================================================
; fn_2200_019 — 32X Framebuffer Palette Fill
; ROM Range: $0027DA-$00281E (68 bytes)
; ============================================================================
; Fills 32X framebuffer palette entries using auto-fill registers.
; First calls VDPPrep at $00281E, then fills two 16-entry ranges:
;   Range 1: Starting address $2000, auto-fill with $0101, increment $0100
;   Range 2: Starting address $F000, same fill pattern
;
; For each entry: writes start address to $A15186 (palette addr),
; writes fill value to $A15188 (palette data), waits for fill complete
; (BTST #1 on status register $008B), then increments fill value.
;
; Entry: None (calls VDPPrep internally)
; Uses: D0, D1, D2, D7, A2, A3, A4
; Hardware:
;   MARS_SYS_BASE ($A15100): Adapter control
;   $A15186/$A15188: Palette address/data auto-fill registers
; Calls:
;   $00281E: VDPPrep (BSR)
; ============================================================================

fn_2200_019:
        DC.W    $6142               ; BSR.S  $00281E; $0027DA
        LEA     MARS_SYS_BASE,A4                    ; $0027DC
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
        ADD.W   D2,D1                           ; $002816
        DBRA    D7,.loc_0030                    ; $002818
        RTS                                     ; $00281C
