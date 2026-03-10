; ============================================================================
; scene_param_adjustment_and_dma_upload — Scene Parameter Adjustment and DMA Upload
; ROM Range: $00DA90-$00DCAC (540 bytes)
; Data prefix (48 bytes: 6 longword pointers + 6 word pairs). Sends
; DMA transfer command, then loads viewport parameters from $FF2000
; table indexed by palette selection. Handles D-pad input for multi-
; axis camera/viewport adjustment with per-axis clamping. Writes
; updated parameters back to $FF2000. Sends SH2 update command and
; advances state counter.
;
; Uses: D0, D1, D3, D4, D5, A0, A1, A4
; Calls: $00E35A (sh2_send_cmd), $00E52C (dma_transfer),
;        $00DCAC/$00DCBE/$00DCB8/$00DCCA (increment/decrement helpers)
; Confidence: high
; ============================================================================

scene_param_adjustment_and_dma_upload:
        MOVE.L  $6AE2(A1),D1                    ; $00DA90
        MOVE.L  -$7BF4(A1),D1                   ; $00DA94
        MOVE.L  -$5D12(A1),D1                   ; $00DA98
        MOVE.L  -$4608(A1),D1                   ; $00DA9C
        MOVE.L  -$2CD4(A1),D1                   ; $00DAA0
        MOVE.L  $6AE2(A1),D1                    ; $00DAA4
        DC.W    $008B                           ; $00DAA8
        CMP.W  (A4)+,D3                         ; $00DAAA
        DC.W    $008B                           ; $00DAAC
        EOR.W  D3,(A4)+                         ; $00DAAE
        DC.W    $008B                           ; $00DAB0
        CMP.W  (A4)+,D4                         ; $00DAB2
        DC.W    $008B                           ; $00DAB4
        EOR.W  D4,(A4)+                         ; $00DAB6
        DC.W    $008B                           ; $00DAB8
        CMP.W  (A4)+,D5                         ; $00DABA
        DC.W    $008B                           ; $00DABC
        CMP.W  (A4)+,D3                         ; $00DABE
        CLR.W  D0                               ; $00DAC0
        MOVE.B  (-24537).W,D0                   ; $00DAC2
        jsr     MemoryInit(pc)          ; $4EBA $0A64
        MOVEA.L #$0603D100,A0                   ; $00DACA
        MOVEA.L #$24004C58,A1                   ; $00DAD0
        MOVE.W  #$0090,D0                       ; $00DAD6
        MOVE.W  #$0010,D1                       ; $00DADA
        DC.W    $6100,$087A         ; BSR.W  $00E35A; $00DADE
        CLR.W  D0                               ; $00DAE2
        MOVE.B  (-24551).W,D0                   ; $00DAE4
        TST.B  (-24537).W                       ; $00DAE8
        BEQ.W  .palette_index_ready                        ; $00DAEC
        MOVE.B  (-24539).W,D0                   ; $00DAF0
.palette_index_ready:
        ADD.W   D0,D0                           ; $00DAF4
        MOVE.W  D0,D1                           ; $00DAF6
        ADD.W   D0,D0                           ; $00DAF8
        ADD.W   D0,D0                           ; $00DAFA
        ADD.W   D1,D0                           ; $00DAFC
        LEA     $00FF2000,A0                    ; $00DAFE
        MOVE.W  $00(A0,D0.W),(-24550).W         ; $00DB04
        MOVE.W  $02(A0,D0.W),(-24548).W         ; $00DB0A
        MOVE.W  $04(A0,D0.W),(-24546).W         ; $00DB10
        MOVE.W  $06(A0,D0.W),(-24544).W         ; $00DB16
        MOVE.W  $08(A0,D0.W),(-24542).W         ; $00DB1C
        MOVE.W  (-14226).W,D1                   ; $00DB22
        LSR.L  #8,D1                            ; $00DB26
        BTST    #7,D1                           ; $00DB28
        BEQ.W  .write_back_params                        ; $00DB2C
        BTST    #5,D1                           ; $00DB30
        BNE.W  .extended_axis_mode                        ; $00DB34
        BTST    #0,D1                           ; $00DB38
        BEQ.S  .check_y_dec                        ; $00DB3C
        MOVE.W  (-24548).W,D0                   ; $00DB3E
        bsr.w   positive_velocity_step_small_inc; $6100 $0168
        CMPI.W  #$02F0,D0                       ; $00DB46
        BLT.W  .store_y_inc                        ; $00DB4A
        MOVE.W  #$02F0,D0                       ; $00DB4E
.store_y_inc:
        MOVE.W  D0,(-24548).W                   ; $00DB52
        BRA.W  .write_back_params                        ; $00DB56
.check_y_dec:
        BTST    #1,D1                           ; $00DB5A
        BEQ.S  .check_x_inc                        ; $00DB5E
        MOVE.W  (-24548).W,D0                   ; $00DB60
        bsr.w   negative_velocity_step_small_dec; $6100 $0158
        CMPI.W  #$FBFE,D0                       ; $00DB68
        BGT.W  .store_y_dec                        ; $00DB6C
        MOVE.W  #$FBFE,D0                       ; $00DB70
.store_y_dec:
        MOVE.W  D0,(-24548).W                   ; $00DB74
        BRA.W  .write_back_params                        ; $00DB78
.check_x_inc:
        BTST    #3,D1                           ; $00DB7C
        BEQ.S  .check_x_dec                        ; $00DB80
        MOVE.W  (-24550).W,D0                   ; $00DB82
        bsr.w   positive_velocity_step_small_inc; $6100 $0124
        CMPI.W  #$0120,D0                       ; $00DB8A
        BLT.W  .store_x_inc                        ; $00DB8E
        MOVE.W  #$0120,D0                       ; $00DB92
.store_x_inc:
        MOVE.W  D0,(-24550).W                   ; $00DB96
        BRA.W  .write_back_params                        ; $00DB9A
.check_x_dec:
        BTST    #2,D1                           ; $00DB9E
        BEQ.S  .check_z_inc                        ; $00DBA2
        MOVE.W  (-24550).W,D0                   ; $00DBA4
        bsr.w   negative_velocity_step_small_dec; $6100 $0114
        CMPI.W  #$FEE0,D0                       ; $00DBAC
        BGT.W  .store_x_dec                        ; $00DBB0
        MOVE.W  #$FEE0,D0                       ; $00DBB4
.store_x_dec:
        MOVE.W  D0,(-24550).W                   ; $00DBB8
        BRA.W  .write_back_params                        ; $00DBBC
.check_z_inc:
        BTST    #6,D1                           ; $00DBC0
        BEQ.S  .check_z_dec                        ; $00DBC4
        MOVE.W  (-24546).W,D0                   ; $00DBC6
        bsr.w   positive_velocity_step_small_inc; $6100 $00E0
        CMPI.W  #$0460,D0                       ; $00DBCE
        BLT.W  .store_z_inc                        ; $00DBD2
        MOVE.W  #$0460,D0                       ; $00DBD6
.store_z_inc:
        MOVE.W  D0,(-24546).W                   ; $00DBDA
        BRA.W  .write_back_params                        ; $00DBDE
.check_z_dec:
        BTST    #4,D1                           ; $00DBE2
        BEQ.S  .write_back_params                        ; $00DBE6
        MOVE.W  (-24546).W,D0                   ; $00DBE8
        bsr.w   negative_velocity_step_small_dec; $6100 $00D0
        CMPI.W  #$0050,D0                       ; $00DBF0
        BGT.W  .store_z_dec                        ; $00DBF4
        MOVE.W  #$0050,D0                       ; $00DBF8
.store_z_dec:
        MOVE.W  D0,(-24546).W                   ; $00DBFC
        BRA.W  .write_back_params                        ; $00DC00
.extended_axis_mode:
        BTST    #0,D1                           ; $00DC04
        BEQ.S  .check_ext_dec_a                        ; $00DC08
        MOVE.W  (-24544).W,D0                   ; $00DC0A
        bsr.w   positive_velocity_step_small_inc+12; $6100 $00A8
        MOVE.W  D0,(-24544).W                   ; $00DC12
        BRA.W  .write_back_params                        ; $00DC16
.check_ext_dec_a:
        BTST    #1,D1                           ; $00DC1A
        BEQ.S  .check_ext_inc_b                        ; $00DC1E
        MOVE.W  (-24544).W,D0                   ; $00DC20
        bsr.w   negative_velocity_step_small_dec+12; $6100 $00A4
        MOVE.W  D0,(-24544).W                   ; $00DC28
        BRA.W  .write_back_params                        ; $00DC2C
.check_ext_inc_b:
        BTST    #3,D1                           ; $00DC30
        BEQ.S  .check_ext_dec_b                        ; $00DC34
        MOVE.W  (-24542).W,D0                   ; $00DC36
        bsr.w   positive_velocity_step_small_inc+12; $6100 $007C
        MOVE.W  D0,(-24542).W                   ; $00DC3E
        BRA.W  .write_back_params                        ; $00DC42
.check_ext_dec_b:
        BTST    #2,D1                           ; $00DC46
        BEQ.S  .write_back_params                        ; $00DC4A
        MOVE.W  (-24542).W,D0                   ; $00DC4C
        bsr.w   negative_velocity_step_small_dec+12; $6100 $0078
        MOVE.W  D0,(-24542).W                   ; $00DC54
        BRA.W  .write_back_params                        ; $00DC58
        NOP                                     ; $00DC5C
.write_back_params:
        CLR.W  D0                               ; $00DC5E
        MOVE.B  (-24551).W,D0                   ; $00DC60
        TST.B  (-24537).W                       ; $00DC64
        BEQ.W  .writeback_index_ready                        ; $00DC68
        MOVE.B  (-24539).W,D0                   ; $00DC6C
.writeback_index_ready:
        ADD.W   D0,D0                           ; $00DC70
        MOVE.W  D0,D1                           ; $00DC72
        ADD.W   D0,D0                           ; $00DC74
        ADD.W   D0,D0                           ; $00DC76
        ADD.W   D1,D0                           ; $00DC78
        LEA     $00FF2000,A0                    ; $00DC7A
        MOVE.W  (-24550).W,$00(A0,D0.W)         ; $00DC80
        MOVE.W  (-24548).W,$02(A0,D0.W)         ; $00DC86
        MOVE.W  (-24546).W,$04(A0,D0.W)         ; $00DC8C
        MOVE.W  (-24544).W,$06(A0,D0.W)         ; $00DC92
        MOVE.W  (-24542).W,$08(A0,D0.W)         ; $00DC98
        MOVE.W  #$0020,$00FF0008                ; $00DC9E
        ADDQ.W  #4,(-14210).W                   ; $00DCA6
        RTS                                     ; $00DCAA
