; ============================================================================
; framebuffer_auto_fill_clear — Framebuffer Auto-Fill Clear
; ROM Range: $00063E-$000694 (86 bytes)
; ============================================================================
; Data prefix ($00063E-$000653): VDP register values for DMA fill setup
; ($8114, $8F01, $93FF, $94FF, $9500, $9600, $9780, $4000, $0080, $8104, $8F02).
;
; Code entry at $000654: Clears 32X framebuffer using auto-fill registers.
; Waits for framebuffer access (BCLR #7 on adapter control), sets auto-fill
; length to 255, then iterates 256 times filling with zero via auto-increment
; ($0100 per iteration).
;
; Entry: Called from system_boot_init at $000654 (NOT at framebuffer_auto_fill_clear label)
; Uses: D0, D1, D7, A1
; Hardware:
;   MARS_VDP_MODE ($A15180): Auto-fill length (+$04), address (+$06), data (+$08)
; ============================================================================

framebuffer_auto_fill_clear:
        OR.B   D0,(A4)                          ; $00063E
        DC.W    $8F01                           ; $000640
        DC.W    $93FF                           ; $000642
        DC.W    $94FF                           ; $000644
        DC.W    $9500                           ; $000646
        DC.W    $9600                           ; $000648
        DC.W    $9780                           ; $00064A
        NEGX.B D0                               ; $00064C
        ORI.L  #$81048F02,D0                    ; $00064E
        MOVEM.L D0/D1/D7/A1,-(A7)               ; $000654
        LEA     MARS_VDP_MODE,A1                    ; $000658
.loc_0020:
        BCLR    #7,-$0080(A1)                   ; $00065E
        BNE.S  .loc_0020                        ; $000664
        MOVE.W  #$00FF,D7                       ; $000666
        MOVEQ   #$00,D0                         ; $00066A
        MOVEQ   #$00,D1                         ; $00066C
        MOVE.W  #$00FF,$0004(A1)                ; $00066E
.loc_0036:
        MOVE.W  D1,$0006(A1)                    ; $000674
        MOVE.W  D0,$0008(A1)                    ; $000678
        NOP                                     ; $00067C
.loc_0040:
        BTST    #1,$000B(A1)                    ; $00067E
        BNE.S  .loc_0040                        ; $000684
        ADDI.W  #$0100,D1                       ; $000686
        DBRA    D7,.loc_0036                    ; $00068A
        MOVEM.L (A7)+,D0/D1/D7/A1               ; $00068E
        RTS                                     ; $000692
