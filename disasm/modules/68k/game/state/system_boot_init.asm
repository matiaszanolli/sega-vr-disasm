; ============================================================================
; system_boot_init — System Boot Initialization
; ROM Range: $0006BC-$000C5A (1438 bytes)
; ============================================================================
; Main system boot orchestrator. Performs full hardware initialization:
;   1. Clears 64KB work RAM ($FF0000-$FFFFFF) — 2048 iterations x 32 bytes
;   2. Initializes 32X adapter registers and clears all COMM channels
;   3. Waits for framebuffer access, clears framebuffer and CRAM
;   4. Checks COMM4 for warm boot magic ("SQER"/$53514552 or "SDER"/$53444552)
;   5. Cold boot: validates ROM checksum, restores registers from table
;   6. Waits for SH2 "M_OK"/"S_OK" handshake on COMM0/COMM4
;   7. Resets Z80 three times (loads halt program: $F3 $F3 $C3 $00 $00)
;   8. Silences PSG three times (4 channels: $FF, $DF, $BF, $9F)
;   9. Initializes sound driver via SRAM bank access
;   10. Sets up VDP, waits for DMA idle, launches main game loop
;
; Uses: D0, D1, D2, D3, D4, D5, D6, D7, A0, A1, A4, A5, A6, A7
; Calls:
;   $000654: framebuffer_auto_fill_clear (BSR)
;   $000694: cram_fill (BSR)
;   $000C5A: register_restore_from_table (JSR PC-relative)
;   $000C80: hardware_init (JSR PC-relative)
;   $000D68: warm_boot_init (JSR PC-relative)
;   $000DC4: sound_update_check (JSR PC-relative)
;   $00203A: sh2_frame_sync (JSR PC-relative)
;   $00263E: adapter_init (JSR PC-relative)
; Hardware:
;   MARS_SYS_BASE ($A15100): 32X adapter control
;   COMM0-COMM6: SH2 handshake registers
;   Z80_BUSREQ/Z80_RESET/Z80_RAM: Z80 management
;   PSG ($C00011): Sound chip silence
;   VDP_CTRL/VDP_DATA: Video display processor
; ============================================================================

system_boot_init:
        LEA     $00FF0000,A0                    ; $0006BC
        MOVE.W  #$07FF,D7                       ; $0006C2
        MOVEQ   #$00,D0                         ; $0006C6
.loc_000C:
        MOVE.L  D0,(A0)+                        ; $0006C8
        MOVE.L  D0,(A0)+                        ; $0006CA
        MOVE.L  D0,(A0)+                        ; $0006CC
        MOVE.L  D0,(A0)+                        ; $0006CE
        MOVE.L  D0,(A0)+                        ; $0006D0
        MOVE.L  D0,(A0)+                        ; $0006D2
        MOVE.L  D0,(A0)+                        ; $0006D4
        MOVE.L  D0,(A0)+                        ; $0006D6
        DBRA    D7,.loc_000C                    ; $0006D8
        MOVE.W  #$0000,$1200(A5)                ; $0006DC
        MOVEQ   #$0A,D7                         ; $0006E2
.loc_0028:
        DBRA    D7,.loc_0028                    ; $0006E4
        LEA     MARS_SYS_BASE,A1                    ; $0006E8
        MOVEQ   #$00,D0                         ; $0006EE
        MOVE.L  D0,$0020(A1)                    ; $0006F0
        MOVE.L  D0,$0024(A1)                    ; $0006F4
        MOVE.B  #$03,$5101(A5)                  ; $0006F8
        MOVEA.L $00880000,A7                    ; $0006FE
.loc_0048:
        BCLR    #7,(A1)                         ; $000704
        BNE.S  .loc_0048                        ; $000708
        MOVEQ   #$00,D0                         ; $00070A
        MOVE.W  D0,$0002(A1)                    ; $00070C
        MOVE.W  D0,$0004(A1)                    ; $000710
        MOVE.W  D0,$0006(A1)                    ; $000714
        MOVE.L  D0,$0008(A1)                    ; $000718
        MOVE.L  D0,$000C(A1)                    ; $00071C
        MOVE.W  D0,$0010(A1)                    ; $000720
        MOVE.W  D0,$0030(A1)                    ; $000724
        MOVE.W  D0,$0032(A1)                    ; $000728
        MOVE.W  D0,$0038(A1)                    ; $00072C
        MOVE.W  D0,$0080(A1)                    ; $000730
        MOVE.W  D0,$0082(A1)                    ; $000734
.loc_007C:
        BCLR    #0,$008B(A1)                    ; $000738
        BNE.S  .loc_007C                        ; $00073E
        bsr.w   framebuffer_auto_fill_clear+22; $6100 $FF12
.loc_0088:
        BSET    #0,$008B(A1)                    ; $000744
        BEQ.S  .loc_0088                        ; $00074A
        bsr.w   framebuffer_auto_fill_clear+22; $6100 $FF06
        BCLR    #0,$008B(A1)                    ; $000750
        bsr.w   gfx_32x_cram_fill       ; $6100 $FF3C
        MOVE.W  #$0040,D0                       ; $00075A
        MOVE.L  $0020(A1),D1                    ; $00075E
        CMPI.L  #$53514552,D1                   ; $000762
        BEQ.W  .loc_0140                        ; $000768
        MOVE.W  #$0080,D0                       ; $00076C
        MOVE.L  $0020(A1),D1                    ; $000770
        CMPI.L  #$53444552,D1                   ; $000774
        BEQ.W  .loc_0140                        ; $00077A
        MOVE.L  #$008802A2,($0070).W            ; $00077E
        MOVE.W  #$0002,D0                       ; $000786
        MOVEQ   #$00,D1                         ; $00078A
        MOVE.B  $0001(A5),D1                    ; $00078C
        MOVE.B  $0080(A1),D2                    ; $000790
        LSL.W  #8,D2                            ; $000794
        OR.W    D2,D1                           ; $000796
        BTST    #15,D1                          ; $000798
        BNE.S  .loc_00EC                        ; $00079C
        BTST    #6,D1                           ; $00079E
        BEQ.W  .loc_0140                        ; $0007A2
        BRA.S  .loc_00F4                        ; $0007A6
.loc_00EC:
        BTST    #6,D1                           ; $0007A8
        BNE.W  .loc_0140                        ; $0007AC
.loc_00F4:
        MOVEQ   #$20,D0                         ; $0007B0
        LEA     $00880000,A0                    ; $0007B2
        MOVE.W  $018E(A0),D6                    ; $0007B8
        TST.W  D6                               ; $0007BC
        BEQ.W  .loc_0114                        ; $0007BE
.loc_0106:
        MOVE.W  $0028(A1),D2                    ; $0007C2
        CMPI.W  #$0000,D2                       ; $0007C6
        BEQ.S  .loc_0106                        ; $0007CA
        CMP.W  D6,D2                            ; $0007CC
        BNE.S  .loc_0140                        ; $0007CE
.loc_0114:
        MOVEQ   #$00,D0                         ; $0007D0
        MOVE.L  D0,$0028(A1)                    ; $0007D2
        MOVE.L  D0,$002C(A1)                    ; $0007D6
        MOVE.W  (A4),D7                         ; $0007DA
        MOVEA.L #$FFFFFFC0,A6                   ; $0007DC
        MOVEM.L (A6),D0/D3/D4/D5/D6/D7/A0/A1/A2/A3/A4/A5/A6; $0007E2
        MOVE    #$0000,CCR                      ; $0007E6
        BRA.S  .loc_0144                        ; $0007EA
        LEA     MARS_SYS_BASE,A1                    ; $0007EC
        MOVE.W  D0,$0006(A1)                    ; $0007F2
        MOVE.W  #$8000,D0                       ; $0007F6
        BRA.S  .loc_0144                        ; $0007FA
.loc_0140:
        MOVE    #$0001,CCR                      ; $0007FC
.loc_0144:
        BCS.S  .loc_016E                        ; $000800
        LEA     COMM0,A0                    ; $000802
.loc_014C:
        CMPI.L  #$4D5F4F4B,(A0)                 ; $000808
        BNE.S  .loc_014C                        ; $00080E
.loc_0154:
        CMPI.L  #$535F4F4B,$0004(A0)            ; $000810
        BNE.S  .loc_0154                        ; $000818
        MOVE.L  #$00000000,(A0)                 ; $00081A
        BTST    #15,D0                          ; $000820
        BNE.S  .loc_017C                        ; $000824
        BRA.W  .loc_03CC                        ; $000826
.loc_016E:
        BTST    #5,D0                           ; $00082A
        DC.W    $6600,$0678         ; BNE.W  $000EA8; $00082E
        NOP                                     ; $000832
        NOP                                     ; $000834
        BRA.S  .loc_016E                        ; $000836
.loc_017C:
        LEA     MARS_SYS_BASE,A4                    ; $000838
        BTST    #0,$0001(A4)                    ; $00083E
        BEQ.S  .loc_01AA                        ; $000844
        BTST    #1,$0001(A4)                    ; $000846
        BNE.S  .loc_01EC                        ; $00084C
        LEA     $00A10000,A5                    ; $00084E
        MOVEA.L #$FFFFFFC0,A4                   ; $000854
        MOVE.W  #$0F3C,D7                       ; $00085A
        LEA     $008806E4,A1                    ; $00085E
        JMP     (A1)                            ; $000864
.loc_01AA:
        MOVE.L  #$00000000,COMM4            ; $000866
        LEA     $00880894,A0                    ; $000870
        LEA     $00FF0000,A1                    ; $000876
        MOVE.L  (A0)+,(A1)+                     ; $00087C
        MOVE.L  (A0)+,(A1)+                     ; $00087E
        MOVE.L  (A0)+,(A1)+                     ; $000880
        MOVE.L  (A0)+,(A1)+                     ; $000882
        MOVE.L  (A0)+,(A1)+                     ; $000884
        MOVE.L  (A0)+,(A1)+                     ; $000886
        MOVE.L  (A0)+,(A1)+                     ; $000888
        MOVE.L  (A0)+,(A1)+                     ; $00088A
        LEA     $00FF0000,A0                    ; $00088C
        JMP     (A0)                            ; $000892
        MOVE.B  #$01,$0001(A4)                  ; $000894
        LEA     $0088084E,A0                    ; $00089A
        ADDA.L  #$00880000,A0                   ; $0008A0
        JMP     (A0)                            ; $0008A6
.loc_01EC:
        MOVE.W  #$1000,D7                       ; $0008A8
.loc_01F0:
        CMPI.L  #$56524553,COMM6            ; $0008AC
        DBEQ    D7,.loc_01F0                    ; $0008B6
        BEQ.W  .loc_02FA                        ; $0008BA
        jsr     mars_regs_init_13(pc)   ; $4EBA $1D7E
        ORI.B  #$03,MARS_SYS_INTMASK+1                   ; $0008C2
        LEA     COMM0,A0                    ; $0008CA
.loc_0214:
        CMPI.L  #$4D5F4F4B,(A0)                 ; $0008D0
        BNE.S  .loc_0214                        ; $0008D6
.loc_021C:
        CMPI.L  #$535F4F4B,$0004(A0)            ; $0008D8
        BNE.S  .loc_021C                        ; $0008E0
        MOVE.L  #$00000000,(A0)                 ; $0008E2
        MOVE    SR,-(A7)                        ; $0008E8
        MOVE    #$2700,SR                       ; $0008EA
        MOVE.W  #$0100,Z80_BUSREQ                ; $0008EE
        MOVE.W  #$0100,Z80_RESET                ; $0008F6
.loc_0242:
        BTST    #0,Z80_BUSREQ                    ; $0008FE
        BNE.S  .loc_0242                        ; $000906
        LEA     Z80_RAM,A1                    ; $000908
        MOVE.B  #$F3,(A1)+                      ; $00090E
        MOVE.B  #$F3,(A1)+                      ; $000912
        MOVE.B  #$C3,(A1)+                      ; $000916
        MOVE.B  #$00,(A1)+                      ; $00091A
        MOVE.B  #$00,(A1)+                      ; $00091E
        MOVE.W  #$0000,Z80_RESET                ; $000922
        NOP                                     ; $00092A
        NOP                                     ; $00092C
        NOP                                     ; $00092E
        NOP                                     ; $000930
        NOP                                     ; $000932
        NOP                                     ; $000934
        NOP                                     ; $000936
        NOP                                     ; $000938
        NOP                                     ; $00093A
        NOP                                     ; $00093C
        NOP                                     ; $00093E
        NOP                                     ; $000940
        NOP                                     ; $000942
        NOP                                     ; $000944
        MOVE.W  #$0000,Z80_BUSREQ                ; $000946
        MOVE.W  #$0100,Z80_RESET                ; $00094E
        MOVE    (A7)+,SR                        ; $000956
        MOVEQ   #-$01,D0                        ; $000958
        MOVE.B  D0,PSG                    ; $00095A
        NOP                                     ; $000960
        NOP                                     ; $000962
        SUBI.B  #$20,D0                         ; $000964
        MOVE.B  D0,PSG                    ; $000968
        NOP                                     ; $00096E
        NOP                                     ; $000970
        SUBI.B  #$20,D0                         ; $000972
        MOVE.B  D0,PSG                    ; $000976
        NOP                                     ; $00097C
        NOP                                     ; $00097E
        SUBI.B  #$20,D0                         ; $000980
        MOVE.B  D0,PSG                    ; $000984
        MOVE.W  #$0100,Z80_BUSREQ                ; $00098A
.loc_02D6:
        BTST    #0,Z80_BUSREQ                    ; $000992
        BNE.S  .loc_02D6                        ; $00099A
        LEA     SRAM_BANK0,A1                    ; $00099C
        TST.B  (A1)                             ; $0009A2
        MOVEQ   #$00,D0                         ; $0009A4
        JSR     ($00C0).W                       ; $0009A6
        MOVE.W  #$0000,Z80_BUSREQ                ; $0009AA
        jmp     system_boot_init+1198(pc); $4EFA $01B6
.loc_02FA:
        MOVE    SR,-(A7)                        ; $0009B6
        MOVE    #$2700,SR                       ; $0009B8
        MOVE.W  #$0100,Z80_BUSREQ                ; $0009BC
        MOVE.W  #$0100,Z80_RESET                ; $0009C4
.loc_0310:
        BTST    #0,Z80_BUSREQ                    ; $0009CC
        BNE.S  .loc_0310                        ; $0009D4
        LEA     Z80_RAM,A1                    ; $0009D6
        MOVE.B  #$F3,(A1)+                      ; $0009DC
        MOVE.B  #$F3,(A1)+                      ; $0009E0
        MOVE.B  #$C3,(A1)+                      ; $0009E4
        MOVE.B  #$00,(A1)+                      ; $0009E8
        MOVE.B  #$00,(A1)+                      ; $0009EC
        MOVE.W  #$0000,Z80_RESET                ; $0009F0
        NOP                                     ; $0009F8
        NOP                                     ; $0009FA
        NOP                                     ; $0009FC
        NOP                                     ; $0009FE
        NOP                                     ; $000A00
        NOP                                     ; $000A02
        NOP                                     ; $000A04
        NOP                                     ; $000A06
        NOP                                     ; $000A08
        NOP                                     ; $000A0A
        NOP                                     ; $000A0C
        NOP                                     ; $000A0E
        NOP                                     ; $000A10
        NOP                                     ; $000A12
        MOVE.W  #$0000,Z80_BUSREQ                ; $000A14
        MOVE.W  #$0100,Z80_RESET                ; $000A1C
        MOVE    (A7)+,SR                        ; $000A24
        MOVEQ   #-$01,D0                        ; $000A26
        MOVE.B  D0,PSG                    ; $000A28
        NOP                                     ; $000A2E
        NOP                                     ; $000A30
        SUBI.B  #$20,D0                         ; $000A32
        MOVE.B  D0,PSG                    ; $000A36
        NOP                                     ; $000A3C
        NOP                                     ; $000A3E
        SUBI.B  #$20,D0                         ; $000A40
        MOVE.B  D0,PSG                    ; $000A44
        NOP                                     ; $000A4A
        NOP                                     ; $000A4C
        SUBI.B  #$20,D0                         ; $000A4E
        MOVE.B  D0,PSG                    ; $000A52
        MOVE.W  #$0100,Z80_BUSREQ                ; $000A58
.loc_03A4:
        BTST    #0,Z80_BUSREQ                    ; $000A60
        BNE.S  .loc_03A4                        ; $000A68
        LEA     SRAM_BANK0,A1                    ; $000A6A
        TST.B  (A1)                             ; $000A70
        MOVEQ   #$00,D0                         ; $000A72
        JSR     ($00C0).W                       ; $000A74
        MOVE.W  #$0000,Z80_BUSREQ                ; $000A78
        jsr     mars_regs_init_13(pc)   ; $4EBA $1BBC
        jmp     system_boot_init+1198(pc); $4EFA $00E4
.loc_03CC:
        MOVE    SR,-(A7)                        ; $000A88
        MOVE    #$2700,SR                       ; $000A8A
        MOVE.W  #$0100,Z80_BUSREQ                ; $000A8E
        MOVE.W  #$0100,Z80_RESET                ; $000A96
.loc_03E2:
        BTST    #0,Z80_BUSREQ                    ; $000A9E
        BNE.S  .loc_03E2                        ; $000AA6
        LEA     Z80_RAM,A1                    ; $000AA8
        MOVE.B  #$F3,(A1)+                      ; $000AAE
        MOVE.B  #$F3,(A1)+                      ; $000AB2
        MOVE.B  #$C3,(A1)+                      ; $000AB6
        MOVE.B  #$00,(A1)+                      ; $000ABA
        MOVE.B  #$00,(A1)+                      ; $000ABE
        MOVE.W  #$0000,Z80_RESET                ; $000AC2
        NOP                                     ; $000ACA
        NOP                                     ; $000ACC
        NOP                                     ; $000ACE
        NOP                                     ; $000AD0
        NOP                                     ; $000AD2
        NOP                                     ; $000AD4
        NOP                                     ; $000AD6
        NOP                                     ; $000AD8
        NOP                                     ; $000ADA
        NOP                                     ; $000ADC
        NOP                                     ; $000ADE
        NOP                                     ; $000AE0
        NOP                                     ; $000AE2
        NOP                                     ; $000AE4
        MOVE.W  #$0000,Z80_BUSREQ                ; $000AE6
        MOVE.W  #$0100,Z80_RESET                ; $000AEE
        MOVE    (A7)+,SR                        ; $000AF6
        MOVEQ   #-$01,D0                        ; $000AF8
        MOVE.B  D0,PSG                    ; $000AFA
        NOP                                     ; $000B00
        NOP                                     ; $000B02
        SUBI.B  #$20,D0                         ; $000B04
        MOVE.B  D0,PSG                    ; $000B08
        NOP                                     ; $000B0E
        NOP                                     ; $000B10
        SUBI.B  #$20,D0                         ; $000B12
        MOVE.B  D0,PSG                    ; $000B16
        NOP                                     ; $000B1C
        NOP                                     ; $000B1E
        SUBI.B  #$20,D0                         ; $000B20
        MOVE.B  D0,PSG                    ; $000B24
        MOVE.W  #$0100,Z80_BUSREQ                ; $000B2A
.loc_0476:
        BTST    #0,Z80_BUSREQ                    ; $000B32
        BNE.S  .loc_0476                        ; $000B3A
        LEA     SRAM_BANK0,A1                    ; $000B3C
        TST.B  (A1)                             ; $000B42
        MOVEQ   #$00,D0                         ; $000B44
        JSR     ($00C0).W                       ; $000B46
        MOVE.W  #$0000,Z80_BUSREQ                ; $000B4A
        MOVE.W  #$0001,MARS_SYS_HCOUNT                ; $000B52
        LEA     VDP_DATA,A6                    ; $000B5A
        LEA     VDP_CTRL,A5                    ; $000B60
        jsr     hardware_init+16(pc)    ; $4EBA $0118
        JSR     .loc_058C(PC)                   ; $000B6A
        jsr     register_restore_from_table(pc); $4EBA $00EA
        LEA     VDP_DATA,A6                    ; $000B72
        LEA     VDP_CTRL,A5                    ; $000B78
        MOVE    SR,-(A7)                        ; $000B7E
        MOVE    #$2700,SR                       ; $000B80
        MOVE.W  #$0100,Z80_BUSREQ                ; $000B84
        MOVE.W  #$0100,Z80_RESET                ; $000B8C
.loc_04D8:
        BTST    #0,Z80_BUSREQ                    ; $000B94
        BNE.S  .loc_04D8                        ; $000B9C
        LEA     Z80_RAM,A1                    ; $000B9E
        MOVE.B  #$F3,(A1)+                      ; $000BA4
        MOVE.B  #$F3,(A1)+                      ; $000BA8
        MOVE.B  #$C3,(A1)+                      ; $000BAC
        MOVE.B  #$00,(A1)+                      ; $000BB0
        MOVE.B  #$00,(A1)+                      ; $000BB4
        MOVE.W  #$0000,Z80_RESET                ; $000BB8
        NOP                                     ; $000BC0
        NOP                                     ; $000BC2
        NOP                                     ; $000BC4
        NOP                                     ; $000BC6
        NOP                                     ; $000BC8
        NOP                                     ; $000BCA
        NOP                                     ; $000BCC
        NOP                                     ; $000BCE
        NOP                                     ; $000BD0
        NOP                                     ; $000BD2
        NOP                                     ; $000BD4
        NOP                                     ; $000BD6
        NOP                                     ; $000BD8
        NOP                                     ; $000BDA
        MOVE.W  #$0000,Z80_BUSREQ                ; $000BDC
        MOVE.W  #$0100,Z80_RESET                ; $000BE4
        MOVE    (A7)+,SR                        ; $000BEC
        MOVEQ   #-$01,D0                        ; $000BEE
        MOVE.B  D0,PSG                    ; $000BF0
        NOP                                     ; $000BF6
        NOP                                     ; $000BF8
        SUBI.B  #$20,D0                         ; $000BFA
        MOVE.B  D0,PSG                    ; $000BFE
        NOP                                     ; $000C04
        NOP                                     ; $000C06
        SUBI.B  #$20,D0                         ; $000C08
        MOVE.B  D0,PSG                    ; $000C0C
        NOP                                     ; $000C12
        NOP                                     ; $000C14
        SUBI.B  #$20,D0                         ; $000C16
        MOVE.B  D0,PSG                    ; $000C1A
        jsr     sh2_frame_sync_wrapper(pc); $4EBA $1418
        jsr     system_init_orch(pc)    ; $4EBA $0142
        jsr     double_cond_guard(pc)   ; $4EBA $019A
        JSR     $0088C85C                       ; $000C2C
        JSR     $00880FBE                       ; $000C32
        MOVE.L  #$00894262,$00FF0002            ; $000C38
        JMP     $00FF0000                       ; $000C42
.loc_058C:
        NOP                                     ; $000C48
        NOP                                     ; $000C4A
        MOVE.W  VDP_CTRL,D0                    ; $000C4C
        BTST    #1,D0                           ; $000C52
        BNE.S  .loc_058C                        ; $000C56
        RTS                                     ; $000C58
